import "jsr:@supabase/functions-js/edge-runtime.d.ts";

const ROLES = new Set(["FRANCHISOR_SUPERVISOR", "FRANCHISEE_ADMIN", "BRANCH_MANAGER", "EXECUTIVE", "TELLER", "VAULT_CUSTODIAN", "AUDITOR"]);
const PRIVILEGED = new Set(["FRANCHISOR_SUPERVISOR", "AUDITOR"]);
const ORGANIZATION_ROLES = new Set(["FRANCHISEE_ADMIN", "EXECUTIVE"]);
const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const authKey = Deno.env.get("SUPABASE_ANON_KEY") || serviceKey;

const headers = { "content-type": "application/json; charset=utf-8", "cache-control": "no-store", "x-content-type-options": "nosniff", "referrer-policy": "no-referrer" };
const response = (body: unknown, status = 200) => new Response(JSON.stringify(body), { status, headers });

async function db(table: string, query = "", options: { method?: string; body?: unknown; prefer?: string } = {}) {
  const result = await fetch(`${supabaseUrl}/rest/v1/${table}${query}`, {
    method: options.method || "GET",
    headers: { apikey: serviceKey, authorization: `Bearer ${serviceKey}`, "content-type": "application/json", prefer: options.prefer || "return=representation" },
    body: options.body === undefined ? undefined : JSON.stringify(options.body),
  });
  const text = await result.text();
  let data: any = null;
  try { data = text ? JSON.parse(text) : null; } catch { data = { message: text }; }
  if (!result.ok) throw new Error(data?.message || `supabase_${result.status}`);
  return data;
}

async function authUser(request: Request) {
  const token = request.headers.get("authorization") || "";
  if (!token.startsWith("Bearer ")) return null;
  const result = await fetch(`${supabaseUrl}/auth/v1/user`, { headers: { apikey: authKey, authorization: token } });
  return result.ok ? result.json() : null;
}

async function context(request: Request) {
  const user = await authUser(request);
  if (!user?.id) return null;
  const [legacyRows, assignments, branchRows] = await Promise.all([
    db("aryp_memberships", `?select=user_id,role,branch_ids,enabled&user_id=eq.${encodeURIComponent(user.id)}&enabled=eq.true&limit=1`),
    db("aryp_user_memberships", `?select=id,user_id,organization_id,branch_id,role_key,is_primary,enabled&user_id=eq.${encodeURIComponent(user.id)}&enabled=eq.true&order=is_primary.desc,created_at.asc`),
    db("aryp_branches", "?select=id,organization_id,status&status=eq.ACTIVE")
  ]);
  const activeAssignments = (assignments || []).filter((item: any) => ROLES.has(item.role_key));
  let member: any = null;
  if (activeAssignments.length) {
    const roles = [...new Set(activeAssignments.map((item: any) => item.role_key))] as string[];
    const organizationIds = [...new Set(activeAssignments.map((item: any) => item.organization_id))] as string[];
    const networkAccess = roles.some((role) => PRIVILEGED.has(role));
    const branchIds = new Set(activeAssignments.map((item: any) => item.branch_id).filter(Boolean));
    for (const assignment of activeAssignments) {
      if ((!assignment.branch_id || roles.some((role) => ORGANIZATION_ROLES.has(role))) && assignment.organization_id) {
        for (const branch of branchRows || []) if (branch.organization_id === assignment.organization_id) branchIds.add(branch.id);
      }
    }
    member = { user_id: user.id, role: activeAssignments[0].role_key, roles, organization_ids: organizationIds, branch_ids: [...branchIds], network_access: networkAccess, assignments: activeAssignments, enabled: true };
  } else {
    const legacy = legacyRows?.[0];
    member = legacy ? { ...legacy, roles: [legacy.role], organization_ids: [], network_access: PRIVILEGED.has(legacy.role), assignments: [] } : null;
  }
  return member && ROLES.has(member.role) ? { user, member } : null;
}

function hasRole(member: any, role: string) { return (member.roles || [member.role]).includes(role); }
function isPrivileged(member: any) { return Boolean(member.network_access) || (member.roles || [member.role]).some((role: string) => PRIVILEGED.has(role)); }
function canSee(member: any, branchId: string) { return isPrivileged(member) || (member.branch_ids || []).includes(branchId); }
function can(member: any, roles: string[]) { return roles.some((role) => hasRole(member, role)); }
function correlation(request: Request) { const id = request.headers.get("x-correlation-id") || ""; return /^[A-Za-z0-9._:-]{1,96}$/.test(id) ? id : `COR-${crypto.randomUUID()}`; }

async function seed() { const rows = await db("aryp_demo_seed", "?select=payload&dataset_id=eq.ARYP-DEMO-SEED-001&limit=1"); return rows?.[0]?.payload || { meta: {}, branches: [], customers: [], pledges: [] }; }
async function state() { const rows = await db("aryp_demo_state", "?select=*&id=eq.DEMO&limit=1"); return rows?.[0]; }
async function activeFormula() { const rows = await db("aryp_formula_versions", "?select=*&formula_key=eq.FINANCING_DEFAULT&status=eq.ACTIVE&order=effective_from.desc&limit=1"); return rows?.[0] || null; }
function roundCents(value: number) { return Math.round((value + Number.EPSILON) * 100) / 100; }
function financingAmount(netMarketValue: number, formula: any) {
  const parameters = formula?.parameters || {};
  const raw = netMarketValue * Number(parameters.margin_rate || 0);
  return parameters.financing_rounding === "RM0.05_FLOOR" ? Math.floor(raw * 20) / 20 : roundCents(raw);
}
function upahSimpanAmounts(netMarketValue: number, formula: any, days = 1) {
  const parameters = formula?.parameters || {};
  const rateMonthly = Number(parameters.upah_simpan_rate_monthly || 0);
  const annualizationMonths = Number(parameters.annualization_months || 12);
  const dayBasis = Number(parameters.day_basis || 365);
  const minimumDays = Number(parameters.minimum_days || 15);
  const maximumDays = Number(parameters.maximum_days || 120);
  const dailyRaw = netMarketValue * rateMonthly * annualizationMonths / dayBasis;
  const chargeDays = Math.max(1, Math.min(Number(days) || 1, maximumDays));
  return {
    base: parameters.upah_simpan_base || "NET_MARKET_VALUE",
    rate_monthly: rateMonthly,
    annualization_months: annualizationMonths,
    day_basis: dayBasis,
    daily: roundCents(dailyRaw),
    minimum_days: minimumDays,
    minimum_amount: roundCents(dailyRaw * minimumDays),
    days: chargeDays,
    period_amount: roundCents(dailyRaw * chargeDays),
    rounding: parameters.upah_simpan_rounding || "RM0.01_FINAL",
  };
}
async function activeDataPolicy() { const rows = await db("aryp_data_policies", "?select=*&policy_key=eq.DATA_LIFECYCLE_DEFAULT&status=eq.ACTIVE&order=effective_from.desc&limit=1"); return rows?.[0] || null; }
async function activePrivacyPolicy() { const rows = await db("aryp_privacy_policies", "?select=*&policy_key=eq.PRIVACY_DEFAULT&status=eq.ACTIVE&order=effective_from.desc&limit=1"); return rows?.[0] || null; }
async function activeRegulatoryRules() { return await db("aryp_regulatory_rules", "?select=*&status=eq.ACTIVE&order=domain.asc,effective_from.desc") || []; }
async function activeNfrPolicies() { return await db("aryp_nfr_policies", "?select=*&status=eq.ACTIVE&order=domain.asc,effective_from.desc") || []; }
async function activeDeploymentPolicy() { const rows = await db("aryp_deployment_policies", "?select=*&policy_key=eq.DEPLOYMENT_DEFAULT&status=eq.ACTIVE&order=effective_from.desc&limit=1"); return rows?.[0] || null; }
async function activeReleaseGates() { return await db("aryp_release_gates", "?select=*&order=gate_key.asc") || []; }
async function organizationStructure(member: any) {
  const [organizations, branches] = await Promise.all([
    db("aryp_organizations", "?select=id,organization_type,parent_organization_id,code,name,legal_name,status,timezone&status=eq.ACTIVE&order=organization_type.asc,code.asc"),
    db("aryp_branches", "?select=id,organization_id,code,name,status,timezone&status=eq.ACTIVE&order=code.asc")
  ]);
  const visibleBranches = (branches || []).filter((branch: any) => canSee(member, branch.id));
  if (isPrivileged(member)) return { scope: "NETWORK", organizations: organizations || [], branches: visibleBranches };
  const visibleOrgIds = new Set([...(member.organization_ids || [])]);
  for (const branch of visibleBranches) visibleOrgIds.add(branch.organization_id);
  const visibleOrganizations = (organizations || []).filter((org: any) => visibleOrgIds.has(org.id) || visibleOrgIds.has(org.parent_organization_id));
  return { scope: "ASSIGNED_SCOPE", organizations: visibleOrganizations, branches: visibleBranches };
}
function syntheticNotifications(payload: any, member: any) {
  const visibleBranches = (payload.branches || []).map((branch: any) => branch.id).filter((id: string) => isPrivileged(member) || (member.branch_ids || []).includes(id));
  return visibleBranches.flatMap((branchId: string, index: number) => [
    { id: `NTF-${String(index * 4 + 1).padStart(3, "0")}`, branch_id: branchId, event: "SIX_MONTH_NOTICE", channel: "SMS", destination_masked: "+60•••1234", status: "DELIVERED_SIMULATED", template_version: "NOTICE-6M-ASSUMED-0.1", sent_at: "2026-08-17T08:30:00.000Z", evidence: "MOCK_PROVIDER_RECEIPT" },
    { id: `NTF-${String(index * 4 + 2).padStart(3, "0")}`, branch_id: branchId, event: "TEN_MONTH_FINAL_NOTICE", channel: "SMS+EMAIL", destination_masked: "+60•••1234 / c•••@example.test", status: "FAILED_SIMULATED", template_version: "NOTICE-10M-ASSUMED-0.1", sent_at: "2026-08-17T08:32:00.000Z", evidence: "MOCK_PROVIDER_FAILURE" },
    { id: `NTF-${String(index * 4 + 3).padStart(3, "0")}`, branch_id: branchId, event: "REDEMPTION_RECEIPT", channel: "EMAIL", destination_masked: "c•••@example.test", status: "RECEIVED_SIMULATED", template_version: "RECEIPT-ASSUMED-0.1", sent_at: "2026-08-17T08:35:00.000Z", evidence: "MOCK_PROVIDER_RECEIPT" },
    { id: `NTF-${String(index * 4 + 4).padStart(3, "0")}`, branch_id: branchId, event: "SYSTEM_ALERT", channel: "IN_APP", destination_masked: "ROLE_SCOPED", status: "QUEUED_SIMULATED", template_version: "ALERT-ASSUMED-0.1", sent_at: null, evidence: "AUDIT_CORRELATION_REQUIRED" },
  ]);
}
function syntheticReportSummary(payload: any, demo: any, member: any) {
  const pledges = (payload.pledges || []).filter((item: any) => canSee(member, item.branch_id));
  const customers = (payload.customers || []).filter((item: any) => canSee(member, item.branch_id));
  const financing = pledges.reduce((sum: number, item: any) => sum + Number(item.simulated_financing || 0), 0);
  return { report_key: "OPERATIONS_SUMMARY", classification: "DEMO—NOT PRODUCTION", freshness: "SIMULATED_NOW", generated_at: new Date().toISOString(), timezone: "Asia/Kuala_Lumpur", scope: isPrivileged(member) ? "NETWORK" : "BRANCH_SCOPED", metrics: { customers: customers.length, pledges: pledges.length, financing_simulated: Math.round(financing * 100) / 100, cash_balance_simulated: Number(demo.cash_balance), active_pledges: pledges.filter((item: any) => ["ACTIVE", "PLEDGED_ACTIVE"].includes(item.state)).length, overdue_pledges: pledges.filter((item: any) => item.state === "OVERDUE").length, notification_records: syntheticNotifications(payload, member).length }, monthly_history: syntheticYearlyHistory(payload, member), export_policy: { formats: ["CSV", "PDF", "XLSX"], masking: "MASKED_BY_DEFAULT", password_protection: "PENDING_CLIENT", audit_download: true } };
}
function syntheticYearlyHistory(payload: any, member: any) {
  const rows = (payload.branch_monthly_metrics || []).filter((item: any) => isPrivileged(member) || (member.branch_ids || []).includes(item.branch_id));
  const grouped = new Map<string, any>();
  for (const row of rows) {
    const period = String(row.period || "");
    if (!period) continue;
    const current = grouped.get(period) || { period, customers_new: 0, pledges_count: 0, redemptions_count: 0, auction_count: 0, financing_amount: 0, cash_in: 0, cash_out: 0, overdue_count: 0, branches_reporting: 0 };
    current.customers_new += Number(row.customers_new || 0);
    current.pledges_count += Number(row.pledges_count || 0);
    current.redemptions_count += Number(row.redemptions_count || 0);
    current.auction_count += Number(row.auction_count || 0);
    current.financing_amount += Number(row.financing_amount || 0);
    current.cash_in += Number(row.cash_in || 0);
    current.cash_out += Number(row.cash_out || 0);
    current.overdue_count += Number(row.overdue_count || 0);
    current.branches_reporting += 1;
    grouped.set(period, current);
  }
  const months = [...grouped.values()].sort((a, b) => a.period.localeCompare(b.period)).map((item) => Object.fromEntries(Object.entries(item).map(([key, value]) => [key, typeof value === "number" ? Math.round(value * 100) / 100 : value])));
  return { period_type: "MONTH", period_count: months.length, start_period: months[0]?.period || null, end_period: months.at(-1)?.period || null, state: "SIMULATION_ONLY", months };
}
function syntheticCases(payload: any, member: any) {
  const visibleBranches = (payload.branches || []).map((branch: any) => branch.id).filter((id: string) => isPrivileged(member) || (member.branch_ids || []).includes(id));
  return visibleBranches.flatMap((branchId: string, index: number) => [
    { id: `CASE-${String(index * 3 + 1).padStart(3, "0")}`, branch_id: branchId, category: "CUSTOMER_IDENTITY", priority: "HIGH", state: "OPEN_SIMULATED", owner_role: "BRANCH_MANAGER", sla: "PENDING_CLIENT", evidence: ["IDENTITY_DOCUMENT_REVIEW"] },
    { id: `CASE-${String(index * 3 + 2).padStart(3, "0")}`, branch_id: branchId, category: "PRIVACY_DSR", priority: "MEDIUM", state: "IN_REVIEW_SIMULATED", owner_role: "AUDITOR", sla: "PENDING_CLIENT", evidence: ["REQUEST_LOG", "IDENTITY_PROOF_PENDING"] },
    { id: `CASE-${String(index * 3 + 3).padStart(3, "0")}`, branch_id: branchId, category: "INTEGRATION_FAILURE", priority: "LOW", state: "RESOLVED_SIMULATED", owner_role: "SUPPORT", sla: "PENDING_CLIENT", evidence: ["MOCK_PROVIDER_LOG"] },
  ]);
}
function syntheticValuation(payload: any, member: any) {
  const allowed = (member.branch_ids || []);
  const items = (payload.marhun_items || []).filter((item: any) => isPrivileged(member) || allowed.includes(item.branch_id));
  return { source: "FIXTURE_ONLY", status: "PROVISIONAL", prices: (payload.gold_prices || []).map((item: any) => ({ purity: item.purity, price_per_gram: Number(item.price_per_gram), effective_at: item.effective_at, source: item.source, state: item.state })), items: items.map((item: any) => ({ id: item.id, description: item.description, purity: item.purity, weight_grams: Number(item.weight_grams), simulated_nm: Number(item.simulated_nm), valuation_state: item.valuation_state })) };
}
function syntheticFinanceSummary(payload: any, member: any) {
  const branchIds = new Set(member.branch_ids || []);
  const visible = (item: any) => isPrivileged(member) || branchIds.has(item.branch_id);
  const drawers = (payload.cash_drawers || []).filter(visible);
  const ledger = (payload.ledger_entries || []).filter(visible);
  const payments = (payload.payments || []).filter((item: any) => !item.branch_id || isPrivileged(member) || branchIds.has(item.branch_id));
  const vault = (payload.vault_movements || []).filter(visible);
  const auctions = (payload.auctions || []).filter(visible);
  return { classification: "DEMO—NOT PRODUCTION", state: "SIMULATION_ONLY", business_date: drawers[0]?.business_date || "PENDING_CLIENT", cash_drawers: drawers, ledger_entries: ledger, payments, vault_movements: vault, auctions, totals: { payment_count: payments.length, payment_amount: Math.round(payments.reduce((sum: number, item: any) => sum + Number(item.amount || 0), 0) * 100) / 100, drawer_variance: Math.round(drawers.reduce((sum: number, item: any) => sum + Number(item.variance || 0), 0) * 100) / 100, vault_movement_count: vault.length, auction_count: auctions.length } };
}
function syntheticDocuments(payload: any, member: any) {
  const branchIds = new Set(member.branch_ids || []);
  const pledgeBranches = new Map((payload.pledges || []).map((item: any) => [item.id, item.branch_id]));
  const customerBranches = new Map((payload.customers || []).map((item: any) => [item.id, item.branch_id]));
  return (payload.documents || []).filter((item: any) => { const branch = item.pledge_id ? pledgeBranches.get(item.pledge_id) : customerBranches.get(item.customer_id); return isPrivileged(member) || branchIds.has(branch); });
}
function syntheticHeirs(payload: any, member: any) {
  const branchIds = new Set(member.branch_ids || []);
  const customerBranches = new Map((payload.customers || []).map((item: any) => [item.id, item.branch_id]));
  return (payload.heirs || []).filter((item: any) => isPrivileged(member) || branchIds.has(customerBranches.get(item.customer_id)));
}
async function patchState(values: Record<string, unknown>) { const rows = await db("aryp_demo_state", "?id=eq.DEMO", { method: "PATCH", body: { ...values, updated_at: new Date().toISOString() } }); return rows?.[0]; }
async function patchGate(gateKey: string, values: Record<string, unknown>) { const rows = await db("aryp_release_gates", `?gate_key=eq.${encodeURIComponent(gateKey)}`, { method: "PATCH", body: { ...values, updated_at: new Date().toISOString() } }); return rows?.[0]; }
async function audit(request: Request, ctx: any, action: string, result: string, detail: Record<string, unknown> = {}, branchId = "BR-001") { await db("aryp_audit_events", "", { method: "POST", body: { correlation_id: correlation(request), actor_user_id: ctx.user.id, actor_role: ctx.member.role, branch_id: branchId, action, result, detail, state: "SIMULATION" } }); }
async function auditRows(ctx: any) { const rows = await db("aryp_audit_events", "?select=*&order=created_at.desc&limit=30"); return (rows || []).filter((event: any) => canSee(ctx.member, event.branch_id)).reverse(); }
function history(payload: any, customerId: string) {
  const customer = (payload.customers || []).find((item: any) => item.id === customerId); if (!customer) return [];
  const result = (payload.pledges || []).filter((item: any) => item.customer_id === customerId).map((item: any) => ({ label: `${item.state === "OVERDUE" ? "Gadaian tertunggak" : "Gadaian aktif"} · RM${Number(item.simulated_financing).toLocaleString("ms-MY", { minimumFractionDigits: 2 })}`, detail: `${item.id} · ${item.branch_id}`, state: item.state }));
  if (customer.risk_state === "REPEAT_REVIEW") result.push({ label: "Semakan repeat customer diperlukan", detail: "Fixture risk · polisi provisional", state: "REPEAT_REVIEW" });
  if (customer.risk_state === "BLACKLIST_REVIEW") result.push({ label: "Risk hold · BLACKLIST_REVIEW", detail: "Tiada bypass dibenarkan", state: "BLACKLIST_REVIEW" });
  return result;
}
async function snapshot(ctx: any) {
  const [payload, demo, auditEvents, formula, dataPolicy, privacyPolicy, regulatoryRules, nfrPolicies, deploymentPolicy, releaseGates, organization] = await Promise.all([seed(), state(), auditRows(ctx), activeFormula(), activeDataPolicy(), activePrivacyPolicy(), activeRegulatoryRules(), activeNfrPolicies(), activeDeploymentPolicy(), activeReleaseGates(), organizationStructure(ctx.member)]);
  const notificationItems = syntheticNotifications(payload, ctx.member);
  const caseItems = syntheticCases(payload, ctx.member);
  const financeSummary = syntheticFinanceSummary(payload, ctx.member);
  const documentItems = syntheticDocuments(payload, ctx.member);
  const heirItems = syntheticHeirs(payload, ctx.member);
  const visible = (item: any) => canSee(ctx.member, item.branch_id);
  const visibleCustomers = (payload.customers || []).filter(visible);
  const visiblePledges = (payload.pledges || []).filter(visible);
  const valuation = syntheticValuation(payload, ctx.member);
  const yearlyHistory = syntheticYearlyHistory(payload, ctx.member);
  return { meta: payload.meta, formula, dataPolicy, privacyPolicy, regulatoryRules, nfrPolicies, deploymentPolicy, releaseGates, organization, yearlyHistory, notifications: notificationItems, reportSummary: syntheticReportSummary(payload, demo, ctx.member), cases: caseItems, valuation, financeSummary, documents: documentItems, heirs: heirItems, demo: { role: ctx.member.role, roles: ctx.member.roles, organizationIds: ctx.member.organization_ids, branchIds: ctx.member.branch_ids, pledge: demo.pledge_state, cashBalance: Number(demo.cash_balance), customerFixture: demo.customer_fixture, customerRisk: demo.customer_risk, customerReview: demo.customer_review, customerHistory: demo.customer_history || [], vault: demo.vault_state, vaultAcceptance: demo.vault_acceptance || {}, auction: demo.auction_state, reportPath: demo.report_path, dayEnd: demo.day_end, completion: demo.completion, formulaKey: demo.formula_key, formulaVersion: demo.formula_version, approvalState: demo.approval_state, makerUserId: demo.maker_user_id, approverUserId: demo.approver_user_id, retentionPolicyKey: demo.retention_policy_key, retentionPolicyVersion: demo.retention_policy_version, legalHoldState: demo.legal_hold_state, legalHoldReason: demo.legal_hold_reason, legalHoldUserId: demo.legal_hold_user_id, privacyPolicyKey: demo.privacy_policy_key, privacyPolicyVersion: demo.privacy_policy_version, consentState: demo.consent_state, consentRecordedAt: demo.consent_recorded_at, consentUserId: demo.consent_user_id, privacyRequestType: demo.privacy_request_type, privacyRequestState: demo.privacy_request_state, privacyRequestUserId: demo.privacy_request_user_id }, actor: ctx.member.role, counts: { customers: visibleCustomers.length, pledges: visiblePledges.length, branches: organization.branches.length, notifications: notificationItems.length, cases: caseItems.length, valuation_items: valuation.items.length, ledger_entries: financeSummary.ledger_entries.length, documents: documentItems.length, heirs: heirItems.length }, audit: auditEvents };
}

async function action(request: Request, ctx: any, input: any) {
  const payload = await seed(); const demo = await state(); const name = input.action;
  const customer = (id: string) => (payload.customers || []).find((item: any) => item.id === id);
  const pledge = (id: string) => (payload.pledges || []).find((item: any) => item.id === id);
  const fail = async (status: number, error: string, detail: Record<string, unknown> = {}, branch = "BR-001") => { await audit(request, ctx, name, "DENIED", { reason: error, ...detail }, branch); return response({ error, ...(await snapshot(ctx)) }, status); };
  const ok = async (detail: Record<string, unknown> = {}, branch = "BR-001") => { await audit(request, ctx, name, "ALLOWED", detail, branch); return response({ ...(await snapshot(ctx)), action_result: detail }); };
  if (name === "reset_demo") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR", "EXECUTIVE", "AUDITOR"])) return fail(403, "demo_reset_role_required"); await patchState({ pledge_state: "PENDING_SIGNATURE", cash_balance: 37580, customer_fixture: "CUS-001", customer_risk: "CLEAR", customer_review: "NONE", customer_history: [], vault_state: "PENDING", vault_acceptance: {}, auction_state: "READY", report_path: "FR-001", day_end: "OPEN", completion: "PENDING", maker_user_id: null, approver_user_id: null, approval_state: "PENDING_SIGNATURE", legal_hold_state: "NOT_APPLIED", legal_hold_reason: null, legal_hold_user_id: null, consent_state: "NOT_CAPTURED", consent_recorded_at: null, consent_user_id: null, privacy_request_type: null, privacy_request_state: "NONE", privacy_request_user_id: null }); return ok({ reset: true }); }
  if (name === "load_customer") { const item = customer(input.customerId); if (!item) return fail(404, "customer_not_found"); if (!canSee(ctx.member, item.branch_id)) return fail(403, "tenant_boundary", { customer_id: item.id }, item.branch_id); await patchState({ customer_fixture: item.id, customer_risk: item.risk_state, customer_review: "NONE", customer_history: history(payload, item.id) }); return ok({ customer_id: item.id, risk_state: item.risk_state }, item.branch_id); }
  if (name === "risk_review") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR"])) return fail(403, "risk_reviewer_role_required"); const item = customer(input.customerId || demo.customer_fixture); if (!item) return fail(404, "customer_not_found"); if (!canSee(ctx.member, item.branch_id)) return fail(403, "tenant_boundary", { customer_id: item.id }, item.branch_id); await patchState({ customer_fixture: item.id, customer_risk: item.risk_state, customer_history: history(payload, item.id) }); if (item.risk_state === "BLACKLIST_REVIEW") return fail(409, "blacklist_hold", { customer_id: item.id }, item.branch_id); await patchState({ customer_review: "REVIEWED_SIMULATED" }); return ok({ customer_id: item.id, risk_state: item.risk_state }, item.branch_id); }
  if (name === "submit_pledge") { if (!can(ctx.member, ["TELLER", "BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR"])) return fail(403, "maker_role_required"); const item = pledge(input.pledgeId || "PLG-001"); if (!item) return fail(404, "pledge_not_found"); if (!canSee(ctx.member, item.branch_id)) return fail(403, "tenant_boundary", { pledge_id: item.id }, item.branch_id); await patchState({ pledge_state: "PENDING_SIGNATURE", maker_user_id: ctx.user.id, approver_user_id: null, approval_state: "PENDING_SIGNATURE" }); return ok({ pledge_id: item.id, maker_user_id: ctx.user.id }, item.branch_id); }
  if (name === "approve_pledge" || name === "reject_pledge") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR"])) return fail(403, "maker_checker_required"); const item = pledge(input.pledgeId || "PLG-001"); if (!item) return fail(404, "pledge_not_found"); if (!canSee(ctx.member, item.branch_id)) return fail(403, "tenant_boundary", { pledge_id: item.id }, item.branch_id); if (demo.maker_user_id && demo.maker_user_id === ctx.user.id) return fail(403, "maker_cannot_self_approve", { pledge_id: item.id }, item.branch_id); await patchState({ pledge_state: name === "approve_pledge" ? "APPROVED" : "REJECTED", approver_user_id: ctx.user.id, approval_state: name === "approve_pledge" ? "APPROVED" : "REJECTED" }); return ok({ pledge_id: item.id, reason: input.reason || null, approver_user_id: ctx.user.id }, item.branch_id); }
  if (name === "quote_financing") { const item = pledge(input.pledgeId || "PLG-001"); if (!item) return fail(404, "pledge_not_found"); if (!canSee(ctx.member, item.branch_id)) return fail(403, "tenant_boundary", { pledge_id: item.id }, item.branch_id); const formula = await activeFormula(); const marketValue = Number(input.marketValue ?? 3907.44); const days = Number(input.days ?? 1); if (!formula || !Number.isFinite(marketValue) || marketValue <= 0 || !Number.isFinite(days) || days < 1 || days > 120) return fail(400, "invalid_market_value_or_days"); const margin = Number(formula.parameters?.margin_rate || 0); const amount = financingAmount(marketValue, formula); const upahSimpan = upahSimpanAmounts(marketValue, formula, days); return ok({ pledge_id: item.id, market_value: marketValue, margin_rate: margin, financing_amount: amount, upah_simpan: upahSimpan, formula_key: formula.formula_key, formula_version: formula.version, classification: formula.classification }, item.branch_id); }
  if (name === "place_legal_hold") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR", "AUDITOR"])) return fail(403, "legal_hold_role_required"); const reason = String(input.reason || "").trim().slice(0, 240); if (reason.length < 3) return fail(400, "legal_hold_reason_required"); const item = pledge(input.pledgeId || "PLG-001"); if (!item) return fail(404, "pledge_not_found"); if (!canSee(ctx.member, item.branch_id)) return fail(403, "tenant_boundary", { pledge_id: item.id }, item.branch_id); await patchState({ legal_hold_state: "ACTIVE", legal_hold_reason: reason, legal_hold_user_id: ctx.user.id }); return ok({ pledge_id: item.id, legal_hold_state: "ACTIVE", reason }, item.branch_id); }
  if (name === "release_legal_hold") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR"])) return fail(403, "legal_hold_release_role_required"); const item = pledge(input.pledgeId || "PLG-001"); if (!item) return fail(404, "pledge_not_found"); if (!canSee(ctx.member, item.branch_id)) return fail(403, "tenant_boundary", { pledge_id: item.id }, item.branch_id); if (demo.legal_hold_state !== "ACTIVE") return fail(409, "legal_hold_not_active", { pledge_id: item.id }, item.branch_id); await patchState({ legal_hold_state: "RELEASED", legal_hold_user_id: ctx.user.id }); return ok({ pledge_id: item.id, legal_hold_state: "RELEASED" }, item.branch_id); }
  if (name === "record_privacy_consent") { if (!can(ctx.member, ["TELLER", "BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR"])) return fail(403, "consent_recorder_role_required"); const item = customer(input.customerId || demo.customer_fixture); if (!item) return fail(404, "customer_not_found"); if (!canSee(ctx.member, item.branch_id)) return fail(403, "tenant_boundary", { customer_id: item.id }, item.branch_id); await patchState({ customer_fixture: item.id, consent_state: "RECORDED_SIMULATED", consent_recorded_at: new Date().toISOString(), consent_user_id: ctx.user.id }); return ok({ customer_id: item.id, consent_state: "RECORDED_SIMULATED" }, item.branch_id); }
  if (name === "withdraw_privacy_consent") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR"])) return fail(403, "consent_withdrawal_role_required"); const item = customer(input.customerId || demo.customer_fixture); if (!item) return fail(404, "customer_not_found"); if (!canSee(ctx.member, item.branch_id)) return fail(403, "tenant_boundary", { customer_id: item.id }, item.branch_id); await patchState({ customer_fixture: item.id, consent_state: "WITHDRAWN_SIMULATED", consent_recorded_at: new Date().toISOString(), consent_user_id: ctx.user.id }); return ok({ customer_id: item.id, consent_state: "WITHDRAWN_SIMULATED" }, item.branch_id); }
  if (name === "privacy_dsr_request") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR", "AUDITOR"])) return fail(403, "dsr_role_required"); const item = customer(input.customerId || demo.customer_fixture); if (!item) return fail(404, "customer_not_found"); if (!canSee(ctx.member, item.branch_id)) return fail(403, "tenant_boundary", { customer_id: item.id }, item.branch_id); const requestType = String(input.requestType || "ACCESS").toUpperCase(); if (!["ACCESS", "RECTIFICATION", "ERASURE", "RESTRICTION"].includes(requestType)) return fail(400, "invalid_dsr_request_type"); await patchState({ customer_fixture: item.id, privacy_request_type: requestType, privacy_request_state: "REQUESTED_SIMULATED", privacy_request_user_id: ctx.user.id }); return ok({ customer_id: item.id, request_type: requestType, request_state: "REQUESTED_SIMULATED", erasure_mode: "DISABLED_IN_DEMO" }, item.branch_id); }
  if (name === "regulatory_gap_review") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR", "EXECUTIVE", "AUDITOR"])) return fail(403, "regulatory_review_role_required"); const ruleKey = String(input.ruleKey || "").trim(); const rules = await activeRegulatoryRules(); const rule = rules.find((item: any) => item.rule_key === ruleKey); if (!rule) return fail(404, "regulatory_rule_not_found", { rule_key: ruleKey }); return ok({ rule_key: rule.rule_key, version: rule.version, applicability_status: rule.applicability_status, source_reference: rule.source_reference, decision: "PENDING_CLIENT", evidence_required: Boolean(rule.parameters?.evidence_required) }); }
  if (name === "record_nfr_observation") { if (!can(ctx.member, ["FRANCHISOR_SUPERVISOR", "EXECUTIVE", "AUDITOR"])) return fail(403, "nfr_observation_role_required"); const nfrKey = String(input.nfrKey || "").trim(); const policies = await activeNfrPolicies(); const policy = policies.find((item: any) => item.nfr_key === nfrKey); if (!policy) return fail(404, "nfr_policy_not_found", { nfr_key: nfrKey }); const metric = String(input.metric || "").trim().slice(0, 64); const value = Number(input.value); if (!metric || !Number.isFinite(value) || value < 0 || value > 1e12) return fail(400, "invalid_nfr_observation"); const unit = String(input.unit || "unitless").trim().slice(0, 24); return ok({ nfr_key: nfrKey, version: policy.version, metric, value, unit, observation_state: "RECORDED_SIMULATED", acceptance: "PENDING_CLIENT" }); }
  if (name === "queue_notification") { if (!can(ctx.member, ["TELLER", "BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR"])) return fail(403, "notification_queue_role_required"); const event = String(input.event || "").trim().toUpperCase(); const channel = String(input.channel || "IN_APP").trim().toUpperCase(); if (!["PAYMENT_RECEIPT", "SIX_MONTH_NOTICE", "TEN_MONTH_FINAL_NOTICE", "AUCTION_NOTICE", "SYSTEM_ALERT"].includes(event)) return fail(400, "invalid_notification_event"); if (!["SMS", "EMAIL", "SMS+EMAIL", "IN_APP"].includes(channel)) return fail(400, "invalid_notification_channel"); const destination = String(input.destinationMasked || "ROLE_SCOPED").trim().slice(0, 120); if (!destination || /[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/.test(destination)) return fail(400, "masked_destination_required"); return ok({ notification_id: `NTF-SIM-${crypto.randomUUID().slice(0, 8).toUpperCase()}`, event, channel, destination_masked: destination, status: "QUEUED_SIMULATED", template_version: "ASSUMED-NOTIFICATION-0.1", provider: "MOCK_PROVIDER", evidence_required: true }); }
  if (name === "retry_notification") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR"])) return fail(403, "notification_retry_role_required"); const notificationId = String(input.notificationId || "").trim().slice(0, 64); if (!/^NTF-[A-Z0-9-]+$/.test(notificationId)) return fail(400, "invalid_notification_id"); return ok({ notification_id: notificationId, status: "RETRY_QUEUED_SIMULATED", provider: "MOCK_PROVIDER", idempotency_key: `RETRY-${notificationId}` }); }
  if (name === "open_case") { if (!can(ctx.member, ["TELLER", "BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR", "AUDITOR"])) return fail(403, "case_open_role_required"); const category = String(input.category || "").trim().toUpperCase(); const priority = String(input.priority || "MEDIUM").trim().toUpperCase(); if (!["CUSTOMER_IDENTITY", "PRIVACY_DSR", "FRAUD_REVIEW", "INTEGRATION_FAILURE", "SUPPORT_REQUEST", "VAULT_EXCEPTION"].includes(category)) return fail(400, "invalid_case_category"); if (!["LOW", "MEDIUM", "HIGH", "CRITICAL"].includes(priority)) return fail(400, "invalid_case_priority"); const title = String(input.title || "Simulation case").trim().slice(0, 160); if (title.length < 3) return fail(400, "case_title_required"); return ok({ case_id: `CASE-SIM-${crypto.randomUUID().slice(0, 8).toUpperCase()}`, category, priority, title, state: "OPEN_SIMULATED", owner_role: ctx.member.role, sla: "PENDING_CLIENT", evidence_required: true }); }
  if (name === "resolve_case") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR", "AUDITOR"])) return fail(403, "case_resolve_role_required"); const caseId = String(input.caseId || "").trim().slice(0, 64); if (!/^CASE-[A-Z0-9-]+$/.test(caseId)) return fail(400, "invalid_case_id"); const resolution = String(input.resolution || "").trim().slice(0, 300); if (resolution.length < 3) return fail(400, "case_resolution_required"); return ok({ case_id: caseId, state: "RESOLVED_SIMULATED", resolution, evidence_snapshot: ["AUDIT_CORRELATION", "SIMULATION_NOTE"] }); }
  if (name === "calculate_valuation") { if (!can(ctx.member, ["TELLER", "BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR", "AUDITOR"])) return fail(403, "valuation_role_required"); const itemId = String(input.marhunId || "").trim(); const item = (payload.marhun_items || []).find((candidate: any) => candidate.id === itemId); if (!item) return fail(404, "marhun_item_not_found"); if (!canSee(ctx.member, item.branch_id)) return fail(403, "tenant_boundary", { marhun_id: item.id }, item.branch_id); const purity = String(input.purity || item.purity); const priceRow = (payload.gold_prices || []).find((candidate: any) => String(candidate.purity) === purity); const price = Number(input.pricePerGram ?? priceRow?.price_per_gram); const weight = Number(input.weightGrams ?? item.weight_grams); const days = Number(input.days ?? 1); const formula = await activeFormula(); const margin = Number(formula?.parameters?.margin_rate || 0); if (!priceRow && !Number.isFinite(price)) return fail(400, "gold_price_required"); if (!Number.isFinite(price) || price <= 0 || price > 100000 || !Number.isFinite(weight) || weight <= 0 || weight > 10000 || !Number.isFinite(days) || days < 1 || days > 120) return fail(400, "invalid_valuation_input"); const nm = roundCents(price * weight); const financing = financingAmount(nm, formula); const upahSimpan = upahSimpanAmounts(nm, formula, days); return ok({ calculation_snapshot_id: `CALC-SIM-${crypto.randomUUID().slice(0, 8).toUpperCase()}`, marhun_id: item.id, purity, price_per_gram: price, weight_grams: weight, net_market_value: nm, margin_rate: margin, financing_amount: financing, upah_simpan: upahSimpan, upah_simpan_daily: upahSimpan.daily, upah_simpan_minimum_days: upahSimpan.minimum_days, upah_simpan_minimum_amount: upahSimpan.minimum_amount, upah_simpan_period_amount: upahSimpan.period_amount, upah_simpan_rate_monthly: upahSimpan.rate_monthly, upah_simpan_base: upahSimpan.base, formula_key: formula?.formula_key || "FINANCING_DEFAULT", formula_version: formula?.version || "PENDING", formula_classification: formula?.classification || "PENDING", price_source: priceRow?.source || "MANUAL_OVERRIDE_SIMULATED", rounding: { net_market_value: "RM0.01", financing: formula?.parameters?.financing_rounding || "RM0.01", upah_simpan: upahSimpan.rounding }, state: "PROVISIONAL_SIMULATED" }, item.branch_id); }
  if (name === "cash_count") { if (!can(ctx.member, ["TELLER", "BRANCH_MANAGER", "AUDITOR"])) return fail(403, "cash_count_role_required"); const expected = Number(input.expectedBalance); const counted = Number(input.countedBalance); if (!Number.isFinite(expected) || !Number.isFinite(counted) || expected < 0 || counted < 0) return fail(400, "invalid_cash_count"); const variance = Math.round((counted - expected) * 100) / 100; if (Math.abs(variance) >= 0.005 && !String(input.reason || "").trim()) return fail(409, "cash_variance_reason_required", { variance }); return ok({ drawer_id: String(input.drawerId || "DRAWER-BR001-T01"), expected_balance: expected, counted_balance: counted, variance, state: Math.abs(variance) < 0.005 ? "MATCHED_SIMULATED" : "VARIANCE_REVIEW_SIMULATED", reason: String(input.reason || "") || null }); }
  if (name === "bank_in_simulated") { if (!can(ctx.member, ["TELLER", "BRANCH_MANAGER"])) return fail(403, "bank_in_role_required"); const amount = Number(input.amount); const slip = String(input.slipReference || "").trim().slice(0, 64); if (!Number.isFinite(amount) || amount <= 0 || amount > 1000000 || slip.length < 3) return fail(400, "bank_in_amount_and_slip_required"); return ok({ bank_in_id: `BANKIN-SIM-${crypto.randomUUID().slice(0, 8).toUpperCase()}`, amount, slip_reference: slip, status: "PENDING_RECONCILIATION_SIMULATED", provider: "MOCK_BANK" }); }
  if (name === "document_review") { if (!can(ctx.member, ["TELLER", "BRANCH_MANAGER", "AUDITOR"])) return fail(403, "document_review_role_required"); const documentId = String(input.documentId || "").trim(); const doc = (payload.documents || []).find((item: any) => item.id === documentId); if (!doc) return fail(404, "document_not_found"); const docBranch = doc.pledge_id ? (payload.pledges || []).find((item: any) => item.id === doc.pledge_id)?.branch_id : (payload.customers || []).find((item: any) => item.id === doc.customer_id)?.branch_id; if (!docBranch || !canSee(ctx.member, docBranch)) return fail(403, "tenant_boundary", { document_id: documentId }, docBranch || "BR-UNKNOWN"); if (!["APPROVED", "REJECTED", "REQUESTED"].includes(String(input.decision || "").toUpperCase())) return fail(400, "invalid_document_decision"); const evidence = String(input.evidence || "").trim().slice(0, 200); if (evidence.length < 3) return fail(400, "document_evidence_required"); return ok({ document_id: documentId, decision: String(input.decision).toUpperCase(), evidence, template_version: doc.version, state: "REVIEW_RECORDED_SIMULATED" }, docBranch); }
  if (name === "heir_claim_review") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR", "AUDITOR"])) return fail(403, "heir_review_role_required"); const heirId = String(input.heirId || "").trim(); const heir = (payload.heirs || []).find((item: any) => item.id === heirId); if (!heir) return fail(404, "heir_not_found"); const heirBranch = (payload.customers || []).find((item: any) => item.id === heir.customer_id)?.branch_id; if (!heirBranch || !canSee(ctx.member, heirBranch)) return fail(403, "tenant_boundary", { heir_id: heirId }, heirBranch || "BR-UNKNOWN"); const decision = String(input.decision || "").trim().toUpperCase(); const documentRef = String(input.documentRef || "").trim(); if (!["APPROVE", "REJECT", "HOLD"].includes(decision)) return fail(400, "invalid_heir_decision"); if (documentRef.length < 3) return fail(400, "heir_document_reference_required"); return ok({ heir_id: heirId, decision, document_reference: documentRef, state: decision === "HOLD" ? "PENDING_DOCUMENT_REVIEW" : `${decision}_SIMULATED`, identity_check: "SIMULATED_ONLY" }, heirBranch); }
  if (name === "export_report") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR", "EXECUTIVE", "AUDITOR"])) return fail(403, "report_export_role_required"); const reportKey = String(input.reportKey || "OPERATIONS_SUMMARY").trim().toUpperCase(); const format = String(input.format || "CSV").trim().toUpperCase(); if (reportKey !== "OPERATIONS_SUMMARY") return fail(404, "report_not_found"); if (!["CSV", "PDF", "XLSX"].includes(format)) return fail(400, "invalid_report_format"); const report = syntheticReportSummary(payload, demo, ctx.member); return ok({ report_key: reportKey, format, status: "READY_SIMULATED", filename: `${reportKey}-${new Date().toISOString().slice(0, 10)}.${format.toLowerCase()}`, masking: report.export_policy.masking, download: "DISABLED_IN_DEMO", audit_download: true }); }
  if (name === "review_release_gate") { if (!can(ctx.member, ["FRANCHISOR_SUPERVISOR", "EXECUTIVE", "AUDITOR"])) return fail(403, "release_gate_review_role_required"); const gateKey = String(input.gateKey || "").trim().toUpperCase(); if (!/^G(?:[1-9]|1[0-2])$/.test(gateKey)) return fail(400, "invalid_release_gate"); const gates = await activeReleaseGates(); const gate = gates.find((item: any) => item.gate_key === gateKey); if (!gate) return fail(404, "release_gate_not_found", { gate_key: gateKey }); const nextStatus = String(input.status || "IN_REVIEW").toUpperCase(); if (!["IN_REVIEW", "PASSED", "BLOCKED", "WAIVED"].includes(nextStatus)) return fail(400, "invalid_release_gate_status"); const note = String(input.note || "").trim().slice(0, 500); const evidence = Array.isArray(input.evidence) ? input.evidence.map((item: unknown) => String(item).trim().slice(0, 160)).filter(Boolean).slice(0, 20) : []; if ((nextStatus === "PASSED" || nextStatus === "WAIVED") && (!note || evidence.length === 0)) return fail(400, "gate_note_and_evidence_required", { gate_key: gateKey, status: nextStatus }); await patchGate(gateKey, { status: nextStatus, reviewer_user_id: ctx.user.id, review_note: note || null, evidence_snapshot: evidence, reviewed_at: new Date().toISOString() }); return ok({ gate_key: gateKey, status: nextStatus, production_release_allowed: false, state: "SIMULATION_ONLY" }); }
  if (name === "cash_out") { if (!can(ctx.member, ["TELLER", "BRANCH_MANAGER", "EXECUTIVE", "FRANCHISOR_SUPERVISOR"])) return fail(403, "cashier_role_required"); const amount = Number(input.amount || 2730); if (!Number.isFinite(amount) || amount <= 0 || amount > 100000) return fail(400, "invalid_amount"); if (demo.legal_hold_state === "ACTIVE") return fail(409, "legal_hold_active"); if (demo.pledge_state !== "APPROVED") return fail(409, "approval_required"); await patchState({ pledge_state: "CASH_OUT_SIMULATED", cash_balance: Number(demo.cash_balance) - amount }); return ok({ amount }); }
  if (name === "vault_checkin") { if (!can(ctx.member, ["VAULT_CUSTODIAN", "BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR"])) return fail(403, "vault_role_required"); if (demo.pledge_state !== "CASH_OUT_SIMULATED") return fail(409, "cash_out_required"); await patchState({ vault_state: "CHECKED_IN_SIMULATED", pledge_state: "PLEDGED_ACTIVE" }); return ok({ pledge_id: input.pledgeId || "PLG-001", location: "VAULT-A-01" }); }
  if (name === "vault_accept") { if (!can(ctx.member, ["VAULT_CUSTODIAN", "BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR"])) return fail(403, "vault_role_required"); const ref = String(input.reference || ""); if (!["0041", "0042"].includes(ref)) return fail(404, "unknown_vault_bag"); await patchState({ vault_acceptance: { ...(demo.vault_acceptance || {}), [ref]: "ACCEPTED_SIMULATED" } }); return ok({ reference: ref, location: ref === "0042" ? "VAULT-A-03-B12" : "VAULT-A-01" }); }
  if (name === "redemption") { if (!can(ctx.member, ["TELLER", "BRANCH_MANAGER", "EXECUTIVE", "FRANCHISOR_SUPERVISOR"])) return fail(403, "cashier_role_required"); if (demo.legal_hold_state === "ACTIVE") return fail(409, "legal_hold_active"); await patchState({ pledge_state: "REDEMPTION_SIMULATED" }); return ok({ pledge_id: input.pledgeId || "PLG-002", provider: "MOCK_PAYMENT" }); }
  if (name === "complete_pledge") { if (!can(ctx.member, ["BRANCH_MANAGER", "EXECUTIVE", "FRANCHISOR_SUPERVISOR"])) return fail(403, "completion_role_required"); if (demo.pledge_state !== "PLEDGED_ACTIVE") return fail(409, "vault_checkin_required"); await patchState({ completion: "COMPLETED_SIMULATED" }); return ok({ pledge_id: input.pledgeId || "PLG-001" }); }
  if (name === "stocktake") { if (!can(ctx.member, ["VAULT_CUSTODIAN", "BRANCH_MANAGER", "AUDITOR", "FRANCHISOR_SUPERVISOR"])) return fail(403, "stocktake_role_required"); await patchState({ vault_state: "STOCKTAKE_MATCHED" }); return ok({ matched: 4, variance: 0 }); }
  if (name === "vault_no_dual") return fail(403, "dual_control_required");
  if (name === "close_day") { if (!can(ctx.member, ["TELLER", "BRANCH_MANAGER", "EXECUTIVE", "FRANCHISOR_SUPERVISOR"])) return fail(403, "day_end_role_required"); const variance = Number(input.variance || 0); if (!input.checklist || !Number.isFinite(variance) || Math.abs(variance) >= 0.005) return fail(409, "day_end_checklist_or_variance", { variance }); await patchState({ day_end: "CLOSED_SIMULATED" }); return ok({ variance, checklist: true }); }
  if (name === "auction_overdue") { if (!can(ctx.member, ["BRANCH_MANAGER", "EXECUTIVE", "FRANCHISOR_SUPERVISOR"])) return fail(403, "auction_role_required"); if (demo.legal_hold_state === "ACTIVE") return fail(409, "legal_hold_active"); await patchState({ auction_state: "OVERDUE_SIMULATED" }); return ok({ pledge_id: "PLG-003" }); }
  if (name === "auction_result") { if (!can(ctx.member, ["BRANCH_MANAGER", "EXECUTIVE", "FRANCHISOR_SUPERVISOR"])) return fail(403, "auction_role_required"); if (demo.legal_hold_state === "ACTIVE") return fail(409, "legal_hold_active"); if (!["surplus", "shortfall"].includes(input.result)) return fail(400, "invalid_result"); await patchState({ auction_state: input.result === "shortfall" ? "SHORTFALL_REVIEW_SIMULATED" : "SURPLUS_SIMULATED" }); return ok({ result: input.result }); }
  if (name === "tenant_probe") return fail(403, "tenant_boundary", { target_branch: "BR-999" });
  if (name === "drilldown") { if (!can(ctx.member, ["AUDITOR", "FRANCHISOR_SUPERVISOR", "EXECUTIVE", "BRANCH_MANAGER"])) return fail(403, "report_role_required"); await patchState({ report_path: String(input.target || "PLG-001").slice(0, 64) }); return ok({ target: input.target || "PLG-001" }); }
  return response({ error: "unknown_action" }, 400);
}

Deno.serve(async (request) => {
  const path = new URL(request.url).pathname.replace(/^\/(?:functions\/v1\/)?aryp-api/, "") || "/";
  if (path === "/health") return response({ ok: true, service: "aryp-api", dataset: "ARYP-DEMO-SEED-001", status: "SYNTHETIC_ONLY" });
  const ctx = await context(request);
  if (!ctx) return response({ error: "membership_required" }, 403);
  try {
    if (request.method === "GET" && path === "/session") return response(await snapshot(ctx));
    if (request.method === "GET" && path === "/organizations") return response(await organizationStructure(ctx.member));
    if (request.method === "GET" && path === "/customers") { const payload = await seed(); return response({ items: (payload.customers || []).filter((item: any) => canSee(ctx.member, item.branch_id)) }); }
    if (request.method === "GET" && path === "/pledges") { const payload = await seed(); return response({ items: (payload.pledges || []).filter((item: any) => canSee(ctx.member, item.branch_id)) }); }
    if (request.method === "GET" && path === "/notifications") { const payload = await seed(); return response({ items: syntheticNotifications(payload, ctx.member) }); }
    if (request.method === "GET" && path === "/reports/summary") { const [payload, demo] = await Promise.all([seed(), state()]); return response({ item: syntheticReportSummary(payload, demo, ctx.member) }); }
    if (request.method === "GET" && path === "/cases") { const payload = await seed(); return response({ items: syntheticCases(payload, ctx.member) }); }
    if (request.method === "GET" && path === "/valuation/prices") { const payload = await seed(); return response({ item: syntheticValuation(payload, ctx.member) }); }
    if (request.method === "GET" && path === "/finance/summary") { const payload = await seed(); return response({ item: syntheticFinanceSummary(payload, ctx.member) }); }
    if (request.method === "GET" && path === "/documents") { const payload = await seed(); return response({ items: syntheticDocuments(payload, ctx.member) }); }
    if (request.method === "GET" && path === "/heirs") { const payload = await seed(); return response({ items: syntheticHeirs(payload, ctx.member) }); }
    if (request.method === "GET" && path === "/audit") return response({ items: await auditRows(ctx) });
    if (request.method === "GET" && path === "/regulatory-rules") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR", "EXECUTIVE", "AUDITOR"])) return response({ error: "regulatory_read_role_required" }, 403); return response({ items: await activeRegulatoryRules() }); }
    if (request.method === "GET" && path === "/nfr-targets") { if (!can(ctx.member, ["FRANCHISOR_SUPERVISOR", "EXECUTIVE", "AUDITOR"])) return response({ error: "nfr_read_role_required" }, 403); return response({ items: await activeNfrPolicies() }); }
    if (request.method === "GET" && path === "/deployment-info") { if (!can(ctx.member, ["FRANCHISOR_SUPERVISOR", "EXECUTIVE", "AUDITOR"])) return response({ error: "deployment_read_role_required" }, 403); return response({ item: await activeDeploymentPolicy() }); }
    if (request.method === "GET" && path === "/release-gates") { if (!can(ctx.member, ["BRANCH_MANAGER", "FRANCHISOR_SUPERVISOR", "EXECUTIVE", "AUDITOR"])) return response({ error: "release_gate_read_role_required" }, 403); return response({ items: await activeReleaseGates() }); }
    if (request.method === "POST" && path === "/actions") { const length = Number(request.headers.get("content-length") || 0); if (length > 32768) return response({ error: "payload_too_large" }, 413); let input: any; try { input = await request.json(); } catch { return response({ error: "invalid_json" }, 400); } if (!input || typeof input !== "object" || Array.isArray(input)) return response({ error: "invalid_payload" }, 400); return await action(request, ctx, input); }
    return response({ error: "not_found" }, 404);
  } catch (error) { console.error(error); return response({ error: "internal_error" }, 500); }
});
