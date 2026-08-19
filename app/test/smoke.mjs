import assert from 'node:assert/strict';

const base = `http://localhost:${process.env.PORT || 4173}`;

async function request(path, { method = 'GET', role = 'EXECUTIVE', body } = {}) {
  const response = await fetch(base + path, {
    method,
    headers: { 'content-type': 'application/json', 'x-demo-role': role },
    body: body === undefined ? undefined : JSON.stringify(body)
  });
  const data = await response.json();
  return { response, data };
}

const health = await request('/api/health');
assert.equal(health.response.status, 200);
assert.equal(health.data.status, 'SYNTHETIC_ONLY');

await request('/api/reset', { method: 'POST', role: 'BRANCH_MANAGER' });
const initial = await request('/api/session');
assert.equal(initial.data.demo.pledge, 'PENDING_SIGNATURE');
assert.equal(initial.data.audit.at(-1).action, 'RESET_DEMO');

const invalidRole = await request('/api/role', { method: 'POST', body: { role: 'ROOT' } });
assert.equal(invalidRole.response.status, 400);
assert.equal(invalidRole.data.error, 'invalid_role');

const invalidJsonResponse = await fetch(base + '/api/actions', { method: 'POST', headers: { 'content-type': 'application/json' }, body: '{' });
assert.equal(invalidJsonResponse.status, 400);
assert.equal((await invalidJsonResponse.json()).error, 'invalid_json');

const tellerApproval = await request('/api/actions', { method: 'POST', role: 'TELLER', body: { action: 'approve_pledge', pledgeId: 'PLG-001' } });
assert.equal(tellerApproval.response.status, 403);
assert.equal(tellerApproval.data.error, 'maker_checker_required');

const rejected = await request('/api/actions', { method: 'POST', role: 'BRANCH_MANAGER', body: { action: 'reject_pledge', pledgeId: 'PLG-001' } });
assert.equal(rejected.response.status, 200);
assert.equal(rejected.data.demo.pledge, 'REJECTED');
await request('/api/reset', { method: 'POST', role: 'BRANCH_MANAGER' });

const missingPledge = await request('/api/actions', { method: 'POST', role: 'BRANCH_MANAGER', body: { action: 'approve_pledge', pledgeId: 'PLG-999' } });
assert.equal(missingPledge.response.status, 404);
assert.equal(missingPledge.data.error, 'pledge_not_found');

const customer = await request('/api/actions', { method: 'POST', role: 'TELLER', body: { action: 'load_customer', customerId: 'CUS-003' } });
assert.equal(customer.response.status, 200);
assert.equal(customer.data.customer.risk_state, 'REPEAT_REVIEW');
assert.equal(customer.data.demo.customerRisk, 'REPEAT_REVIEW');

const blockedCustomer = await request('/api/actions', { method: 'POST', role: 'TELLER', body: { action: 'load_customer', customerId: 'CUS-005' } });
assert.equal(blockedCustomer.response.status, 200);
assert.equal(blockedCustomer.data.demo.customerRisk, 'BLACKLIST_REVIEW');

const repeatReview = await request('/api/actions', { method: 'POST', role: 'BRANCH_MANAGER', body: { action: 'risk_review', customerId: 'CUS-003' } });
assert.equal(repeatReview.response.status, 200);
assert.equal(repeatReview.data.demo.customerReview, 'REVIEWED_SIMULATED');

const blockedReview = await request('/api/actions', { method: 'POST', role: 'BRANCH_MANAGER', body: { action: 'risk_review', customerId: 'CUS-005' } });
assert.equal(blockedReview.response.status, 409);
assert.equal(blockedReview.data.error, 'blacklist_hold');

const approve = await request('/api/actions', { method: 'POST', role: 'BRANCH_MANAGER', body: { action: 'approve_pledge', pledgeId: 'PLG-001' } });
assert.equal(approve.response.status, 200);
assert.equal(approve.data.demo.pledge, 'APPROVED');

const invalidAmount = await request('/api/actions', { method: 'POST', role: 'TELLER', body: { action: 'cash_out', amount: -1 } });
assert.equal(invalidAmount.response.status, 400);
assert.equal(invalidAmount.data.error, 'invalid_amount');

const cashOut = await request('/api/actions', { method: 'POST', role: 'TELLER', body: { action: 'cash_out', amount: 2730 } });
assert.equal(cashOut.response.status, 200);
assert.equal(cashOut.data.demo.pledge, 'CASH_OUT_SIMULATED');

const vaultDenied = await request('/api/actions', { method: 'POST', role: 'TELLER', body: { action: 'vault_checkin', pledgeId: 'PLG-001' } });
assert.equal(vaultDenied.response.status, 403);
assert.equal(vaultDenied.data.error, 'vault_role_required');

const vault = await request('/api/actions', { method: 'POST', role: 'VAULT_CUSTODIAN', body: { action: 'vault_checkin', pledgeId: 'PLG-001' } });
assert.equal(vault.response.status, 200);
assert.equal(vault.data.demo.pledge, 'PLEDGED_ACTIVE');

const completed = await request('/api/actions', { method: 'POST', role: 'BRANCH_MANAGER', body: { action: 'complete_pledge', pledgeId: 'PLG-001' } });
assert.equal(completed.response.status, 200);
assert.equal(completed.data.demo.completion, 'COMPLETED_SIMULATED');

const vaultBag = await request('/api/actions', { method: 'POST', role: 'VAULT_CUSTODIAN', body: { action: 'vault_accept', reference: '0041' } });
assert.equal(vaultBag.response.status, 200);
assert.equal(vaultBag.data.demo.vaultAcceptance['0041'], 'ACCEPTED_SIMULATED');

const stocktake = await request('/api/actions', { method: 'POST', role: 'VAULT_CUSTODIAN', body: { action: 'stocktake' } });
assert.equal(stocktake.response.status, 200);
assert.equal(stocktake.data.demo.vault, 'STOCKTAKE_MATCHED');

const noDual = await request('/api/actions', { method: 'POST', role: 'VAULT_CUSTODIAN', body: { action: 'vault_no_dual' } });
assert.equal(noDual.response.status, 403);
assert.equal(noDual.data.error, 'dual_control_required');

const closeDayDenied = await request('/api/actions', { method: 'POST', role: 'TELLER', body: { action: 'close_day', variance: 20, checklist: false } });
assert.equal(closeDayDenied.response.status, 409);
assert.equal(closeDayDenied.data.error, 'day_end_checklist_or_variance');

const closeDay = await request('/api/actions', { method: 'POST', role: 'TELLER', body: { action: 'close_day', variance: 0, checklist: true } });
assert.equal(closeDay.response.status, 200);
assert.equal(closeDay.data.demo.dayEnd, 'CLOSED_SIMULATED');

const auction = await request('/api/actions', { method: 'POST', role: 'BRANCH_MANAGER', body: { action: 'auction_result', result: 'shortfall' } });
assert.equal(auction.response.status, 200);
assert.equal(auction.data.demo.auction, 'SHORTFALL_REVIEW_SIMULATED');

const invalidAuction = await request('/api/actions', { method: 'POST', role: 'BRANCH_MANAGER', body: { action: 'auction_result', result: 'unknown' } });
assert.equal(invalidAuction.response.status, 400);
assert.equal(invalidAuction.data.error, 'invalid_result');

const drilldown = await request('/api/actions', { method: 'POST', role: 'AUDITOR', body: { action: 'drilldown', target: 'PLG-001' } });
assert.equal(drilldown.response.status, 200);
assert.equal(drilldown.data.demo.reportPath, 'PLG-001');

const tenant = await request('/api/actions', { method: 'POST', role: 'BRANCH_MANAGER', body: { action: 'tenant_probe' } });
assert.equal(tenant.response.status, 403);
assert.equal(tenant.data.error, 'tenant_boundary');

const unknown = await request('/api/actions', { method: 'POST', body: { action: 'not_real' } });
assert.equal(unknown.response.status, 400);
assert.equal(unknown.data.error, 'unknown_action');

const final = await request('/api/audit');
assert.ok(final.data.items.some((event) => event.action === 'tenant_probe' && event.result === 'DENIED'));
assert.ok(final.data.items.some((event) => event.action === 'vault_checkin' && event.result === 'ALLOWED'));
assert.ok(final.data.items.every((event) => typeof event.correlation_id === 'string' && event.correlation_id.length > 0));
assert.ok(final.data.items.some((event) => event.action === 'LOAD_CUSTOMER_FIXTURE' && event.detail.risk_state === 'BLACKLIST_REVIEW'));
const correlationProbe = await request('/api/actions', { method: 'POST', role: 'AUDITOR', body: { action: 'drilldown', target: 'BR-001' } });
assert.equal(correlationProbe.response.status, 200);
const auditWithProbe = await request('/api/audit');
assert.equal(auditWithProbe.data.items.at(-1).correlation_id.startsWith('COR-'), true);
console.log(`ARYP API smoke passed: ${final.data.items.length} audit events verified.`);
