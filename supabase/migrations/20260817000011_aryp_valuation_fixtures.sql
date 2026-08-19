-- Synthetic valuation fixtures for assumption-based demo only.
-- No live gold-price provider or production valuation is implied.
update public.aryp_demo_seed
set payload = payload || jsonb_build_object(
  'gold_prices', jsonb_build_array(
    jsonb_build_object('id', 'GOLD-001', 'purity', '916', 'price_per_gram', 603.00, 'effective_at', '2026-08-16T09:00:00+08:00', 'source', 'FIXTURE', 'state', 'PROVISIONAL'),
    jsonb_build_object('id', 'GOLD-002', 'purity', '999', 'price_per_gram', 658.00, 'effective_at', '2026-08-16T09:00:00+08:00', 'source', 'FIXTURE', 'state', 'PROVISIONAL')
  ),
  'marhun_items', jsonb_build_array(
    jsonb_build_object('id', 'MAR-001', 'customer_id', 'CUS-001', 'branch_id', 'BR-001', 'description', 'Rantai tangan demo', 'purity', '916', 'weight_grams', 6.48, 'valuation_state', 'PROVISIONAL', 'simulated_nm', 3907.44),
    jsonb_build_object('id', 'MAR-002', 'customer_id', 'CUS-002', 'branch_id', 'BR-001', 'description', 'Cincin emas demo', 'purity', '999', 'weight_grams', 2.23, 'valuation_state', 'PROVISIONAL', 'simulated_nm', 1467.20),
    jsonb_build_object('id', 'MAR-003', 'customer_id', 'CUS-003', 'branch_id', 'BR-001', 'description', 'Gelang emas demo', 'purity', '916', 'weight_grams', 7.00, 'valuation_state', 'PROVISIONAL', 'simulated_nm', 4221.00),
    jsonb_build_object('id', 'MAR-004', 'customer_id', 'CUS-004', 'branch_id', 'BR-002', 'description', 'Loket emas demo', 'purity', '916', 'weight_grams', 5.60, 'valuation_state', 'PROVISIONAL', 'simulated_nm', 3376.80)
  )
)
where dataset_id = 'ARYP-DEMO-SEED-001';
