-- ARYP expanded synthetic network and twelve-month history.
-- Demo-only: generated records contain no real customer, money or provider data.

insert into public.aryp_organizations (id, organization_type, parent_organization_id, code, name, legal_name)
values
  ('FR-004','FRANCHISEE','ORG-ARYP','FR-004','Franchisee Demo Barat','Franchisee Demo Barat Sdn. Bhd.'),
  ('FR-005','FRANCHISEE','ORG-ARYP','FR-005','Franchisee Demo Pantai Timur','Franchisee Demo Pantai Timur Sdn. Bhd.'),
  ('FR-006','FRANCHISEE','ORG-ARYP','FR-006','Franchisee Demo Borneo','Franchisee Demo Borneo Sdn. Bhd.')
on conflict (id) do update set name = excluded.name, legal_name = excluded.legal_name, parent_organization_id = excluded.parent_organization_id, updated_at = now();

insert into public.aryp_branches (id, organization_id, code, name, metadata)
values
  ('BR-007','FR-001','DEMO-UTR-03','Cawangan Demo Utara 3','{"demo_region":"UTARA","opened":"2025-09-01"}'::jsonb),
  ('BR-008','FR-002','DEMO-SLT-03','Cawangan Demo Selatan 3','{"demo_region":"SELATAN","opened":"2025-09-09"}'::jsonb),
  ('BR-009','FR-003','DEMO-TMR-03','Cawangan Demo Timur 3','{"demo_region":"TIMUR","opened":"2025-09-16"}'::jsonb),
  ('BR-010','FR-004','DEMO-BRT-01','Cawangan Demo Barat 1','{"demo_region":"BARAT","opened":"2025-09-23"}'::jsonb),
  ('BR-011','FR-004','DEMO-BRT-02','Cawangan Demo Barat 2','{"demo_region":"BARAT","opened":"2025-10-01"}'::jsonb),
  ('BR-012','FR-004','DEMO-BRT-03','Cawangan Demo Barat 3','{"demo_region":"BARAT","opened":"2025-10-08"}'::jsonb),
  ('BR-013','FR-005','DEMO-PTG-01','Cawangan Demo Pantai Timur 1','{"demo_region":"PANTAI_TIMUR","opened":"2025-10-15"}'::jsonb),
  ('BR-014','FR-005','DEMO-PTG-02','Cawangan Demo Pantai Timur 2','{"demo_region":"PANTAI_TIMUR","opened":"2025-10-22"}'::jsonb),
  ('BR-015','FR-005','DEMO-PTG-03','Cawangan Demo Pantai Timur 3','{"demo_region":"PANTAI_TIMUR","opened":"2025-11-01"}'::jsonb),
  ('BR-016','FR-006','DEMO-BOR-01','Cawangan Demo Borneo 1','{"demo_region":"BORNEO","opened":"2025-11-08"}'::jsonb),
  ('BR-017','FR-006','DEMO-BOR-02','Cawangan Demo Borneo 2','{"demo_region":"BORNEO","opened":"2025-11-15"}'::jsonb),
  ('BR-018','FR-006','DEMO-BOR-03','Cawangan Demo Borneo 3','{"demo_region":"BORNEO","opened":"2025-11-22"}'::jsonb)
on conflict (id) do update set organization_id = excluded.organization_id, code = excluded.code, name = excluded.name, metadata = excluded.metadata, updated_at = now();

update public.aryp_demo_seed
set payload = payload
  || jsonb_build_object(
    'branches', (select jsonb_agg(jsonb_build_object(
      'id', b.id, 'franchisee_id', b.organization_id, 'code', b.code, 'name', b.name
    ) order by b.id) from public.aryp_branches b where b.status = 'ACTIVE'),
    'customers', (payload->'customers') || (select jsonb_agg(jsonb_build_object(
      'id', format('CUS-%s', lpad(g.n::text, 3, '0')),
      'display_name', format('Pelanggan Demo Tahun %s', lpad(g.n::text, 3, '0')),
      'identifier_masked', format('SYN-%s', lpad(g.n::text, 4, '0')),
      'phone_masked', format('+60-1X-XXXX%s', lpad(g.n::text, 3, '0')),
      'status', case when g.n % 29 = 0 then 'ON_HOLD' else 'VERIFIED' end,
      'risk_state', case when g.n % 29 = 0 then 'BLACKLIST_REVIEW' when g.n % 11 = 0 then 'REPEAT_REVIEW' else 'CLEAR' end,
      'branch_id', format('BR-%s', lpad((((g.n - 9) % 18) + 1)::text, 3, '0')),
      'registered_on', to_char((date '2025-09-01' + (((g.n - 9) % 365) * interval '1 day'))::date, 'YYYY-MM-DD')
    ) order by g.n) from generate_series(9, 188) as g(n)),
    'pledges', (payload->'pledges') || (select jsonb_agg(jsonb_build_object(
      'id', format('PLG-%s', lpad(g.n::text, 3, '0')),
      'customer_id', format('CUS-%s', lpad((9 + ((g.n - 8) % 180))::text, 3, '0')),
      'marhun_id', format('MAR-%s', lpad(g.n::text, 3, '0')),
      'branch_id', format('BR-%s', lpad((((g.n - 8) % 18) + 1)::text, 3, '0')),
      'state', case when g.n % 17 = 0 then 'AUCTION_READY' when g.n % 13 = 0 then 'OVERDUE' when g.n % 7 = 0 then 'REDEMPTION_SIMULATED' else 'PLEDGED_ACTIVE' end,
      'simulated_financing', round((1450 + ((g.n * 137) % 4600))::numeric, 2),
      'formula_version', 'ASSUMED-UPAH-SIMPAN-0.2',
      'approval_state', 'APPROVED_FOR_DEMO_ONLY',
      'pledged_on', to_char((date '2025-09-01' + (((g.n - 8) * 2) % 365) * interval '1 day')::date, 'YYYY-MM-DD')
    ) order by g.n) from generate_series(8, 157) as g(n)),
    'marhun_items', (payload->'marhun_items') || (select jsonb_agg(jsonb_build_object(
      'id', format('MAR-%s', lpad(g.n::text, 3, '0')),
      'customer_id', format('CUS-%s', lpad((9 + ((g.n - 8) % 180))::text, 3, '0')),
      'branch_id', format('BR-%s', lpad((((g.n - 8) % 18) + 1)::text, 3, '0')),
      'description', case when g.n % 3 = 0 then 'Rantai emas demo tahunan' when g.n % 3 = 1 then 'Cincin emas demo tahunan' else 'Gelang emas demo tahunan' end,
      'purity', case when g.n % 4 = 0 then '999' else '916' end,
      'weight_grams', round((2.5 + ((g.n * 17) % 90) / 10.0)::numeric, 2),
      'simulated_nm', round((1450 + ((g.n * 137) % 4600))::numeric, 2),
      'valuation_state', 'PROVISIONAL'
    ) order by g.n) from generate_series(8, 157) as g(n)),
    'branch_monthly_metrics', (select jsonb_agg(jsonb_build_object(
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
    ) order by m.month_no, b.branch_no) from generate_series(0, 11) as m(month_no) cross join generate_series(1, 18) as b(branch_no)),
    'yearly_history', (select jsonb_agg(jsonb_build_object(
      'period', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYY-MM'),
      'label', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'Mon YYYY'),
      'customers_new', (select sum(5 + ((b.branch_no * 3 + m.month_no) % 14)) from generate_series(1, 18) as b(branch_no)),
      'pledges_count', (select sum(7 + ((b.branch_no * 5 + m.month_no * 2) % 19)) from generate_series(1, 18) as b(branch_no)),
      'redemptions_count', (select sum(2 + ((b.branch_no + m.month_no) % 8)) from generate_series(1, 18) as b(branch_no)),
      'auction_count', (select count(*) from generate_series(1, 18) as b(branch_no) where (b.branch_no + m.month_no) % 7 = 0),
      'financing_amount', (select sum(18000 + b.branch_no * 725 + m.month_no * 940 + ((b.branch_no * m.month_no) % 9) * 110) from generate_series(1, 18) as b(branch_no))
    ) order by m.month_no) from generate_series(0, 11) as m(month_no)),
    'cash_drawers', (payload->'cash_drawers') || (select jsonb_agg(jsonb_build_object(
      'id', format('DRAWER-BR%s-T01', lpad(b.branch_no::text, 3, '0')),
      'branch_id', format('BR-%s', lpad(b.branch_no::text, 3, '0')),
      'business_date', '2026-08-15',
      'opening_float', 10000.00 + (b.branch_no * 250),
      'cash_in', 18500.00 + (b.branch_no * 375),
      'cash_out', 14200.00 + (b.branch_no * 425),
      'expected_balance', 14300.00 + (b.branch_no * 200),
      'counted_balance', 14300.00 + (b.branch_no * 200),
      'variance', 0.00,
      'state', 'CLOSED_SIMULATED'
    ) order by b.branch_no) from generate_series(1, 18) as b(branch_no)),
    'activity_events', (select jsonb_agg(jsonb_build_object(
      'id', format('ACT-%s-%s', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYYMM'), lpad(b.branch_no::text, 3, '0')),
      'period', to_char((date '2025-09-01' + (m.month_no * interval '1 month'))::date, 'YYYY-MM'),
      'branch_id', format('BR-%s', lpad(b.branch_no::text, 3, '0')),
      'event', 'MONTHLY_CLOSE_SIMULATED',
      'state', 'SIMULATION_ONLY'
    ) order by m.month_no, b.branch_no) from generate_series(0, 11) as m(month_no) cross join generate_series(1, 18) as b(branch_no))
  )
where dataset_id = 'ARYP-DEMO-SEED-001'
  and not (payload ? 'yearly_history');

comment on table public.aryp_demo_seed is 'Synthetic ARYP demo dataset with 18 branches and 12-month generated history; never production data.';
