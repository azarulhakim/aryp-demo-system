-- ARYP staging extension: configurable NFR targets and observation hooks.
-- Numeric acceptance targets remain unset until client/NFR sign-off.

create table if not exists public.aryp_nfr_policies (
  id text primary key,
  nfr_key text not null,
  version text not null,
  status text not null check (status in ('DRAFT','ACTIVE','RETIRED')),
  classification text not null default 'ASSUMED—NOT APPROVED',
  domain text not null,
  title text not null,
  source_reference text not null default 'CLIENT_TO_CONFIRM',
  parameters jsonb not null default '{}'::jsonb,
  effective_from timestamptz not null default now(),
  created_at timestamptz not null default now(),
  unique (nfr_key, version)
);

alter table public.aryp_nfr_policies enable row level security;
revoke all on public.aryp_nfr_policies from anon, authenticated;

insert into public.aryp_nfr_policies (id, nfr_key, version, status, classification, domain, title, source_reference, parameters)
values
  ('NFR-001','PERFORMANCE_LATENCY','ASSUMED-NFR-0.1','ACTIVE','ASSUMED—NOT APPROVED','PERFORMANCE','Latency and throughput baseline','CLIENT_TO_CONFIRM','{"p95_ms":null,"p99_ms":null,"volume_per_day":null,"measurement":"BASELINE_REQUIRED","acceptance":"PENDING_CLIENT"}'::jsonb),
  ('NFR-002','AVAILABILITY','ASSUMED-NFR-0.1','ACTIVE','ASSUMED—NOT APPROVED','AVAILABILITY','Availability and service continuity','CLIENT_TO_CONFIRM','{"uptime_percent":null,"measurement_window":"PENDING_CLIENT","maintenance_window":"PENDING_CLIENT","acceptance":"PENDING_CLIENT"}'::jsonb),
  ('NFR-003','RECOVERY_RTO_RPO','ASSUMED-NFR-0.1','ACTIVE','ASSUMED—NOT APPROVED','RESILIENCE','Backup, restore, RTO and RPO','CLIENT_TO_CONFIRM','{"rto_minutes":null,"rpo_minutes":null,"restore_drill_enabled":true,"backup_owner":"CLIENT_TO_CONFIRM","acceptance":"PENDING_CLIENT"}'::jsonb),
  ('NFR-004','ACCESSIBILITY','ASSUMED-NFR-0.1','ACTIVE','ASSUMED—NOT APPROVED','ACCESSIBILITY','Accessibility working target','CLIENT_TO_CONFIRM','{"working_target":"WCAG_2_2_AA","acceptance":"PENDING_CLIENT","device_matrix":"PENDING_CLIENT"}'::jsonb),
  ('NFR-005','OBSERVABILITY_SUPPORT','ASSUMED-NFR-0.1','ACTIVE','ASSUMED—NOT APPROVED','OPERATIONS','Metrics, alerting and support access','CLIENT_TO_CONFIRM','{"metrics_enabled":true,"correlation_id":true,"pii_in_logs":false,"log_retention_days":null,"on_call":"PENDING_CLIENT","acceptance":"PENDING_CLIENT"}'::jsonb),
  ('NFR-006','SECURITY_TEST_HARNESS','ASSUMED-NFR-0.1','ACTIVE','ASSUMED—NOT APPROVED','SECURITY','Load, restore and security test harness','CLIENT_TO_CONFIRM','{"load_test_enabled":true,"restore_test_enabled":true,"dependency_scan_enabled":true,"acceptance":"PENDING_CLIENT"}'::jsonb)
on conflict (id) do update set
  status = excluded.status,
  classification = excluded.classification,
  source_reference = excluded.source_reference,
  parameters = excluded.parameters;

create index if not exists aryp_nfr_policies_status_idx
  on public.aryp_nfr_policies (status, domain, effective_from desc);
