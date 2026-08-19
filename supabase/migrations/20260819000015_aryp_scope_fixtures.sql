-- ARYP scope fixtures: synthetic records for branches 4-6 so hierarchy views
-- visibly differ between branch, franchisee and franchisor roles.
-- Demo-only; no real customer, pledge or financial data.

update public.aryp_demo_seed
set payload = jsonb_set(
  jsonb_set(
    jsonb_set(
      payload,
      '{customers}',
      (payload->'customers') || '[
        {"id":"CUS-006","display_name":"Pelanggan Demo Selatan 2","identifier_masked":"SYN-0006","phone_masked":"+60-1X-XXXX006","status":"VERIFIED","risk_state":"CLEAR","branch_id":"BR-004"},
        {"id":"CUS-007","display_name":"Pelanggan Demo Timur 1","identifier_masked":"SYN-0007","phone_masked":"+60-1X-XXXX007","status":"VERIFIED","risk_state":"REPEAT_REVIEW","branch_id":"BR-005"},
        {"id":"CUS-008","display_name":"Pelanggan Demo Timur 2","identifier_masked":"SYN-0008","phone_masked":"+60-1X-XXXX008","status":"ON_HOLD","risk_state":"BLACKLIST_REVIEW","branch_id":"BR-006"}
      ]'::jsonb
    ),
    '{pledges}',
    (payload->'pledges') || '[
      {"id":"PLG-005","customer_id":"CUS-006","marhun_id":"MAR-005","branch_id":"BR-004","state":"PLEDGED_ACTIVE","simulated_financing":2180.00,"formula_version":"ASSUMED-UPAH-SIMPAN-0.2","approval_state":"APPROVED_FOR_DEMO_ONLY"},
      {"id":"PLG-006","customer_id":"CUS-007","marhun_id":"MAR-006","branch_id":"BR-005","state":"OVERDUE","simulated_financing":3250.00,"formula_version":"ASSUMED-UPAH-SIMPAN-0.2","approval_state":"APPROVED_FOR_DEMO_ONLY"},
      {"id":"PLG-007","customer_id":"CUS-008","marhun_id":"MAR-007","branch_id":"BR-006","state":"AUCTION_READY","simulated_financing":4100.00,"formula_version":"ASSUMED-UPAH-SIMPAN-0.2","approval_state":"APPROVED_FOR_DEMO_ONLY"}
    ]'::jsonb
  ),
  '{marhun_items}',
  (payload->'marhun_items') || '[
    {"id":"MAR-005","customer_id":"CUS-006","branch_id":"BR-004","description":"Gelang demo Selatan","purity":"916","weight_grams":4.20,"simulated_nm":3114.00,"valuation_state":"PROVISIONAL"},
    {"id":"MAR-006","customer_id":"CUS-007","branch_id":"BR-005","description":"Rantai demo Timur","purity":"999","weight_grams":5.10,"simulated_nm":3355.80,"valuation_state":"PROVISIONAL"},
    {"id":"MAR-007","customer_id":"CUS-008","branch_id":"BR-006","description":"Cincin demo Timur","purity":"916","weight_grams":6.30,"simulated_nm":3798.90,"valuation_state":"PROVISIONAL"}
  ]'::jsonb
)
where dataset_id = 'ARYP-DEMO-SEED-001'
  and not (payload->'customers' @> '[{"id":"CUS-006"}]'::jsonb);

