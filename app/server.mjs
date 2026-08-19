import http from 'node:http';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { randomUUID } from 'node:crypto';

const here = path.dirname(fileURLToPath(import.meta.url));
const port = Number(process.env.PORT || 4173);
const seedPath = path.join(here, 'data', 'seed.json');
const mime = { '.html': 'text/html; charset=utf-8', '.js': 'text/javascript; charset=utf-8', '.css': 'text/css; charset=utf-8', '.json': 'application/json; charset=utf-8' };
const roles = new Set(['FRANCHISOR_SUPERVISOR', 'BRANCH_MANAGER', 'EXECUTIVE', 'TELLER', 'VAULT_CUSTODIAN', 'AUDITOR']);

function loadState() {
  const seed = JSON.parse(fs.readFileSync(seedPath, 'utf8'));
  return {
    seed,
    demo: { role: 'EXECUTIVE', pledge: 'PENDING_SIGNATURE', cashBalance: 37580, customerFixture: 'CUS-001', customerRisk: 'CLEAR', customerReview: 'NONE', customerHistory: [], vault: 'PENDING', vaultAcceptance: {}, auction: 'READY', reportPath: 'FR-001', dayEnd: 'OPEN', completion: 'PENDING' },
    audit: []
  };
}
let state = loadState();

function actor(req) {
  const value = req.headers['x-demo-role'];
  return roles.has(value) ? value : state.demo.role;
}
function correlationId(req) {
  if (!req.arypCorrelationId) {
    const supplied = req.headers['x-correlation-id'];
    req.arypCorrelationId = typeof supplied === 'string' && /^[A-Za-z0-9._:-]{1,96}$/.test(supplied) ? supplied : `COR-${randomUUID()}`;
  }
  return req.arypCorrelationId;
}
function snapshot(req) {
  return { meta: state.seed.meta, demo: state.demo, actor: actor(req), counts: { customers: state.seed.customers.length, pledges: state.seed.pledges.length, branches: state.seed.branches.length }, audit: state.audit.slice(-30) };
}
function writeJson(res, status, body) {
  res.writeHead(status, { 'content-type': 'application/json; charset=utf-8', 'cache-control': 'no-store' });
  res.end(JSON.stringify(body));
}
function audit(req, action, result, detail = {}) {
  state.audit.push({ id: `AUD-${String(state.audit.length + 1).padStart(4, '0')}`, at: new Date().toISOString(), correlation_id: correlationId(req), actor: actor(req), branch_id: 'BR-001', action, result, detail, state: 'SIMULATION' });
}
async function body(req) {
  let text = '';
  for await (const chunk of req) text += chunk;
  if (!text) return {};
  try { return JSON.parse(text); } catch { return { __invalid_json: true }; }
}
function findCustomer(id) { return state.seed.customers.find((item) => item.id === id); }
function findPledge(id) { return state.seed.pledges.find((item) => item.id === id); }
function customerHistory(customerId) {
  const customer = findCustomer(customerId);
  if (!customer) return [];
  const pledges = state.seed.pledges.filter((item) => item.customer_id === customerId);
  const history = pledges.map((item) => ({ label: `${item.state === 'OVERDUE' ? 'Gadaian tertunggak' : 'Gadaian aktif'} · RM${Number(item.simulated_financing).toLocaleString('ms-MY', { minimumFractionDigits: 2 })}`, detail: `${item.id} · ${item.branch_id}`, state: item.state }));
  if (customer.risk_state === 'REPEAT_REVIEW') history.push({ label: 'Semakan repeat customer diperlukan', detail: 'Fixture risk · polisi provisional', state: 'REPEAT_REVIEW' });
  if (customer.risk_state === 'BLACKLIST_REVIEW') history.push({ label: 'Risk hold · BLACKLIST_REVIEW', detail: 'Tiada bypass dibenarkan', state: 'BLACKLIST_REVIEW' });
  return history;
}
function allowed(req, permitted) { return permitted.includes(actor(req)); }
function serveStatic(req, res, pathname) {
  const requested = pathname === '/' ? '/index.html' : pathname;
  const publicRoot = path.resolve(here, 'public');
  const file = path.resolve(publicRoot, `.${requested}`);
  if (file !== publicRoot && !file.startsWith(`${publicRoot}${path.sep}`)) return writeJson(res, 403, { error: 'forbidden' });
  fs.readFile(file, (error, data) => {
    if (error) return writeJson(res, 404, { error: 'not_found' });
    res.writeHead(200, { 'content-type': mime[path.extname(file)] || 'application/octet-stream' });
    res.end(data);
  });
}

const server = http.createServer(async (req, res) => {
  const parsed = new URL(req.url, `http://${req.headers.host || 'localhost'}`);
  const pathname = parsed.pathname;
  if (!pathname.startsWith('/api/')) return serveStatic(req, res, pathname);
  if (req.method === 'GET' && pathname === '/api/health') return writeJson(res, 200, { ok: true, service: 'aryp-demo-system', dataset: state.seed.meta.dataset_id, status: state.seed.meta.status });
  if (req.method === 'GET' && pathname === '/api/session') return writeJson(res, 200, snapshot(req));
  if (req.method === 'GET' && pathname === '/api/customers') return writeJson(res, 200, { items: state.seed.customers });
  if (req.method === 'GET' && pathname === '/api/pledges') return writeJson(res, 200, { items: state.seed.pledges });
  if (req.method === 'GET' && pathname === '/api/audit') return writeJson(res, 200, { items: state.audit });
  if (req.method === 'POST' && pathname === '/api/reset') { state = loadState(); audit(req, 'RESET_DEMO', 'ALLOWED'); return writeJson(res, 200, snapshot(req)); }
  if (req.method === 'POST' && pathname === '/api/role') {
    const input = await body(req);
    if (input.__invalid_json) return writeJson(res, 400, { error: 'invalid_json' });
    if (!roles.has(input.role)) return writeJson(res, 400, { error: 'invalid_role' });
    state.demo.role = input.role; audit(req, 'CHANGE_ROLE', 'ALLOWED', { role: input.role }); return writeJson(res, 200, snapshot(req));
  }
  if (req.method === 'POST' && pathname === '/api/actions') {
    const input = await body(req);
    if (input.__invalid_json) return writeJson(res, 400, { error: 'invalid_json' });
    const action = input.action;
    if (action === 'reset_demo') { state = loadState(); audit(req, 'RESET_DEMO', 'ALLOWED'); return writeJson(res, 200, snapshot(req)); }
    if (action === 'load_customer') {
      const customer = findCustomer(input.customerId);
      if (!customer) return writeJson(res, 404, { error: 'customer_not_found' });
      state.demo.customerFixture = customer.id; state.demo.customerRisk = customer.risk_state; state.demo.customerReview = 'NONE'; state.demo.customerHistory = customerHistory(customer.id); audit(req, 'LOAD_CUSTOMER_FIXTURE', 'ALLOWED', { customer_id: customer.id, risk_state: customer.risk_state }); return writeJson(res, 200, { ...snapshot(req), customer, history: state.demo.customerHistory });
    }
    if (action === 'risk_review') {
      if (!allowed(req, ['BRANCH_MANAGER', 'FRANCHISOR_SUPERVISOR'])) { audit(req, action, 'DENIED', { reason: 'risk_reviewer_role_required' }); return writeJson(res, 403, { error: 'risk_reviewer_role_required', ...snapshot(req) }); }
      const customerId = input.customerId || state.demo.customerFixture;
      const customer = findCustomer(customerId);
      if (!customer) { audit(req, action, 'DENIED', { reason: 'customer_not_found', customer_id: customerId }); return writeJson(res, 404, { error: 'customer_not_found', ...snapshot(req) }); }
      state.demo.customerFixture = customer.id; state.demo.customerRisk = customer.risk_state; state.demo.customerHistory = customerHistory(customer.id);
      if (customer.risk_state === 'BLACKLIST_REVIEW') { audit(req, action, 'DENIED', { reason: 'blacklist_hold', customer_id: customer.id }); return writeJson(res, 409, { error: 'blacklist_hold', ...snapshot(req), customer, history: state.demo.customerHistory }); }
      state.demo.customerReview = 'REVIEWED_SIMULATED'; audit(req, action, 'ALLOWED', { customer_id: customer.id, risk_state: customer.risk_state }); return writeJson(res, 200, { ...snapshot(req), customer, history: state.demo.customerHistory });
    }
    if (action === 'approve_pledge') {
      if (!allowed(req, ['BRANCH_MANAGER', 'FRANCHISOR_SUPERVISOR'])) { audit(req, action, 'DENIED', { reason: 'maker_checker' }); return writeJson(res, 403, { error: 'maker_checker_required', ...snapshot(req) }); }
      if (!findPledge(input.pledgeId || 'PLG-001')) { audit(req, action, 'DENIED', { reason: 'pledge_not_found' }); return writeJson(res, 404, { error: 'pledge_not_found', ...snapshot(req) }); }
      state.demo.pledge = 'APPROVED'; audit(req, action, 'ALLOWED', { pledge_id: input.pledgeId || 'PLG-001' }); return writeJson(res, 200, snapshot(req));
    }
    if (action === 'reject_pledge') {
      if (!allowed(req, ['BRANCH_MANAGER', 'FRANCHISOR_SUPERVISOR'])) { audit(req, action, 'DENIED', { reason: 'maker_checker' }); return writeJson(res, 403, { error: 'maker_checker_required', ...snapshot(req) }); }
      if (!findPledge(input.pledgeId || 'PLG-001')) { audit(req, action, 'DENIED', { reason: 'pledge_not_found' }); return writeJson(res, 404, { error: 'pledge_not_found', ...snapshot(req) }); }
      state.demo.pledge = 'REJECTED'; audit(req, action, 'ALLOWED', { pledge_id: input.pledgeId || 'PLG-001', reason: input.reason || 'DEMO_REVIEW' }); return writeJson(res, 200, snapshot(req));
    }
    if (action === 'cash_out') {
      if (!allowed(req, ['TELLER', 'BRANCH_MANAGER', 'EXECUTIVE', 'FRANCHISOR_SUPERVISOR'])) { audit(req, action, 'DENIED', { reason: 'cashier_role_required' }); return writeJson(res, 403, { error: 'cashier_role_required', ...snapshot(req) }); }
      const amount = Number(input.amount || 2730);
      if (!Number.isFinite(amount) || amount <= 0 || amount > 100000) { audit(req, action, 'DENIED', { reason: 'invalid_amount' }); return writeJson(res, 400, { error: 'invalid_amount', ...snapshot(req) }); }
      if (state.demo.pledge !== 'APPROVED') { audit(req, action, 'DENIED', { reason: 'approval_required' }); return writeJson(res, 409, { error: 'approval_required', ...snapshot(req) }); }
      state.demo.pledge = 'CASH_OUT_SIMULATED'; state.demo.cashBalance -= amount; audit(req, action, 'ALLOWED', { amount }); return writeJson(res, 200, snapshot(req));
    }
    if (action === 'vault_checkin') {
      if (!allowed(req, ['VAULT_CUSTODIAN', 'BRANCH_MANAGER', 'FRANCHISOR_SUPERVISOR'])) { audit(req, action, 'DENIED', { reason: 'vault_role_required' }); return writeJson(res, 403, { error: 'vault_role_required', ...snapshot(req) }); }
      if (state.demo.pledge !== 'CASH_OUT_SIMULATED') { audit(req, action, 'DENIED', { reason: 'cash_out_required' }); return writeJson(res, 409, { error: 'cash_out_required', ...snapshot(req) }); }
      state.demo.vault = 'CHECKED_IN_SIMULATED'; state.demo.pledge = 'PLEDGED_ACTIVE'; audit(req, action, 'ALLOWED', { pledge_id: 'PLG-001', location: 'VAULT-A-01' }); return writeJson(res, 200, snapshot(req));
    }
    if (action === 'vault_accept') {
      if (!allowed(req, ['VAULT_CUSTODIAN', 'BRANCH_MANAGER', 'FRANCHISOR_SUPERVISOR'])) { audit(req, action, 'DENIED', { reason: 'vault_role_required' }); return writeJson(res, 403, { error: 'vault_role_required', ...snapshot(req) }); }
      const reference = String(input.reference || '');
      if (!['0041', '0042'].includes(reference)) { audit(req, action, 'DENIED', { reason: 'unknown_vault_bag', reference }); return writeJson(res, 404, { error: 'unknown_vault_bag', ...snapshot(req) }); }
      if (reference === '0042' && state.demo.pledge !== 'CASH_OUT_SIMULATED' && state.demo.pledge !== 'PLEDGED_ACTIVE') { audit(req, action, 'DENIED', { reason: 'cash_out_required', reference }); return writeJson(res, 409, { error: 'cash_out_required', ...snapshot(req) }); }
      state.demo.vaultAcceptance[reference] = 'ACCEPTED_SIMULATED'; audit(req, action, 'ALLOWED', { reference, location: reference === '0042' ? 'VAULT-A-03-B12' : 'VAULT-A-01' }); return writeJson(res, 200, snapshot(req));
    }
    if (action === 'redemption') {
      if (!allowed(req, ['TELLER', 'BRANCH_MANAGER', 'EXECUTIVE', 'FRANCHISOR_SUPERVISOR'])) { audit(req, action, 'DENIED', { reason: 'cashier_role_required' }); return writeJson(res, 403, { error: 'cashier_role_required', ...snapshot(req) }); }
      state.demo.pledge = 'REDEMPTION_SIMULATED'; audit(req, action, 'ALLOWED', { pledge_id: 'PLG-002', provider: 'MOCK_PAYMENT' }); return writeJson(res, 200, snapshot(req));
    }
    if (action === 'complete_pledge') {
      if (!allowed(req, ['BRANCH_MANAGER', 'EXECUTIVE', 'FRANCHISOR_SUPERVISOR'])) { audit(req, action, 'DENIED', { reason: 'completion_role_required' }); return writeJson(res, 403, { error: 'completion_role_required', ...snapshot(req) }); }
      if (state.demo.pledge !== 'PLEDGED_ACTIVE') { audit(req, action, 'DENIED', { reason: 'vault_checkin_required' }); return writeJson(res, 409, { error: 'vault_checkin_required', ...snapshot(req) }); }
      state.demo.completion = 'COMPLETED_SIMULATED'; audit(req, action, 'ALLOWED', { pledge_id: input.pledgeId || 'PLG-001' }); return writeJson(res, 200, snapshot(req));
    }
    if (action === 'stocktake') {
      if (!allowed(req, ['VAULT_CUSTODIAN', 'BRANCH_MANAGER', 'AUDITOR', 'FRANCHISOR_SUPERVISOR'])) { audit(req, action, 'DENIED', { reason: 'stocktake_role_required' }); return writeJson(res, 403, { error: 'stocktake_role_required', ...snapshot(req) }); }
      state.demo.vault = 'STOCKTAKE_MATCHED'; audit(req, action, 'ALLOWED', { matched: 4, variance: 0 }); return writeJson(res, 200, snapshot(req));
    }
    if (action === 'vault_no_dual') { audit(req, action, 'DENIED', { reason: 'dual_control_required', location: 'VAULT-A-01' }); return writeJson(res, 403, { error: 'dual_control_required', ...snapshot(req) }); }
    if (action === 'close_day') {
      if (!allowed(req, ['TELLER', 'BRANCH_MANAGER', 'EXECUTIVE', 'FRANCHISOR_SUPERVISOR'])) { audit(req, action, 'DENIED', { reason: 'day_end_role_required' }); return writeJson(res, 403, { error: 'day_end_role_required', ...snapshot(req) }); }
      const variance = Number(input.variance || 0);
      if (!input.checklist || !Number.isFinite(variance) || Math.abs(variance) >= 0.005) { audit(req, action, 'DENIED', { reason: 'day_end_checklist_or_variance', variance }); return writeJson(res, 409, { error: 'day_end_checklist_or_variance', ...snapshot(req) }); }
      state.demo.dayEnd = 'CLOSED_SIMULATED'; audit(req, action, 'ALLOWED', { variance, checklist: true }); return writeJson(res, 200, snapshot(req));
    }
    if (action === 'auction_overdue') {
      if (!allowed(req, ['BRANCH_MANAGER', 'EXECUTIVE', 'FRANCHISOR_SUPERVISOR'])) { audit(req, action, 'DENIED', { reason: 'auction_role_required' }); return writeJson(res, 403, { error: 'auction_role_required', ...snapshot(req) }); }
      state.demo.auction = 'OVERDUE_SIMULATED'; audit(req, action, 'ALLOWED', { pledge_id: 'PLG-003' }); return writeJson(res, 200, snapshot(req));
    }
    if (action === 'auction_result') {
      if (!allowed(req, ['BRANCH_MANAGER', 'EXECUTIVE', 'FRANCHISOR_SUPERVISOR'])) { audit(req, action, 'DENIED', { reason: 'auction_role_required' }); return writeJson(res, 403, { error: 'auction_role_required', ...snapshot(req) }); }
      if (!['surplus', 'shortfall'].includes(input.result)) { audit(req, action, 'DENIED', { reason: 'invalid_result' }); return writeJson(res, 400, { error: 'invalid_result', ...snapshot(req) }); }
      state.demo.auction = input.result === 'shortfall' ? 'SHORTFALL_REVIEW_SIMULATED' : 'SURPLUS_SIMULATED'; audit(req, action, 'ALLOWED', { result: state.demo.auction }); return writeJson(res, 200, snapshot(req));
    }
    if (action === 'tenant_probe') { audit(req, action, 'DENIED', { target_branch: 'BR-999', reason: 'tenant_boundary' }); return writeJson(res, 403, { error: 'tenant_boundary', ...snapshot(req) }); }
    if (action === 'drilldown') {
      if (!allowed(req, ['AUDITOR', 'FRANCHISOR_SUPERVISOR', 'EXECUTIVE', 'BRANCH_MANAGER'])) { audit(req, action, 'DENIED', { reason: 'report_role_required' }); return writeJson(res, 403, { error: 'report_role_required', ...snapshot(req) }); }
      state.demo.reportPath = input.target || 'PLG-001'; audit(req, action, 'ALLOWED', { target: state.demo.reportPath }); return writeJson(res, 200, snapshot(req));
    }
    return writeJson(res, 400, { error: 'unknown_action' });
  }
  return writeJson(res, 404, { error: 'not_found' });
});

server.listen(port, () => console.log(`ARYP demo system listening on http://localhost:${port}`));
