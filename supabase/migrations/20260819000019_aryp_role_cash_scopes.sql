-- Expand the cash drawer fixture so role-scoped dashboards do not all show
-- the same single-branch balance. Demo-only / synthetic data.
with branch_fixture as (
  select id, row_number() over (order by id)::numeric as rn
  from public.aryp_branches
  where status = 'ACTIVE'
), drawer_fixture as (
  select jsonb_agg(
    jsonb_build_object(
      'id', format('DRAWER-%s-T01', id),
      'branch_id', id,
      'business_date', '2026-08-19',
      'opening_float', round((10000 + rn * 500)::numeric, 2),
      'cash_in', round((1800 + mod(rn * 137, 2400))::numeric, 2),
      'cash_out', round((900 + mod(rn * 91, 1500))::numeric, 2),
      'expected_balance', round((10000 + rn * 500 + 1800 + mod(rn * 137, 2400) - 900 - mod(rn * 91, 1500))::numeric, 2),
      'counted_balance', round((10000 + rn * 500 + 1800 + mod(rn * 137, 2400) - 900 - mod(rn * 91, 1500))::numeric, 2),
      'variance', 0,
      'state', 'OPEN_SIMULATED'
    ) order by id
  ) as drawers
  from branch_fixture
)
update public.aryp_demo_seed seed
set payload = seed.payload || jsonb_build_object('cash_drawers', drawer_fixture.drawers)
from drawer_fixture
where seed.dataset_id = 'ARYP-DEMO-SEED-001';

-- Every transactional fixture must carry a branch scope. The initial three
-- payment fixtures predate the hierarchy model and are assigned to BR-001.
update public.aryp_demo_seed seed
set payload = seed.payload || jsonb_build_object(
  'payments', (
    select jsonb_agg(
      case when item ? 'branch_id' then item else item || jsonb_build_object('branch_id', 'BR-001') end
      order by item->>'id'
    )
    from jsonb_array_elements(seed.payload->'payments') as payment(item)
  )
)
where seed.dataset_id = 'ARYP-DEMO-SEED-001';
