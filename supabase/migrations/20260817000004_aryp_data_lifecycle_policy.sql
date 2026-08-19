-- ARYP staging extension: configurable retention and legal-hold hooks.
-- No retention duration is approved; destructive deletion remains disabled in demo.

create table if not exists public.aryp_data_policies (
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

alter table public.aryp_demo_state add column if not exists retention_policy_key text not null default 'DATA_LIFECYCLE_DEFAULT';
alter table public.aryp_demo_state add column if not exists retention_policy_version text not null default 'ASSUMED-RETENTION-0.1';
alter table public.aryp_demo_state add column if not exists legal_hold_state text not null default 'NOT_APPLIED' check (legal_hold_state in ('NOT_APPLIED','ACTIVE','RELEASED'));
alter table public.aryp_demo_state add column if not exists legal_hold_reason text;
alter table public.aryp_demo_state add column if not exists legal_hold_user_id uuid references auth.users(id);

alter table public.aryp_data_policies enable row level security;
revoke all on public.aryp_data_policies from anon, authenticated;

insert into public.aryp_data_policies (id, policy_key, version, status, classification, parameters)
values (
  'DATA-LIFECYCLE-ASSUMED-0.1',
  'DATA_LIFECYCLE_DEFAULT',
  'ASSUMED-RETENTION-0.1',
  'ACTIVE',
  'ASSUMED—NOT APPROVED',
  '{"retention_days":null,"retention_decision":"PENDING_CLIENT","deletion_mode":"DISABLED_IN_DEMO","legal_hold_supported":true,"legal_hold_release":"AUTHORIZED_REVIEW_ONLY"}'::jsonb
)
on conflict (id) do update set
  status = excluded.status,
  classification = excluded.classification,
  parameters = excluded.parameters;

create index if not exists aryp_data_policies_key_status_idx
  on public.aryp_data_policies (policy_key, status, effective_from desc);
