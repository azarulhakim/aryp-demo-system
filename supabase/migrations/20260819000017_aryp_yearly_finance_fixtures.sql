-- Expand the one-year synthetic history into finance, vault and auction registers.
-- Demo-only; all values are generated simulation records.

update public.aryp_demo_seed
set payload = payload
  || jsonb_build_object(
    'payments', (payload->'payments') || (select jsonb_agg(jsonb_build_object(
      'id', format('PAY-Y%s-B%s', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYYMM'), lpad(b.branch_no::text, 3, '0')),
      'pledge_id', format('PLG-%s', lpad((8 + (((m.month_no * 18 + b.branch_no) % 150)))::text, 3, '0')),
      'branch_id', format('BR-%s', lpad(b.branch_no::text, 3, '0')),
      'kind', case when (m.month_no + b.branch_no) % 3 = 0 then 'SIMULATED_REDEMPTION' else 'SIMULATED_INSTALLMENT' end,
      'amount', round((350 + ((m.month_no * 97 + b.branch_no * 41) % 1250))::numeric, 2),
      'period', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYY-MM'),
      'state', 'SIMULATION',
      'provider', 'MOCK_PAYMENT'
    ) order by m.month_no, b.branch_no) from generate_series(0, 11) as m(month_no) cross join generate_series(1, 18) as b(branch_no)),
    'ledger_entries', (payload->'ledger_entries') || (select jsonb_agg(jsonb_build_object(
      'id', format('LED-Y%s-B%s', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYYMM'), lpad(b.branch_no::text, 3, '0')),
      'branch_id', format('BR-%s', lpad(b.branch_no::text, 3, '0')),
      'account', case when (m.month_no + b.branch_no) % 2 = 0 then 'CASH_DRAWER' else 'FINANCING_INCOME_SIMULATED' end,
      'debit', round((12000 + b.branch_no * 430 + m.month_no * 610)::numeric, 2),
      'credit', round((9800 + b.branch_no * 390 + m.month_no * 570)::numeric, 2),
      'reference', format('MONTH_CLOSE_%s', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYYMM')),
      'period', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYY-MM'),
      'state', 'SIMULATION'
    ) order by m.month_no, b.branch_no) from generate_series(0, 11) as m(month_no) cross join generate_series(1, 18) as b(branch_no)),
    'vault_movements', (payload->'vault_movements') || (select jsonb_agg(jsonb_build_object(
      'id', format('VLT-Y%s-B%s', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYYMM'), lpad(b.branch_no::text, 3, '0')),
      'pledge_id', format('PLG-%s', lpad((8 + (((m.month_no * 18 + b.branch_no) % 150)))::text, 3, '0')),
      'branch_id', format('BR-%s', lpad(b.branch_no::text, 3, '0')),
      'event', case when (m.month_no + b.branch_no) % 4 = 0 then 'CHECK_OUT_REDEMPTION' else 'CHECK_IN' end,
      'location', format('VAULT-%s-%s', chr(64 + ((b.branch_no - 1) % 6) + 1), lpad(((b.branch_no - 1) % 4) + 1, 2, '0')),
      'actor', 'SYNTHETIC_VAULT',
      'reason', 'MONTHLY_ACTIVITY_SIMULATED',
      'period', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYY-MM'),
      'state', 'SIMULATION'
    ) order by m.month_no, b.branch_no) from generate_series(0, 11) as m(month_no) cross join generate_series(1, 18) as b(branch_no)),
    'auctions', (payload->'auctions') || (select jsonb_agg(jsonb_build_object(
      'id', format('AUC-Y%s-B%s', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYYMM'), lpad(b.branch_no::text, 3, '0')),
      'pledge_id', format('PLG-%s', lpad((8 + (((m.month_no * 18 + b.branch_no) % 150)))::text, 3, '0')),
      'branch_id', format('BR-%s', lpad(b.branch_no::text, 3, '0')),
      'state', case when (m.month_no + b.branch_no) % 2 = 0 then 'AUCTION_SIMULATED' else 'SHORTFALL_REVIEW_SIMULATED' end,
      'simulated_base_price', round((3100 + b.branch_no * 95 + m.month_no * 60)::numeric, 2),
      'simulated_sale_price', round((3350 + b.branch_no * 110 + m.month_no * 75)::numeric, 2),
      'period', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYY-MM'),
      'state_classification', 'SIMULATION_ONLY'
    ) order by m.month_no, b.branch_no) from generate_series(0, 11) as m(month_no) cross join generate_series(1, 18) as b(branch_no) where (m.month_no + b.branch_no) % 4 = 0)
  )
where dataset_id = 'ARYP-DEMO-SEED-001'
  and not (payload ? 'yearly_finance_history');

update public.aryp_demo_seed
set payload = payload || jsonb_build_object('yearly_finance_history', jsonb_build_object('period_count', 12, 'state', 'SIMULATION_ONLY'))
where dataset_id = 'ARYP-DEMO-SEED-001'
  and not (payload ? 'yearly_finance_history');
