# ARYP Supabase staging setup

Project ref: `ywfmbygeximvrbfniify`  
Environment: staging / synthetic only

The migration creates RLS-protected tables for the synthetic seed, shared demo state, memberships and append-only audit events. The Worker uses the service-role key server-side only after it validates the caller's Supabase Auth token and membership. Never put the service-role key in browser code.

After an Auth user is created, add a staging membership from SQL Editor (replace the UUID):

```sql
insert into public.aryp_memberships (user_id, role, branch_ids)
values ('00000000-0000-0000-0000-000000000000', 'BRANCH_MANAGER', array['BR-001']);
```

Allowed staging roles: `FRANCHISOR_SUPERVISOR`, `BRANCH_MANAGER`, `EXECUTIVE`, `TELLER`, `VAULT_CUSTODIAN`, `AUDITOR`.

The migration is safe to re-run only after reviewing the intended seed reset. It must be applied to the dedicated ARYP staging project, never to an unrelated project.
