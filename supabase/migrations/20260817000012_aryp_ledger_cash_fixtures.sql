-- Synthetic ledger, cash and custody fixtures for assumption-based demo only.
update public.aryp_demo_seed
set payload = payload || jsonb_build_object(
  'payments', jsonb_build_array(
    jsonb_build_object('id', 'PAY-001', 'pledge_id', 'PLG-001', 'kind', 'SIMULATED_CASH_OUT', 'amount', 2730.00, 'state', 'SIMULATION', 'provider', 'MOCK_TELLER'),
    jsonb_build_object('id', 'PAY-002', 'pledge_id', 'PLG-002', 'kind', 'SIMULATED_REDEMPTION', 'amount', 1578.50, 'state', 'SIMULATION', 'provider', 'MOCK_PAYMENT'),
    jsonb_build_object('id', 'PAY-003', 'pledge_id', 'PLG-003', 'kind', 'SIMULATED_INSTALLMENT', 'amount', 450.00, 'state', 'SIMULATION', 'provider', 'MOCK_TELLER')
  ),
  'cash_drawers', jsonb_build_array(
    jsonb_build_object('id', 'DRAWER-BR001-T01', 'branch_id', 'BR-001', 'business_date', '2026-08-17', 'opening_float', 10000.00, 'cash_in', 2028.50, 'cash_out', 2730.00, 'expected_balance', 9298.50, 'counted_balance', 9298.50, 'variance', 0.00, 'state', 'OPEN_SIMULATED')
  ),
  'ledger_entries', jsonb_build_array(
    jsonb_build_object('id', 'LED-001', 'branch_id', 'BR-001', 'account', 'CASH_DRAWER', 'debit', 10000.00, 'credit', 0.00, 'reference', 'OPENING_FLOAT', 'state', 'SIMULATION'),
    jsonb_build_object('id', 'LED-002', 'branch_id', 'BR-001', 'account', 'FINANCING_PAYOUT', 'debit', 2730.00, 'credit', 0.00, 'reference', 'PAY-001', 'state', 'SIMULATION'),
    jsonb_build_object('id', 'LED-003', 'branch_id', 'BR-001', 'account', 'CASH_DRAWER', 'debit', 0.00, 'credit', 2730.00, 'reference', 'PAY-001', 'state', 'SIMULATION'),
    jsonb_build_object('id', 'LED-004', 'branch_id', 'BR-001', 'account', 'REDEMPTION_RECEIPT', 'debit', 2028.50, 'credit', 0.00, 'reference', 'PAY-002/PAY-003', 'state', 'SIMULATION')
  ),
  'vault_movements', jsonb_build_array(
    jsonb_build_object('id', 'VLT-001', 'pledge_id', 'PLG-001', 'branch_id', 'BR-001', 'event', 'CHECK_IN', 'location', 'VAULT-A-01', 'actor', 'SYNTHETIC_VAULT', 'reason', 'PLEDGE_ACCEPTED', 'state', 'SIMULATION'),
    jsonb_build_object('id', 'VLT-002', 'pledge_id', 'PLG-004', 'branch_id', 'BR-002', 'event', 'AUCTION_TRANSFER', 'location', 'VAULT-B-02', 'actor', 'SYNTHETIC_VAULT', 'reason', 'AUCTION_READY', 'state', 'SIMULATION')
  ),
  'auctions', jsonb_build_array(
    jsonb_build_object('id', 'AUC-001', 'pledge_id', 'PLG-004', 'branch_id', 'BR-002', 'state', 'AUCTION_SIMULATED', 'simulated_base_price', 3800.00, 'simulated_sale_price', 4200.00, 'simulated_surplus', 350.00),
    jsonb_build_object('id', 'AUC-002', 'pledge_id', 'PLG-003', 'branch_id', 'BR-001', 'state', 'SHORTFALL_REVIEW_SIMULATED', 'simulated_base_price', 4400.00, 'simulated_sale_price', 4000.00, 'simulated_shortfall', 421.00)
  ),
  'heirs', jsonb_build_array(
    jsonb_build_object('id', 'HEIR-001', 'customer_id', 'CUS-004', 'display_name', 'Waris Demo', 'relationship', 'SIBLING', 'claim_state', 'PENDING_DOCUMENT_REVIEW')
  )
)
where dataset_id = 'ARYP-DEMO-SEED-001';
