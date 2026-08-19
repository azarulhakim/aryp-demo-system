-- ARYP staging extension: configurable formula versions and maker-checker state.
-- Synthetic/provisional only; no production policy approval is implied.

create table if not exists public.aryp_formula_versions (
  id text primary key,
  formula_key text not null,
  version text not null,
  status text not null check (status in ('DRAFT','ACTIVE','RETIRED')),
  classification text not null default 'ASSUMED—NOT APPROVED',
  parameters jsonb not null default '{}'::jsonb,
  effective_from timestamptz not null default now(),
  created_at timestamptz not null default now(),
  unique (formula_key, version)
);

alter table public.aryp_demo_state add column if not exists formula_key text not null default 'FINANCING_DEFAULT';
alter table public.aryp_demo_state add column if not exists formula_version text not null default 'ASSUMED-CALC-0.1';
alter table public.aryp_demo_state add column if not exists maker_user_id uuid references auth.users(id);
alter table public.aryp_demo_state add column if not exists approver_user_id uuid references auth.users(id);
alter table public.aryp_demo_state add column if not exists approval_state text not null default 'PENDING_SIGNATURE';

alter table public.aryp_formula_versions enable row level security;
revoke all on public.aryp_formula_versions from anon, authenticated;

insert into public.aryp_formula_versions (id, formula_key, version, status, classification, parameters)
values (
  'FORMULA-FINANCING-ASSUMED-0.1',
  'FINANCING_DEFAULT',
  'ASSUMED-CALC-0.1',
  'ACTIVE',
  'ASSUMED—NOT APPROVED',
  '{"margin_rate":0.70,"fee_rate":0.00,"rounding":"0.01","minimum_days":15,"maximum_days":120,"currency":"MYR-SIMULATION"}'::jsonb
)
on conflict (id) do update set
  status = excluded.status,
  classification = excluded.classification,
  parameters = excluded.parameters;

create index if not exists aryp_formula_versions_key_status_idx
  on public.aryp_formula_versions (formula_key, status, effective_from desc);
