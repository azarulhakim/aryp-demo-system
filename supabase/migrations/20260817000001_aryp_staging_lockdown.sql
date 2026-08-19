-- Explicit deny policies complement revoked Data API grants. The Worker uses
-- the server-side service-role key only after validating Supabase Auth + membership.
create policy aryp_demo_seed_deny on public.aryp_demo_seed
  for all to anon, authenticated using (false) with check (false);

create policy aryp_demo_state_deny on public.aryp_demo_state
  for all to anon, authenticated using (false) with check (false);

create policy aryp_memberships_deny on public.aryp_memberships
  for all to anon, authenticated using (false) with check (false);

create policy aryp_audit_events_deny on public.aryp_audit_events
  for all to anon, authenticated using (false) with check (false);
