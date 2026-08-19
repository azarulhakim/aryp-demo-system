-- ARYP staging extension: versioned regulatory-rule registry.
-- Entries are workflow placeholders only; they do not assert legal applicability.

create table if not exists public.aryp_regulatory_rules (
  id text primary key,
  rule_key text not null,
  version text not null,
  status text not null check (status in ('DRAFT','ACTIVE','RETIRED')),
  classification text not null default 'ASSUMED—NOT APPROVED',
  domain text not null,
  title text not null,
  source_reference text not null default 'CLIENT_TO_CONFIRM',
  applicability_status text not null default 'PENDING_CLIENT' check (applicability_status in ('PENDING_CLIENT','APPLICABLE','NOT_APPLICABLE','CONFLICT_REVIEW')),
  parameters jsonb not null default '{}'::jsonb,
  effective_from timestamptz not null default now(),
  created_at timestamptz not null default now(),
  unique (rule_key, version)
);

alter table public.aryp_regulatory_rules enable row level security;
revoke all on public.aryp_regulatory_rules from anon, authenticated;

insert into public.aryp_regulatory_rules (id, rule_key, version, status, classification, domain, title, source_reference, applicability_status, parameters)
values
  ('REG-RULE-001','REGULATORY_PERIMETER','ASSUMED-REG-0.1','ACTIVE','ASSUMED—NOT APPROVED','PERIMETER','Entity, licence and jurisdiction applicability','CLIENT_TO_CONFIRM','PENDING_CLIENT','{"decision_owner":"CLIENT_LEGAL_RISK","evidence_required":true,"conflict_handling":"HOLD_AND_ESCALATE"}'::jsonb),
  ('REG-RULE-002','AML_CDD','ASSUMED-REG-0.1','ACTIVE','ASSUMED—NOT APPROVED','FINANCIAL_CRIME','Customer due diligence and suspicious-activity workflow','CLIENT_TO_CONFIRM','PENDING_CLIENT','{"decision_owner":"CLIENT_COMPLIANCE","evidence_required":true,"automation":"CONFIGURABLE_ONLY"}'::jsonb),
  ('REG-RULE-003','PRIVACY_DATA_PROTECTION','ASSUMED-REG-0.1','ACTIVE','ASSUMED—NOT APPROVED','PRIVACY','Personal-data protection applicability and duties','CLIENT_TO_CONFIRM','PENDING_CLIENT','{"decision_owner":"CLIENT_DPO_LEGAL","evidence_required":true,"legal_basis":"PENDING_CLIENT"}'::jsonb),
  ('REG-RULE-004','TAX_INVOICE','ASSUMED-REG-0.1','ACTIVE','ASSUMED—NOT APPROVED','TAX','Tax, invoice and reporting applicability','CLIENT_TO_CONFIRM','PENDING_CLIENT','{"decision_owner":"CLIENT_FINANCE_TAX","evidence_required":true,"provider":"MOCK_ONLY"}'::jsonb),
  ('REG-RULE-005','E_SIGNATURE_RECORDS','ASSUMED-REG-0.1','ACTIVE','ASSUMED—NOT APPROVED','RECORDS','Electronic signature and record admissibility','CLIENT_TO_CONFIRM','PENDING_CLIENT','{"decision_owner":"CLIENT_LEGAL_RISK","evidence_required":true,"provider":"MOCK_ONLY"}'::jsonb),
  ('REG-RULE-006','AUCTION_SURPLUS_SHORTFALL','ASSUMED-REG-0.1','ACTIVE','ASSUMED—NOT APPROVED','AUCTION','Surplus, shortfall and unclaimed-value treatment','CLIENT_TO_CONFIRM','PENDING_CLIENT','{"decision_owner":"CLIENT_LEGAL_FINANCE","evidence_required":true,"settlement":"SIMULATION_ONLY"}'::jsonb),
  ('REG-RULE-007','CYBER_INCIDENT_REPORTING','ASSUMED-REG-0.1','ACTIVE','ASSUMED—NOT APPROVED','CYBERSECURITY','Incident classification, reporting and evidence workflow','CLIENT_TO_CONFIRM','PENDING_CLIENT','{"decision_owner":"CLIENT_SECURITY_LEGAL","evidence_required":true,"notification":"CONFIGURABLE_HOOK"}'::jsonb)
on conflict (id) do update set
  status = excluded.status,
  classification = excluded.classification,
  source_reference = excluded.source_reference,
  applicability_status = excluded.applicability_status,
  parameters = excluded.parameters;

create index if not exists aryp_regulatory_rules_status_idx
  on public.aryp_regulatory_rules (status, domain, effective_from desc);
