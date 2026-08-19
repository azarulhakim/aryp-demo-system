-- ARYP staging extension: versioned hosting, residency and deployment assumptions.
-- This is an inventory of current configuration, not a production approval.

create table if not exists public.aryp_deployment_policies (
  id text primary key,
  policy_key text not null,
  version text not null,
  status text not null check (status in ('DRAFT','ACTIVE','RETIRED')),
  classification text not null default 'ASSUMED—NOT APPROVED',
  source_reference text not null default 'CLIENT_TO_CONFIRM',
  parameters jsonb not null default '{}'::jsonb,
  effective_from timestamptz not null default now(),
  created_at timestamptz not null default now(),
  unique (policy_key, version)
);

alter table public.aryp_deployment_policies enable row level security;
revoke all on public.aryp_deployment_policies from anon, authenticated;

insert into public.aryp_deployment_policies (id, policy_key, version, status, classification, source_reference, parameters)
values (
  'DEPLOYMENT-ASSUMED-0.1',
  'DEPLOYMENT_DEFAULT',
  'ASSUMED-HOSTING-0.1',
  'ACTIVE',
  'ASSUMED—NOT APPROVED',
  'CLIENT_TO_CONFIRM',
  '{"environment":"SYNTHETIC_ONLY","hosting_provider":"CLOUDFLARE_WORKERS","cloudflare_account_id":"1a31137d59cff2a0b541cdcd28600bc8","database_provider":"SUPABASE","supabase_project_ref":"ywfmbygeximvrbfniify","region":"CURRENT_CONFIG_UNVERIFIED","residency":"PENDING_CLIENT","cross_border":"PENDING_CLIENT","subprocessors":"PENDING_CLIENT","production_approved":false,"rollback":"REQUIRED_BEFORE_RELEASE"}'::jsonb
)
on conflict (id) do update set
  status = excluded.status,
  classification = excluded.classification,
  source_reference = excluded.source_reference,
  parameters = excluded.parameters;

create index if not exists aryp_deployment_policies_status_idx
  on public.aryp_deployment_policies (policy_key, status, effective_from desc);
