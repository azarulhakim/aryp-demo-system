-- ARYP staging foundation. Synthetic data only; no production PII or money.
create schema if not exists extensions;
create extension if not exists pgcrypto with schema extensions;
create schema if not exists aryp_private;

create table if not exists public.aryp_demo_seed (
  dataset_id text primary key,
  version text not null,
  status text not null check (status = 'SYNTHETIC_ONLY'),
  classification text not null,
  payload jsonb not null,
  created_at timestamptz not null default now()
);

create table if not exists public.aryp_demo_state (
  id text primary key,
  pledge_state text not null,
  cash_balance numeric(14,2) not null,
  customer_fixture text not null,
  customer_risk text not null,
  customer_review text not null,
  customer_history jsonb not null default '[]'::jsonb,
  vault_state text not null,
  vault_acceptance jsonb not null default '{}'::jsonb,
  auction_state text not null,
  report_path text not null,
  day_end text not null,
  completion text not null,
  updated_at timestamptz not null default now()
);

create table if not exists public.aryp_memberships (
  user_id uuid primary key references auth.users(id) on delete cascade,
  role text not null check (role in ('FRANCHISOR_SUPERVISOR','BRANCH_MANAGER','EXECUTIVE','TELLER','VAULT_CUSTODIAN','AUDITOR')),
  branch_ids text[] not null default '{}',
  enabled boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.aryp_audit_events (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  correlation_id text not null,
  actor_user_id uuid not null references auth.users(id),
  actor_role text not null,
  branch_id text not null,
  action text not null,
  result text not null check (result in ('ALLOWED','DENIED')),
  detail jsonb not null default '{}'::jsonb,
  state text not null default 'SIMULATION' check (state = 'SIMULATION')
);

alter table public.aryp_demo_seed enable row level security;
alter table public.aryp_demo_state enable row level security;
alter table public.aryp_memberships enable row level security;
alter table public.aryp_audit_events enable row level security;

revoke all on public.aryp_demo_seed from anon, authenticated;
revoke all on public.aryp_demo_state from anon, authenticated;
revoke all on public.aryp_memberships from anon, authenticated;
revoke all on public.aryp_audit_events from anon, authenticated;

insert into public.aryp_demo_seed (dataset_id, version, status, classification, payload)
values (
  'ARYP-DEMO-SEED-001', '0.1', 'SYNTHETIC_ONLY', 'DEMO—NOT PRODUCTION',
  $$
  {
    "meta": {"dataset_id":"ARYP-DEMO-SEED-001","version":"0.1","status":"SYNTHETIC_ONLY","classification":"DEMO—NOT PRODUCTION","currency":"MYR-SIMULATION"},
    "branches": [
      {"id":"BR-001","franchisee_id":"FR-001","code":"DEMO-UTR-01","name":"Cawangan Demo Utara 1"},
      {"id":"BR-002","franchisee_id":"FR-001","code":"DEMO-UTR-02","name":"Cawangan Demo Utara 2"},
      {"id":"BR-003","franchisee_id":"FR-002","code":"DEMO-SLT-01","name":"Cawangan Demo Selatan 1"},
      {"id":"BR-004","franchisee_id":"FR-002","code":"DEMO-SLT-02","name":"Cawangan Demo Selatan 2"},
      {"id":"BR-005","franchisee_id":"FR-003","code":"DEMO-TMR-01","name":"Cawangan Demo Timur 1"},
      {"id":"BR-006","franchisee_id":"FR-003","code":"DEMO-TMR-02","name":"Cawangan Demo Timur 2"}
    ],
    "customers": [
      {"id":"CUS-001","display_name":"Pelanggan Demo A","identifier_masked":"SYN-0001","phone_masked":"+60-1X-XXXX001","status":"VERIFIED","risk_state":"CLEAR","branch_id":"BR-001"},
      {"id":"CUS-002","display_name":"Pelanggan Demo B","identifier_masked":"SYN-0002","phone_masked":"+60-1X-XXXX002","status":"VERIFIED","risk_state":"CLEAR","branch_id":"BR-001"},
      {"id":"CUS-003","display_name":"Pelanggan Repeat Demo","identifier_masked":"SYN-0003","phone_masked":"+60-1X-XXXX003","status":"VERIFIED","risk_state":"REPEAT_REVIEW","branch_id":"BR-001"},
      {"id":"CUS-004","display_name":"Pelanggan Heir Demo","identifier_masked":"SYN-0004","phone_masked":"+60-1X-XXXX004","status":"VERIFIED","risk_state":"HEIR_REVIEW","branch_id":"BR-002"},
      {"id":"CUS-005","display_name":"Pelanggan Blocked Demo","identifier_masked":"SYN-0005","phone_masked":"+60-1X-XXXX005","status":"ON_HOLD","risk_state":"BLACKLIST_REVIEW","branch_id":"BR-003"}
    ],
    "pledges": [
      {"id":"PLG-001","customer_id":"CUS-001","marhun_id":"MAR-001","branch_id":"BR-001","state":"PLEDGED_ACTIVE","simulated_financing":2730.0,"formula_version":"ASSUMED-CALC-0.1","approval_state":"APPROVED_FOR_DEMO_ONLY"},
      {"id":"PLG-002","customer_id":"CUS-002","marhun_id":"MAR-002","branch_id":"BR-001","state":"REDEMPTION_SIMULATED","simulated_financing":1467.2,"formula_version":"ASSUMED-CALC-0.1","approval_state":"APPROVED_FOR_DEMO_ONLY"},
      {"id":"PLG-003","customer_id":"CUS-003","marhun_id":"MAR-003","branch_id":"BR-001","state":"OVERDUE","simulated_financing":4221.0,"formula_version":"ASSUMED-CALC-0.1","approval_state":"APPROVED_FOR_DEMO_ONLY"},
      {"id":"PLG-004","customer_id":"CUS-004","marhun_id":"MAR-004","branch_id":"BR-002","state":"AUCTION_READY","simulated_financing":3376.8,"formula_version":"ASSUMED-CALC-0.1","approval_state":"APPROVED_FOR_DEMO_ONLY"}
    ]
  }
  $$::jsonb
)
on conflict (dataset_id) do update set version = excluded.version, status = excluded.status, classification = excluded.classification, payload = excluded.payload;

insert into public.aryp_demo_state (id, pledge_state, cash_balance, customer_fixture, customer_risk, customer_review, customer_history, vault_state, vault_acceptance, auction_state, report_path, day_end, completion)
values ('DEMO', 'PENDING_SIGNATURE', 37580.00, 'CUS-001', 'CLEAR', 'NONE', '[]'::jsonb, 'PENDING', '{}'::jsonb, 'READY', 'FR-001', 'OPEN', 'PENDING')
on conflict (id) do nothing;

create index if not exists aryp_audit_events_created_at_idx on public.aryp_audit_events (created_at desc);
create index if not exists aryp_audit_events_branch_id_idx on public.aryp_audit_events (branch_id);
