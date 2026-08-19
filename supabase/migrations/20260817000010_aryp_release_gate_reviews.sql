-- ARYP staging extension: auditable release-gate review records.
-- A passed demo gate never grants production approval by itself.

alter table public.aryp_release_gates add column if not exists reviewer_user_id uuid references auth.users(id);
alter table public.aryp_release_gates add column if not exists review_note text;
alter table public.aryp_release_gates add column if not exists evidence_snapshot jsonb not null default '[]'::jsonb;
alter table public.aryp_release_gates add column if not exists reviewed_at timestamptz;

create index if not exists aryp_release_gates_reviewer_idx
  on public.aryp_release_gates (reviewer_user_id, reviewed_at desc);
