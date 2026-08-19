# ARYP Cloudflare Worker — Staging

This is the authenticated staging boundary for the ARYP synthetic demo. It is separate from the local `app/` demo and does not enable real money movement, official calculations, live providers, or production data.

## Configure

1. Apply the migration in `supabase/migrations/` to the ARYP staging Supabase project.
2. The Supabase Edge Function `aryp-api` owns the service-role boundary; the service-role key is never placed in Cloudflare or browser code.
3. Set the Supabase publishable key as the `SUPABASE_PUBLISHABLE_KEY` Worker variable for staging.
4. Create staging Auth users and add their UUIDs to `public.aryp_memberships` using the role/branch template in `supabase/README.md`.
5. Validate without publishing:

```text
npm install
npm run check
npm run dev
```

6. Deploy only the staging environment:

```text
npm run deploy:staging
```

## Current staging deployment

The deployed synthetic staging URL on the correct Cloudflare account is:

`https://aryp-staging.rsshost.workers.dev`

Open the URL, create a staging Auth account, then add that account's UUID to `public.aryp_memberships` before using the mockup. The account email may be shared with the project operator for onboarding; never share the password.

The login page contains six quick synthetic demo accounts plus a scope selector. The selector provisions and exposes one `BRANCH_MANAGER`, `TELLER` and `VAULT_CUSTODIAN` account for each of the twenty-seven branches, plus one `FRANCHISEE_ADMIN` account for each of the nine franchisees. Their shared demo password is `ARYP-Demo-2026!`; choose a role and branch/franchisee from the selector, then log out before switching role. These accounts are synthetic-only and must never be reused for production.

The organization model is normalized as `Franchisor → Franchisee → Branch → User membership → Role`. The staging hierarchy seeds one ARYP network, nine franchisee organizations (`FR-001` to `FR-009`) and twenty-seven branches (`BR-001` to `BR-027`). A user can have multiple active assignments in `aryp_user_memberships`; network roles see all branches, organization assignments inherit their organization's branches, and branch assignments are limited to the assigned branch. The Governance Console displays the visible organization tree and access scope.

The role-scoped fixture migrations add synthetic customers, pledges and marhun records across all twenty-seven branches, plus twelve monthly periods from September 2025 through August 2026. Current smoke counts are Branch Manager `13/12` in 1 branch, Executive `34/30` across FR-001's 3 branches, and Master Francaisor/Auditor `278/232` across all 27 branches (customers/pledges). Counts and monthly history are calculated server-side from the authenticated membership, not from the browser's role selector.

Customer identity in the dashboard, customer panel, pledge wizard and SAG preview is also scope-aware. The API resolves a masked synthetic customer from the authenticated branch before the UI renders it, so one named customer is not reused across every cawangan.

New account registration sends `email_redirect_to` explicitly to the current Worker origin, so confirmation links from the staging page return to `https://aryp-staging.rsshost.workers.dev/` instead of a local development URL. If an older confirmation email still contains `localhost`, request a fresh confirmation email after refreshing the staging page.

Example membership insert (run only by an authorised project operator through Supabase SQL):

```sql
insert into public.aryp_memberships (user_id, role, branch_ids)
values ('AUTH_USER_UUID', 'BRANCH_MANAGER', array['BR-001']::text[]);
```

The client UI remains synthetic-only. The Worker health endpoint is public for monitoring; all other API calls require a Supabase access token and a membership row.

The production-named synthetic demo endpoint is available at `https://aryp-production.rsshost.workers.dev`. It still points to the dedicated synthetic Supabase project and is not a production release. Real production secrets, domain routes, PII and money movement remain disabled until the client gates and UAT are approved.

After login, use **Polisi & gates** in the top bar or open `/governance.html` to review versioned policies, regulatory/NFR registries and G1–G12 release status. All gates begin as `PENDING`. Executive, franchisor supervisor and auditor roles can record a review status, note and evidence snapshot; `PASSED`/`WAIVED` remain simulation-only and never unlock production.

The active synthetic formula is `ASSUMED-UPAH-SIMPAN-0.2`: `Nilai Marhun × 0.95% sebulan × 12 × hari ÷ 365`. It returns daily, minimum-15-day and requested-period Upah Simpan values with final-cent rounding. Financing remains a configurable 70% of Net Market Value with an RM0.05 floor. The previous formula is retained as `RETIRED` for audit; neither formula is an approved legal/Shariah policy.

The pledge wizard's **Cetak label & SAG** action opens `/sag.html`, a print-ready A4-landscape draft modelled on the supplied customer template. It uses the AR-Rahnu YaPEIM logo asset, `SAG v3.2`, branch/personal-information panels, marhun table, financing summary, lafaz sections and maker-checker/cawangan signature spaces, plus a visible `DEMO · SYNTHETIC ONLY` watermark. Use **Cetak / Simpan PDF** for client demonstrations only; the form is not a legally or Shariah-approved production document.
