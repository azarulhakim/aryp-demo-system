-- ARYP staging extension: explicit release gate registry.
-- Gates are tracking controls only; no gate is automatically approved.

create table if not exists public.aryp_release_gates (
  id text primary key,
  gate_key text not null unique,
  stage text not null check (stage in ('DESIGN','BUILD','UAT','PILOT','PRODUCTION')),
  title text not null,
  status text not null default 'PENDING' check (status in ('PENDING','IN_REVIEW','PASSED','BLOCKED','WAIVED')),
  classification text not null default 'ASSUMED—NOT APPROVED',
  required_evidence jsonb not null default '[]'::jsonb,
  required_signoffs jsonb not null default '[]'::jsonb,
  blocker_policy text not null default 'NO_PRODUCTION_WITHOUT_PASS',
  updated_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

alter table public.aryp_release_gates enable row level security;
revoke all on public.aryp_release_gates from anon, authenticated;

insert into public.aryp_release_gates (id, gate_key, stage, title, required_evidence, required_signoffs)
values
  ('GATE-01','G1','DESIGN','Governance, scope and decision ownership','["RACI","scope baseline","decision register"]'::jsonb,'["Sponsor","Product Owner"]'::jsonb),
  ('GATE-02','G2','DESIGN','Organisation, tenancy and IAM','["tenant model","role matrix","SoD matrix"]'::jsonb,'["Operations","Security","Data Owner"]'::jsonb),
  ('GATE-03','G3','DESIGN','Customer, KYC and data model','["data dictionary","KYC policy","dedupe rules"]'::jsonb,'["Operations","Legal/Compliance","DPO"]'::jsonb),
  ('GATE-04','G4','DESIGN','Product, Shariah and contract sequence','["product paper","akad sequence","glossary"]'::jsonb,'["Shariah","Legal","Product Owner"]'::jsonb),
  ('GATE-05','G5','DESIGN','Valuation and calculation golden cases','["price policy","formula version","golden tests"]'::jsonb,'["Finance","Shariah","Valuation Lead"]'::jsonb),
  ('GATE-06','G6','DESIGN','Privacy, consent and lifecycle','["privacy notice","DPIA/assessment","retention/legal hold"]'::jsonb,'["DPO","Legal","Data Owner"]'::jsonb),
  ('GATE-07','G7','DESIGN','Security, access and fraud controls','["threat model","IAM/UAT evidence","incident runbook"]'::jsonb,'["Security","Risk","Technology"]'::jsonb),
  ('GATE-08','G8','BUILD','Operations, integrations and custody','["adapter contracts","vault SOP","reconciliation tests"]'::jsonb,'["Operations","Finance","Vault Owner"]'::jsonb),
  ('GATE-09','G9','BUILD','Architecture, NFR and business continuity','["architecture","NFR baseline","backup/restore drill"]'::jsonb,'["Technology","Risk","Operations"]'::jsonb),
  ('GATE-10','G10','BUILD','Build, QA and security verification','["automated tests","security scan","traceability"]'::jsonb,'["QA","Security","Product Owner"]'::jsonb),
  ('GATE-11','G11','PILOT','UAT, pilot readiness and training','["UAT sign-off","pilot evidence","training records"]'::jsonb,'["Business","Operations","Sponsor"]'::jsonb),
  ('GATE-12','G12','PRODUCTION','Regulatory, go-live and rollback approval','["regulatory applicability","production runbook","rollback evidence"]'::jsonb,'["Legal/Compliance","Security","DPO","Sponsor"]'::jsonb)
on conflict (gate_key) do update set
  stage = excluded.stage,
  title = excluded.title,
  required_evidence = excluded.required_evidence,
  required_signoffs = excluded.required_signoffs;

create index if not exists aryp_release_gates_stage_status_idx
  on public.aryp_release_gates (stage, status);
