-- ARYP staging extension: configurable privacy notice, consent and DSR hooks.
-- No legal basis or production retention rule is asserted by this migration.

create table if not exists public.aryp_privacy_policies (
  id text primary key,
  policy_key text not null,
  version text not null,
  status text not null check (status in ('DRAFT','ACTIVE','RETIRED')),
  classification text not null default 'ASSUMED—NOT APPROVED',
  parameters jsonb not null default '{}'::jsonb,
  effective_from timestamptz not null default now(),
  created_at timestamptz not null default now(),
  unique (policy_key, version)
);

alter table public.aryp_demo_state add column if not exists privacy_policy_key text not null default 'PRIVACY_DEFAULT';
alter table public.aryp_demo_state add column if not exists privacy_policy_version text not null default 'ASSUMED-PRIVACY-0.1';
alter table public.aryp_demo_state add column if not exists consent_state text not null default 'NOT_CAPTURED' check (consent_state in ('NOT_CAPTURED','RECORDED_SIMULATED','WITHDRAWN_SIMULATED'));
alter table public.aryp_demo_state add column if not exists consent_recorded_at timestamptz;
alter table public.aryp_demo_state add column if not exists consent_user_id uuid references auth.users(id);
alter table public.aryp_demo_state add column if not exists privacy_request_type text;
alter table public.aryp_demo_state add column if not exists privacy_request_state text not null default 'NONE' check (privacy_request_state in ('NONE','REQUESTED_SIMULATED','CLOSED_SIMULATED'));
alter table public.aryp_demo_state add column if not exists privacy_request_user_id uuid references auth.users(id);

alter table public.aryp_privacy_policies enable row level security;
revoke all on public.aryp_privacy_policies from anon, authenticated;

insert into public.aryp_privacy_policies (id, policy_key, version, status, classification, parameters)
values (
  'PRIVACY-ASSUMED-0.1',
  'PRIVACY_DEFAULT',
  'ASSUMED-PRIVACY-0.1',
  'ACTIVE',
  'ASSUMED—NOT APPROVED',
  '{"notice_status":"DRAFT_FOR_CLIENT_REVIEW","consent_required":null,"legal_basis":null,"purposes":["PENDING_CLIENT"],"dsr_enabled":true,"erasure_mode":"DISABLED_IN_DEMO","breach_workflow":"CONFIGURABLE_HOOK"}'::jsonb
)
on conflict (id) do update set
  status = excluded.status,
  classification = excluded.classification,
  parameters = excluded.parameters;

create index if not exists aryp_privacy_policies_key_status_idx
  on public.aryp_privacy_policies (policy_key, status, effective_from desc);
