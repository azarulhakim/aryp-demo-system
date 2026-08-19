-- ARYP branch and franchisee demo accounts.
-- DEMO-ONLY: all accounts use the shared synthetic password and must not be
-- reused for production or real customer data. The normalized memberships are
-- the authorization source; user metadata is display-only.

alter table public.aryp_memberships drop constraint if exists aryp_memberships_role_check;
alter table public.aryp_memberships add constraint aryp_memberships_role_check
  check (role in ('FRANCHISOR_SUPERVISOR','FRANCHISEE_ADMIN','BRANCH_MANAGER','EXECUTIVE','TELLER','VAULT_CUSTODIAN','AUDITOR'));

do $$
declare
  branch_row record;
  org_row record;
  role_row record;
  account_id uuid;
  account_email text;
begin
  -- One manager, teller and vault custodian for every synthetic branch.
  for branch_row in
    select id, organization_id, name
    from public.aryp_branches
    where status = 'ACTIVE'
    order by id
  loop
    for role_row in
      select * from (values
        ('BRANCH_MANAGER'::text, 'manager'::text),
        ('TELLER'::text, 'teller'::text),
        ('VAULT_CUSTODIAN'::text, 'vault'::text)
      ) as roles(role_key, slug)
    loop
      account_email := format('demo.%s.%s@aryp-demo.my', role_row.slug, lower(replace(branch_row.id, '-', '')));
      select u.id into account_id from auth.users u where lower(u.email) = account_email limit 1;

      if account_id is null then
        account_id := gen_random_uuid();
        insert into auth.users (
          instance_id, id, aud, role, email, encrypted_password,
          email_confirmed_at, raw_app_meta_data, raw_user_meta_data,
          confirmation_token, recovery_token, email_change_token_new, email_change,
          email_change_token_current, reauthentication_token, phone_change, phone_change_token,
          email_change_confirm_status, is_super_admin, created_at, updated_at, is_sso_user, is_anonymous
        ) values (
          '00000000-0000-0000-0000-000000000000', account_id, 'authenticated', 'authenticated',
          account_email, crypt('ARYP-Demo-2026!', gen_salt('bf')),
          now(),
          '{"provider":"email","providers":["email"]}'::jsonb,
          jsonb_build_object('role', role_row.role_key, 'branch_id', branch_row.id, 'aryp_demo', true, 'email_verified', true),
          '', '', '', '', '', '', '', '', 0, null, now(), now(), false, false
        );
        insert into auth.identities (provider_id, user_id, identity_data, provider, created_at, updated_at)
        values (
          account_id::text, account_id,
          jsonb_build_object('sub', account_id::text, 'email', account_email, 'email_verified', false, 'phone_verified', false),
          'email', now(), now()
        );
      else
        update auth.users
        set encrypted_password = crypt('ARYP-Demo-2026!', gen_salt('bf')),
            email_confirmed_at = coalesce(email_confirmed_at, now()),
            raw_user_meta_data = jsonb_build_object('role', role_row.role_key, 'branch_id', branch_row.id, 'aryp_demo', true, 'email_verified', true),
            updated_at = now()
        where id = account_id;
      end if;

      insert into public.aryp_memberships (user_id, role, branch_ids, enabled)
      values (account_id, role_row.role_key, array[branch_row.id]::text[], true)
      on conflict (user_id) do update
        set role = excluded.role, branch_ids = excluded.branch_ids, enabled = true;

      if exists (
        select 1 from public.aryp_user_memberships m
        where m.user_id = account_id and m.organization_id = branch_row.organization_id
          and m.branch_id = branch_row.id and m.role_key = role_row.role_key
      ) then
        update public.aryp_user_memberships
        set is_primary = true, enabled = true, updated_at = now()
        where user_id = account_id and organization_id = branch_row.organization_id
          and branch_id = branch_row.id and role_key = role_row.role_key;
      else
        insert into public.aryp_user_memberships (user_id, organization_id, branch_id, role_key, is_primary, enabled, metadata)
        values (account_id, branch_row.organization_id, branch_row.id, role_row.role_key, true, true,
          jsonb_build_object('demo_label', branch_row.name, 'synthetic_only', true));
      end if;
    end loop;
  end loop;

  -- One franchisee administrator account per synthetic franchisee.
  for org_row in
    select id, name
    from public.aryp_organizations
    where organization_type = 'FRANCHISEE' and status = 'ACTIVE'
    order by id
  loop
    account_email := format('demo.franchisee.%s@aryp-demo.my', lower(replace(org_row.id, '-', '')));
    select u.id into account_id from auth.users u where lower(u.email) = account_email limit 1;

    if account_id is null then
      account_id := gen_random_uuid();
      insert into auth.users (
        instance_id, id, aud, role, email, encrypted_password,
        email_confirmed_at, raw_app_meta_data, raw_user_meta_data,
        confirmation_token, recovery_token, email_change_token_new, email_change,
        email_change_token_current, reauthentication_token, phone_change, phone_change_token,
        email_change_confirm_status, is_super_admin, created_at, updated_at, is_sso_user, is_anonymous
      ) values (
        '00000000-0000-0000-0000-000000000000', account_id, 'authenticated', 'authenticated',
        account_email, crypt('ARYP-Demo-2026!', gen_salt('bf')),
        now(),
        '{"provider":"email","providers":["email"]}'::jsonb,
        jsonb_build_object('role', 'FRANCHISEE_ADMIN', 'organization_id', org_row.id, 'aryp_demo', true, 'email_verified', true),
        '', '', '', '', '', '', '', '', 0, null, now(), now(), false, false
      );
      insert into auth.identities (provider_id, user_id, identity_data, provider, created_at, updated_at)
      values (
        account_id::text, account_id,
        jsonb_build_object('sub', account_id::text, 'email', account_email, 'email_verified', false, 'phone_verified', false),
        'email', now(), now()
      );
    else
      update auth.users
      set encrypted_password = crypt('ARYP-Demo-2026!', gen_salt('bf')),
          email_confirmed_at = coalesce(email_confirmed_at, now()),
          raw_user_meta_data = jsonb_build_object('role', 'FRANCHISEE_ADMIN', 'organization_id', org_row.id, 'aryp_demo', true, 'email_verified', true),
          updated_at = now()
      where id = account_id;
    end if;

    insert into public.aryp_memberships (user_id, role, branch_ids, enabled)
    values (
      account_id, 'FRANCHISEE_ADMIN',
      array(select b.id from public.aryp_branches b where b.organization_id = org_row.id and b.status = 'ACTIVE' order by b.id),
      true
    )
    on conflict (user_id) do update
      set role = excluded.role, branch_ids = excluded.branch_ids, enabled = true;

    if exists (
      select 1 from public.aryp_user_memberships m
      where m.user_id = account_id and m.organization_id = org_row.id
        and m.branch_id is null and m.role_key = 'FRANCHISEE_ADMIN'
    ) then
      update public.aryp_user_memberships
      set is_primary = true, enabled = true, updated_at = now()
      where user_id = account_id and organization_id = org_row.id
        and branch_id is null and role_key = 'FRANCHISEE_ADMIN';
    else
      insert into public.aryp_user_memberships (user_id, organization_id, branch_id, role_key, is_primary, enabled, metadata)
      values (account_id, org_row.id, null, 'FRANCHISEE_ADMIN', true, true,
        jsonb_build_object('demo_label', org_row.name, 'synthetic_only', true));
    end if;
  end loop;
end;
$$;

comment on table public.aryp_user_memberships is 'Normalized many-to-many role and organization/branch scope assignments. Demo fixtures include branch-level accounts for every active synthetic branch.';
