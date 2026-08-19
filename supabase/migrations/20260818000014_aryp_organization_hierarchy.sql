-- ARYP organisation hierarchy. Assumption baseline; replace names, codes and role
-- semantics after client confirmation. The hierarchy is intentionally separate
-- from the demo payload so it can become the production master data source.
create table if not exists public.aryp_organizations (
  id text primary key,
  organization_type text not null check (organization_type in ('FRANCHISOR','FRANCHISEE','SERVICE_PROVIDER')),
  parent_organization_id text references public.aryp_organizations(id),
  code text not null unique,
  name text not null,
  legal_name text,
  status text not null default 'ACTIVE' check (status in ('ACTIVE','INACTIVE','PENDING')),
  country_code text not null default 'MY',
  timezone text not null default 'Asia/Kuala_Lumpur',
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.aryp_branches (
  id text primary key,
  organization_id text not null references public.aryp_organizations(id),
  code text not null unique,
  name text not null,
  status text not null default 'ACTIVE' check (status in ('ACTIVE','INACTIVE','PENDING')),
  address jsonb not null default '{}'::jsonb,
  contact jsonb not null default '{}'::jsonb,
  timezone text not null default 'Asia/Kuala_Lumpur',
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.aryp_role_catalog (
  role_key text primary key,
  label_ms text not null,
  scope_type text not null check (scope_type in ('NETWORK','ORGANIZATION','BRANCH')),
  description text not null default '',
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.aryp_user_memberships (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  organization_id text not null references public.aryp_organizations(id),
  branch_id text references public.aryp_branches(id),
  role_key text not null references public.aryp_role_catalog(role_key),
  is_primary boolean not null default false,
  enabled boolean not null default true,
  valid_from timestamptz not null default now(),
  valid_until timestamptz,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (valid_until is null or valid_until > valid_from)
);

create unique index if not exists aryp_user_memberships_scope_role_uq
  on public.aryp_user_memberships (user_id, organization_id, coalesce(branch_id, ''), role_key);
create unique index if not exists aryp_user_memberships_primary_uq
  on public.aryp_user_memberships (user_id) where is_primary and enabled;
create index if not exists aryp_organizations_parent_idx on public.aryp_organizations(parent_organization_id);
create index if not exists aryp_branches_org_idx on public.aryp_branches(organization_id);
create index if not exists aryp_memberships_user_idx on public.aryp_user_memberships(user_id) where enabled;
create index if not exists aryp_memberships_org_idx on public.aryp_user_memberships(organization_id);
create index if not exists aryp_memberships_branch_idx on public.aryp_user_memberships(branch_id);
create index if not exists aryp_memberships_role_idx on public.aryp_user_memberships(role_key);

alter table public.aryp_organizations enable row level security;
alter table public.aryp_branches enable row level security;
alter table public.aryp_role_catalog enable row level security;
alter table public.aryp_user_memberships enable row level security;
revoke all on public.aryp_organizations from anon, authenticated;
revoke all on public.aryp_branches from anon, authenticated;
revoke all on public.aryp_role_catalog from anon, authenticated;
revoke all on public.aryp_user_memberships from anon, authenticated;

insert into public.aryp_role_catalog (role_key, label_ms, scope_type, description)
values
  ('FRANCHISOR_SUPERVISOR','Penyelia Francaisor','NETWORK','Akses network dan tadbir urus francaisor'),
  ('FRANCHISEE_ADMIN','Pentadbir Franchisee','ORGANIZATION','Pentadbir satu organisasi franchisee'),
  ('BRANCH_MANAGER','Pengurus Cawangan','BRANCH','Operasi dan kelulusan cawangan'),
  ('TELLER','Teller','BRANCH','Pelanggan, gadaian dan transaksi kaunter'),
  ('VAULT_CUSTODIAN','Custodian Vault','BRANCH','Penjagaan dan pergerakan vault'),
  ('EXECUTIVE','Eksekutif','ORGANIZATION','Semakan operasi dan keputusan pengurusan'),
  ('AUDITOR','Auditor','NETWORK','Audit dan pemantauan rentas organisasi')
on conflict (role_key) do update set label_ms = excluded.label_ms, scope_type = excluded.scope_type, description = excluded.description;

insert into public.aryp_organizations (id, organization_type, parent_organization_id, code, name, legal_name)
values
  ('ORG-ARYP','FRANCHISOR',null,'ARYP','AR-Rahnu YaPEIM Premier','AR-Rahnu YaPEIM Premier'),
  ('FR-001','FRANCHISEE','ORG-ARYP','FR-001','Franchisee Demo Utara','Franchisee Demo Utara Sdn. Bhd.'),
  ('FR-002','FRANCHISEE','ORG-ARYP','FR-002','Franchisee Demo Selatan','Franchisee Demo Selatan Sdn. Bhd.'),
  ('FR-003','FRANCHISEE','ORG-ARYP','FR-003','Franchisee Demo Timur','Franchisee Demo Timur Sdn. Bhd.')
on conflict (id) do update set parent_organization_id = excluded.parent_organization_id, code = excluded.code, name = excluded.name, legal_name = excluded.legal_name, updated_at = now();

insert into public.aryp_branches (id, organization_id, code, name)
values
  ('BR-001','FR-001','DEMO-UTR-01','Cawangan Demo Utara 1'),
  ('BR-002','FR-001','DEMO-UTR-02','Cawangan Demo Utara 2'),
  ('BR-003','FR-002','DEMO-SLT-01','Cawangan Demo Selatan 1'),
  ('BR-004','FR-002','DEMO-SLT-02','Cawangan Demo Selatan 2'),
  ('BR-005','FR-003','DEMO-TMR-01','Cawangan Demo Timur 1'),
  ('BR-006','FR-003','DEMO-TMR-02','Cawangan Demo Timur 2')
on conflict (id) do update set organization_id = excluded.organization_id, code = excluded.code, name = excluded.name, updated_at = now();

-- Backfill the original six demo roles into the normalized membership model.
insert into public.aryp_user_memberships (user_id, organization_id, branch_id, role_key, is_primary, enabled)
select m.user_id,
       case when m.role in ('FRANCHISOR_SUPERVISOR','AUDITOR') then 'ORG-ARYP' else coalesce(b.organization_id, 'ORG-ARYP') end,
       case when m.role in ('FRANCHISOR_SUPERVISOR','AUDITOR') then null else b.id end,
       m.role,
       true,
       m.enabled
from public.aryp_memberships m
left join lateral unnest(m.branch_ids) as branch_value(id) on true
left join public.aryp_branches b on b.id = branch_value.id
where exists (select 1 from public.aryp_role_catalog r where r.role_key = m.role)
  and not exists (select 1 from public.aryp_user_memberships x where x.user_id = m.user_id);

comment on table public.aryp_organizations is 'Normalized company/franchisee hierarchy; assumption baseline until client confirms legal entities.';
comment on table public.aryp_user_memberships is 'Normalized many-to-many role and organization/branch scope assignments.';
