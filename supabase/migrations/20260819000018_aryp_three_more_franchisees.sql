-- Add three more franchisees and their synthetic branch/year fixtures.
-- Demo-only; no real entity, customer or financial data.

insert into public.aryp_organizations (id, organization_type, parent_organization_id, code, name, legal_name)
values
  ('FR-007','FRANCHISEE','ORG-ARYP','FR-007','Franchisee Demo Lembah Klang','Franchisee Demo Lembah Klang Sdn. Bhd.'),
  ('FR-008','FRANCHISEE','ORG-ARYP','FR-008','Franchisee Demo Utara Timur','Franchisee Demo Utara Timur Sdn. Bhd.'),
  ('FR-009','FRANCHISEE','ORG-ARYP','FR-009','Franchisee Demo Selatan Barat','Franchisee Demo Selatan Barat Sdn. Bhd.')
on conflict (id) do update set name = excluded.name, legal_name = excluded.legal_name, parent_organization_id = excluded.parent_organization_id, updated_at = now();

insert into public.aryp_branches (id, organization_id, code, name, metadata)
values
  ('BR-019','FR-007','DEMO-LK-01','Cawangan Demo Lembah Klang 1','{"demo_region":"LEMBAH_KLANG","opened":"2025-12-01"}'::jsonb),
  ('BR-020','FR-007','DEMO-LK-02','Cawangan Demo Lembah Klang 2','{"demo_region":"LEMBAH_KLANG","opened":"2025-12-08"}'::jsonb),
  ('BR-021','FR-007','DEMO-LK-03','Cawangan Demo Lembah Klang 3','{"demo_region":"LEMBAH_KLANG","opened":"2025-12-15"}'::jsonb),
  ('BR-022','FR-008','DEMO-UTT-01','Cawangan Demo Utara Timur 1','{"demo_region":"UTARA_TIMUR","opened":"2026-01-01"}'::jsonb),
  ('BR-023','FR-008','DEMO-UTT-02','Cawangan Demo Utara Timur 2','{"demo_region":"UTARA_TIMUR","opened":"2026-01-08"}'::jsonb),
  ('BR-024','FR-008','DEMO-UTT-03','Cawangan Demo Utara Timur 3','{"demo_region":"UTARA_TIMUR","opened":"2026-01-15"}'::jsonb),
  ('BR-025','FR-009','DEMO-SLB-01','Cawangan Demo Selatan Barat 1','{"demo_region":"SELATAN_BARAT","opened":"2026-02-01"}'::jsonb),
  ('BR-026','FR-009','DEMO-SLB-02','Cawangan Demo Selatan Barat 2','{"demo_region":"SELATAN_BARAT","opened":"2026-02-08"}'::jsonb),
  ('BR-027','FR-009','DEMO-SLB-03','Cawangan Demo Selatan Barat 3','{"demo_region":"SELATAN_BARAT","opened":"2026-02-15"}'::jsonb)
on conflict (id) do update set organization_id = excluded.organization_id, code = excluded.code, name = excluded.name, metadata = excluded.metadata, updated_at = now();

update public.aryp_demo_seed
set payload = payload
  || jsonb_build_object(
    'branches', (select jsonb_agg(jsonb_build_object('id', b.id, 'franchisee_id', b.organization_id, 'code', b.code, 'name', b.name) order by b.id) from public.aryp_branches b where b.status = 'ACTIVE'),
    'customers', (payload->'customers') || (select jsonb_agg(jsonb_build_object(
      'id', format('CUS-%s', lpad(g.n::text, 3, '0')),
      'display_name', format('Pelanggan Demo Franchisee %s', lpad(g.n::text, 3, '0')),
      'identifier_masked', format('SYN-%s', lpad(g.n::text, 4, '0')),
      'phone_masked', format('+60-1X-XXXX%s', lpad(g.n::text, 3, '0')),
      'status', 'VERIFIED',
      'risk_state', case when g.n % 13 = 0 then 'REPEAT_REVIEW' else 'CLEAR' end,
      'branch_id', format('BR-%s', lpad((((g.n - 189) % 9) + 19)::text, 3, '0')),
      'registered_on', to_char((date '2025-12-01' + (((g.n - 189) % 260) * interval '1 day'))::date, 'YYYY-MM-DD')
    ) order by g.n) from generate_series(189, 278) as g(n)),
    'pledges', (payload->'pledges') || (select jsonb_agg(jsonb_build_object(
      'id', format('PLG-%s', lpad(g.n::text, 3, '0')),
      'customer_id', format('CUS-%s', lpad((189 + ((g.n - 158) % 90))::text, 3, '0')),
      'marhun_id', format('MAR-%s', lpad(g.n::text, 3, '0')),
      'branch_id', format('BR-%s', lpad((((g.n - 158) % 9) + 19)::text, 3, '0')),
      'state', case when g.n % 17 = 0 then 'AUCTION_READY' when g.n % 13 = 0 then 'OVERDUE' when g.n % 7 = 0 then 'REDEMPTION_SIMULATED' else 'PLEDGED_ACTIVE' end,
      'simulated_financing', round((1650 + ((g.n * 113) % 4300))::numeric, 2),
      'formula_version', 'ASSUMED-UPAH-SIMPAN-0.2',
      'approval_state', 'APPROVED_FOR_DEMO_ONLY',
      'pledged_on', to_char((date '2025-12-01' + (((g.n - 158) * 3) % 260) * interval '1 day')::date, 'YYYY-MM-DD')
    ) order by g.n) from generate_series(158, 232) as g(n)),
    'marhun_items', (payload->'marhun_items') || (select jsonb_agg(jsonb_build_object(
      'id', format('MAR-%s', lpad(g.n::text, 3, '0')),
      'customer_id', format('CUS-%s', lpad((189 + ((g.n - 158) % 90))::text, 3, '0')),
      'branch_id', format('BR-%s', lpad((((g.n - 158) % 9) + 19)::text, 3, '0')),
      'description', case when g.n % 3 = 0 then 'Rantai emas franchisee demo' when g.n % 3 = 1 then 'Cincin emas franchisee demo' else 'Gelang emas franchisee demo' end,
      'purity', case when g.n % 4 = 0 then '999' else '916' end,
      'weight_grams', round((2.8 + ((g.n * 19) % 75) / 10.0)::numeric, 2),
      'simulated_nm', round((1650 + ((g.n * 113) % 4300))::numeric, 2),
      'valuation_state', 'PROVISIONAL'
    ) order by g.n) from generate_series(158, 232) as g(n)),
    'branch_monthly_metrics', (payload->'branch_monthly_metrics') || (select jsonb_agg(jsonb_build_object(
      'period', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYY-MM'),
      'branch_id', format('BR-%s', lpad(b.branch_no::text, 3, '0')),
      'customers_new', 5 + ((b.branch_no * 3 + m.month_no) % 14),
      'pledges_count', 7 + ((b.branch_no * 5 + m.month_no * 2) % 19),
      'redemptions_count', 2 + ((b.branch_no + m.month_no) % 8),
      'auction_count', case when (b.branch_no + m.month_no) % 7 = 0 then 1 else 0 end,
      'financing_amount', round((18000 + b.branch_no * 725 + m.month_no * 940 + ((b.branch_no * m.month_no) % 9) * 110)::numeric, 2),
      'cash_in', round((12000 + b.branch_no * 430 + m.month_no * 610)::numeric, 2),
      'cash_out', round((14500 + b.branch_no * 520 + m.month_no * 780)::numeric, 2),
      'overdue_count', 1 + ((b.branch_no + m.month_no * 2) % 6)
    ) order by m.month_no, b.branch_no) from generate_series(0, 11) as m(month_no) cross join generate_series(19, 27) as b(branch_no)),
    'yearly_history', (select jsonb_agg(jsonb_build_object(
      'period', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYY-MM'),
      'label', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'Mon YYYY'),
      'customers_new', (select sum(5 + ((b.branch_no * 3 + m.month_no) % 14)) from generate_series(1, 27) as b(branch_no)),
      'pledges_count', (select sum(7 + ((b.branch_no * 5 + m.month_no * 2) % 19)) from generate_series(1, 27) as b(branch_no)),
      'redemptions_count', (select sum(2 + ((b.branch_no + m.month_no) % 8)) from generate_series(1, 27) as b(branch_no)),
      'auction_count', (select count(*) from generate_series(1, 27) as b(branch_no) where (b.branch_no + m.month_no) % 7 = 0),
      'financing_amount', (select sum(18000 + b.branch_no * 725 + m.month_no * 940 + ((b.branch_no * m.month_no) % 9) * 110) from generate_series(1, 27) as b(branch_no))
    ) order by m.month_no) from generate_series(0, 11) as m(month_no)),
    'payments', (payload->'payments') || (select jsonb_agg(jsonb_build_object(
      'id', format('PAY-Z%s-B%s', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYYMM'), lpad(b.branch_no::text, 3, '0')),
      'pledge_id', format('PLG-%s', lpad((158 + ((m.month_no * 9 + b.branch_no) % 75))::text, 3, '0')),
      'branch_id', format('BR-%s', lpad(b.branch_no::text, 3, '0')),
      'kind', case when (m.month_no + b.branch_no) % 3 = 0 then 'SIMULATED_REDEMPTION' else 'SIMULATED_INSTALLMENT' end,
      'amount', round((375 + ((m.month_no * 89 + b.branch_no * 37) % 1200))::numeric, 2),
      'period', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYY-MM'),
      'state', 'SIMULATION', 'provider', 'MOCK_PAYMENT'
    ) order by m.month_no, b.branch_no) from generate_series(0, 11) as m(month_no) cross join generate_series(19, 27) as b(branch_no)),
    'ledger_entries', (payload->'ledger_entries') || (select jsonb_agg(jsonb_build_object(
      'id', format('LED-Z%s-B%s', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYYMM'), lpad(b.branch_no::text, 3, '0')),
      'branch_id', format('BR-%s', lpad(b.branch_no::text, 3, '0')),
      'account', 'CASH_DRAWER',
      'debit', round((13500 + b.branch_no * 390 + m.month_no * 590)::numeric, 2),
      'credit', round((11200 + b.branch_no * 360 + m.month_no * 540)::numeric, 2),
      'reference', format('MONTH_CLOSE_%s', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYYMM')),
      'period', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYY-MM'),
      'state', 'SIMULATION'
    ) order by m.month_no, b.branch_no) from generate_series(0, 11) as m(month_no) cross join generate_series(19, 27) as b(branch_no)),
    'vault_movements', (payload->'vault_movements') || (select jsonb_agg(jsonb_build_object(
      'id', format('VLT-Z%s-B%s', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYYMM'), lpad(b.branch_no::text, 3, '0')),
      'pledge_id', format('PLG-%s', lpad((158 + ((m.month_no * 9 + b.branch_no) % 75))::text, 3, '0')),
      'branch_id', format('BR-%s', lpad(b.branch_no::text, 3, '0')),
      'event', 'CHECK_IN', 'location', format('VAULT-%s-%s', chr(64 + ((b.branch_no - 1) % 6) + 1), lpad((((b.branch_no - 1) % 4) + 1)::text, 2, '0')),
      'actor', 'SYNTHETIC_VAULT', 'reason', 'MONTHLY_ACTIVITY_SIMULATED',
      'period', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYY-MM'), 'state', 'SIMULATION'
    ) order by m.month_no, b.branch_no) from generate_series(0, 11) as m(month_no) cross join generate_series(19, 27) as b(branch_no)),
    'auctions', (payload->'auctions') || (select jsonb_agg(jsonb_build_object(
      'id', format('AUC-Z%s-B%s', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYYMM'), lpad(b.branch_no::text, 3, '0')),
      'pledge_id', format('PLG-%s', lpad((158 + ((m.month_no * 9 + b.branch_no) % 75))::text, 3, '0')),
      'branch_id', format('BR-%s', lpad(b.branch_no::text, 3, '0')),
      'state', 'AUCTION_SIMULATED',
      'simulated_base_price', round((3250 + b.branch_no * 90 + m.month_no * 55)::numeric, 2),
      'simulated_sale_price', round((3525 + b.branch_no * 105 + m.month_no * 70)::numeric, 2),
      'period', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYY-MM'), 'state_classification', 'SIMULATION_ONLY'
    ) order by m.month_no, b.branch_no) from generate_series(0, 11) as m(month_no) cross join generate_series(19, 27) as b(branch_no) where (m.month_no + b.branch_no) % 4 = 0)
  )
where dataset_id = 'ARYP-DEMO-SEED-001'
  and not (payload ? 'franchisee_expansion_3');

update public.aryp_demo_seed
set payload = payload || jsonb_build_object('franchisee_expansion_3', jsonb_build_object('franchisees', 3, 'branches', 9, 'state', 'SIMULATION_ONLY'))
where dataset_id = 'ARYP-DEMO-SEED-001'
  and not (payload ? 'franchisee_expansion_3');
