-- Demo hardening: keep the maintenance helper private and index new identity links.
revoke execute on function public.rls_auto_enable() from public, anon, authenticated;

create index if not exists aryp_audit_events_actor_user_id_idx
  on public.aryp_audit_events(actor_user_id);

create index if not exists aryp_demo_state_maker_user_id_idx
  on public.aryp_demo_state(maker_user_id);

create index if not exists aryp_demo_state_approver_user_id_idx
  on public.aryp_demo_state(approver_user_id);
