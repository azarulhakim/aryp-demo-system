# ARYP Staging Deployment Handoff v0.1

**Tarikh:** 2026-08-17  
**Status:** LIVE — synthetic staging and production-named demo endpoint  
**Production release:** blocked by approval gates

## Pautan

- Staging UI (akaun Cloudflare betul): https://aryp-staging.rsshost.workers.dev
- Default production-named demo URL (akaun Cloudflare betul): https://aryp-production.rsshost.workers.dev
- Supabase project URL: https://ywfmbygeximvrbfniify.supabase.co
- Supabase project ref: `ywfmbygeximvrbfniify`

## Apa yang sudah aktif

- Cloudflare Worker staging dengan security headers dan static mockup.
- Supabase Auth shell; API calls require bearer token.
- Supabase Edge Function `aryp-api`, deployed with JWT verification.
- Synthetic seed, shared demo state, memberships and audit tables.
- RLS enabled with explicit deny policies for direct client access.
- No real PII, money movement, marhun, live provider or production secret.
- Cloudflare account target: `1a31137d59cff2a0b541cdcd28600bc8` (`Azarulhakim20@gmail.com` account).
- Formula/maker-checker demo: formula versions are configurable and versioned; the former `FINANCING_DEFAULT / ASSUMED-CALC-0.1` is retained as `RETIRED` and `ASSUMED-UPAH-SIMPAN-0.2` is the active synthetic version. `quote_financing`, `submit_pledge`, approval and rejection are enforced server-side. A maker cannot approve the same pledge. All values remain simulation-only and `ASSUMED—NOT APPROVED`.
- Data lifecycle demo: active policy `DATA_LIFECYCLE_DEFAULT / ASSUMED-RETENTION-0.1` keeps retention duration unset (`PENDING_CLIENT`), disables deletion in demo, and supports audited legal holds. An active hold blocks redemption, cash-out and auction simulation; only authorized manager/franchisor roles can release it.
- Privacy demo: active policy `PRIVACY_DEFAULT / ASSUMED-PRIVACY-0.1` exposes a draft notice, unset legal basis/consent requirement, configurable DSR hooks and disabled erasure. Consent capture/withdrawal and ACCESS, RECTIFICATION, ERASURE or RESTRICTION requests are simulated and audited.
- Regulatory demo: seven neutral versioned rule placeholders are available to privileged roles through `/api/regulatory-rules`; all remain `CLIENT_TO_CONFIRM` / `PENDING_CLIENT` with evidence and conflict-handling metadata. The system does not claim statutory applicability.
- NFR demo: six versioned target registries are available through `/api/nfr-targets`; latency, volume, uptime, RTO/RPO and log-retention numbers remain unset. WCAG 2.2 AA is a working target only. `/api/actions` supports audited simulated NFR observations with `PENDING_CLIENT` acceptance.
- Hosting/region assumption: `/api/deployment-info` records Cloudflare Workers + Supabase as the current synthetic stack. Region, residency, cross-border, subprocessors and production approval are explicitly `PENDING_CLIENT` / unverified.
- Autonomous assumption register: `outputs/ARYP_Autonomous_Assumption_Register_v0.1.md` records reversible defaults for all 226 requirements. High-risk items remain labelled `ASSUMED—NOT APPROVED` and cannot authorize production use.
- Release gates: `/api/release-gates` exposes G1–G12 with required evidence/sign-offs. Every gate currently starts as `PENDING`; a production transition cannot be inferred from demo activity.
- Governance console: after login, use `Polisi & gates` in the top bar or open `/governance.html` to review active policies, regulatory/NFR registries and G1–G12 status. Document and heir rows include simulated review buttons; API role/evidence checks still apply.
- Organization scope: the normalized assumption hierarchy is `ARYP franchisor → nine franchisees → 27 branches → user memberships/roles`. Franchisor Supervisor and Auditor see the network; franchisee assignments inherit their three branches; branch assignments see only their assigned branch. The Governance Console now displays the visible organization tree and scope.
- Client user manual: `outputs/ARYP_Manual_Pengguna_Staging_v0.1.docx`, `outputs/ARYP_Manual_Pengguna_Staging_v0.1.pdf` and the shareable bundle `outputs/ARYP_Manual_Pengguna_Staging_v0.1.zip` document the complete role-by-role test flows with staging screenshots, expected results, reset procedure, troubleshooting and synthetic-data boundaries.
- Registration redirect fix: the staging login shell now sends an explicit `email_redirect_to` equal to the current Worker origin during signup. New confirmation links return to staging; older links already issued with `localhost` must be replaced by requesting a fresh confirmation email.
- Gate review controls: executive, franchisor supervisor and auditor can select `IN_REVIEW`, `PASSED`, `BLOCKED` or `WAIVED`, then record a note and evidence snapshot. `PASSED`/`WAIVED` are rejected without both fields. This is an auditable simulation workflow only; the API always reports `production_release_allowed=false` until real client gates are approved.
- Notification simulation: `/api/notifications` returns branch-scoped synthetic delivery records with masked destinations, status, template version and evidence. `queue_notification` and `retry_notification` validate event/channel/idempotency inputs and use `MOCK_PROVIDER`; raw e-mail addresses are rejected and no SMS/e-mail provider is called. Governance Console includes the notification evidence table.
- Reporting simulation: `/api/reports/summary` returns role-scoped synthetic operations metrics with `SIMULATED_NOW` freshness and `Asia/Kuala_Lumpur` timezone. `export_report` validates CSV/PDF/XLSX requests, applies masked-by-default policy, audits the request and keeps download disabled in demo. Governance Console includes the report summary and export policy.
- Case/exception simulation: `/api/cases` shows synthetic customer-identity, privacy-DSR and integration-failure cases. `open_case` and `resolve_case` are role-checked, validate category/priority/evidence and write audit events; SLA remains `PENDING_CLIENT`. Governance Console includes the case/hold/exception table.
- Valuation/calculation simulation: migration `20260817000011_aryp_valuation_fixtures.sql` adds synthetic 916/999 gold prices and branch-scoped marhun items. `/api/valuation/prices` and `calculate_valuation` expose fixture-only valuation, formula version, 0.01 rounding and calculation snapshot IDs; manual overrides are labelled simulated and every calculation is audited. No live price source is called.
- Ledger/cash/custody simulation: migration `20260817000012_aryp_ledger_cash_fixtures.sql` adds synthetic payments, drawer, ledger, vault, auction and heir fixtures. `/api/finance/summary` exposes masked role-scoped totals; `cash_count` requires a reason for non-zero variance and `bank_in_simulated` requires amount plus slip reference. No bank, ledger or custody provider is called.
- Documents/heirs simulation: migration `20260817000013_aryp_documents_heirs_fixtures.sql` adds versioned synthetic SAG, privacy-consent and auction-notice document records plus branch-scoped heir-claim records. `/api/documents` and `/api/heirs` expose role-scoped registers; `document_review` requires evidence and `heir_claim_review` requires a document reference. Governance Console renders both registers. Signature, document approval and heir decisions are simulated only and carry synthetic classification/watermark.
- Authorization hardening: `aryp-api` v17 limits `reset_demo` to supervisory roles and checks branch visibility for document/heir review actions. Teller reset and cross-branch manager review are rejected with audited tenant/role errors; network auditor review remains available.
- SAG preview: `/sag.html?reference=ARYP-BNG-260815-0042&mode=demo` is available on both endpoints. It is a print-ready A4-landscape draft modelled on the supplied client example, using the extracted AR-Rahnu YaPEIM logo, branch/header metadata, personal-information panel, marhun table, financing summary, lafaz sections and signature/cop spaces. It carries `SAG v3.2`, a synthetic-only watermark, checksum and a `Cetak / Simpan PDF` action. The Gadaian baharu flow's `Cetak label & SAG` control now uses direct top-level navigation from the nested wizard, so it reliably opens this preview after the signature checkbox is accepted. It is still a simulated draft, not a client-approved legal/Shariah form.
- Formula v0.2 is active in the synthetic environments: `ASSUMED-UPAH-SIMPAN-0.2` uses `Nilai Marhun × 0.95% × 12 × hari ÷ 365` for Upah Simpan, with daily/final-cent rounding, 15-day minimum and 120-day maximum. The 70% financing margin remains configurable and uses the RM0.05 floor. The retired formula remains in the version registry for audit. The API now returns the full formula snapshot and charge breakdown; the mockup and Governance Console show the same values. This formula is provisional and must not be presented as client-approved.
- Role-scope visibility is now active in both synthetic environments: `aryp-api` v21 filters dashboard counts and API registers by authenticated branch/organization/network scope. The fixture migration `20260819000015_aryp_scope_fixtures.sql` adds records to BR-004, BR-005 and BR-006 so role differences are visible. The hierarchy is ARYP franchisor → three franchisees → six branches; Branch Manager sees one branch, Executive sees the two branches of FR-001, and Master Franchisor/Auditor see all four organizations and six branches. The login shell now provides a clearly labelled `Master francaisor` demo button, and the mockup's role context plus `Master franchisor · struktur rangkaian` panel are API-hydrated. This remains a synthetic demonstration, not an approved production tenancy model.

## Cara akses operator

1. Buka URL staging dan pilih daftar akaun.
2. Sahkan e-mel menggunakan mekanisme Auth yang dikonfigurasi untuk project staging.
3. Beri e-mel akaun kepada project operator (jangan beri password).
4. Operator cari UUID user di `auth.users` dan tambah membership:

```sql
insert into public.aryp_memberships (user_id, role, branch_ids)
values ('AUTH_USER_UUID', 'BRANCH_MANAGER', array['BR-001']::text[]);
```

5. Log masuk semula dan uji flow synthetic: pelanggan, gadaian baharu, kelulusan, tunai simulasi, vault, lelongan, laporan dan audit.

## Demo skop penuh (kemas kini 2026-08-19)

- Dataset kini merangkumi 9 franchisee (`FR-001` hingga `FR-009`) dan 27 cawangan aktif (`BR-001` hingga `BR-027`), dengan data sintetik 12 bulan.
- Login page menyediakan pemilih skop: `BRANCH_MANAGER`, `TELLER`, `VAULT_CUSTODIAN` untuk setiap 27 cawangan, serta `FRANCHISEE_ADMIN` untuk setiap 9 franchisee.
- Akaun demo berjumlah 96: 81 akaun cawangan (27 × 3), 9 akaun franchisee, dan 6 akaun rangkaian/eksekutif/auditor sedia ada.
- Semua akaun baharu menggunakan e-mel sintetik `@aryp-demo.my` dan kata laluan bersama `ARYP-Demo-2026!`. Jangan gunakan akaun ini untuk data sebenar.
- Skop disahkan di server: contoh Manager `BR-027` melihat satu cawangan; Franchisee Admin `FR-009` melihat `BR-025`–`BR-027`; rekod cross-tenant ditolak dengan HTTP 403.
- Migration sumber akaun: `supabase/migrations/20260819000020_aryp_branch_demo_logins.sql`.
- Deployment semasa yang disahkan: staging Worker version 70 dan production-named Worker version 63, kedua-duanya melayani login, mockup, governance dan SAG dengan HTTP 200.

## Akaun demo synthetic

Login page menyediakan butang pantas untuk role rangkaian berikut, serta pemilih skop penuh di bawahnya. Semua akaun menggunakan kata laluan `ARYP-Demo-2026!` dan hanya untuk testing synthetic:

| Role | E-mel |
|---|---|
| BRANCH_MANAGER | `demo.manager@aryp-demo.my` |
| TELLER | `demo.teller@aryp-demo.my` |
| VAULT_CUSTODIAN | `demo.vault@aryp-demo.my` |
| FRANCHISOR_SUPERVISOR | `demo.franchisor@aryp-demo.my` |
| EXECUTIVE | `demo.executive@aryp-demo.my` |
| AUDITOR | `demo.auditor@aryp-demo.my` |

Format akaun skop penuh:

| Skop | Format e-mel |
|---|---|
| Pengurus cawangan | `demo.manager.brNNN@aryp-demo.my` |
| Teller | `demo.teller.brNNN@aryp-demo.my` |
| Vault custodian | `demo.vault.brNNN@aryp-demo.my` |
| Admin franchisee | `demo.franchisee.frNNN@aryp-demo.my` |

Untuk menukar role, log keluar dan pilih butang role yang lain. Akaun ini tidak boleh digunakan untuk production atau data sebenar.

## Smoke evidence

- Worker `/api/health`: HTTP 200, `SYNTHETIC_ONLY`.
- Worker `/api/session` tanpa token: HTTP 401.
- Edge Function tanpa token: HTTP 401.
- Static shell: HTTP 200.
- SAG preview: staging and production `/sag.html` return HTTP 200 with `text/html`, and `/mockup.html` contains the launcher wiring.
- Local application checks and smoke tests remain passing.
- Latest role smoke: all six demo roles return HTTP 200 from `/api/session`, with 12 release gates, 7 regulatory rules and 6 NFR policies. Documents/heirs endpoints return HTTP 200; evidence validation rejects incomplete document review; manager and teller review actions produce audit events.
- Latest scope smoke (2026-08-19): authenticated sessions now return differentiated visibility: Branch Manager `3/3/1` (customers/pledges/branches), Executive `4/4/2`, and Master Francaisor/Auditor `8/7/6`. Static assets on both correct-account Workers were revalidated: login 17,017 bytes, mockup 228,203 bytes, SAG 11,897 bytes, Governance 19,149 bytes, logo 45,343 bytes. Both `/api/health` endpoints return `SYNTHETIC_ONLY`.
- Latest Master/button smoke (2026-08-19): fixed the nested sandbox role handoff that previously left Master francaisor on the Teller/Bangi 01 context. Master now shows `YAPEIM Smart Venture` and `Pemantauan francaisor`; main navigation buttons for Ringkasan, Pelanggan, Gadaian baharu, Laporan and Pentadbiran each switch to the correct page, and `Semak risk API` returns a successful simulated API response. The fix is deployed to both correct-account staging and production Workers. Hard refresh or log out/in once if an older iframe is cached.
- Latest expanded-data smoke (2026-08-19): staging now contains 6 franchisees and 18 active branches (3 per franchisee), with 188 synthetic customers, 157 synthetic pledges, 216 branch-month records and 12 monthly periods (`2025-09`–`2026-08`). Master UI shows all 18 branches and 7 organizations; the authenticated API returns role-scoped counts of Branch Manager `13/12/1`, Executive `34/30/3`, and Master Franchisor `188/157/18`. Monthly finance, vault and auction fixtures are included. The Edge Function is version 23; all values remain simulation-only.
- Latest franchisee expansion smoke (2026-08-19): added FR-007–FR-009 and BR-019–BR-027. Staging now contains 9 franchisees, 27 active branches, 278 synthetic customers, 232 synthetic pledges and 324 branch-month records covering `2025-09`–`2026-08`. Master UI displays 10 organizations (9 franchisees + ARYP franchisor) and 27 branches; the report panel shows 27 branches reporting for every month. Organization and branch role boundaries remain enforced server-side.
- Latest role-scope parity smoke (2026-08-19): the previous “same view” concern was traced to static UI labels and shared demo fixtures, not a network data leak. API v25 and the deployed mockup now hydrate scope, counts, cash, notifications and cases from the authenticated session. Master Franchisor: NETWORK, 10 organizations, 27 branches, 278 customers, 232 pledges. Executive/franchisee: ASSIGNED_SCOPE, FR-001, 3 branches, 34 customers, 30 pledges. Branch Manager: BR-001, 1 branch, 13 customers, 12 pledges. Teller: BR-001, same underlying branch counts by design, but teller-only navigation and action permissions. Browser smoke confirmed role-specific headings and menus; server smoke confirmed 12 monthly periods (`2025-09`–`2026-08`) and branch IDs never escape each role’s scope. `/cases` direct endpoint was fixed and redeployed as Edge Function v25. Both `https://aryp-staging.rsshost.workers.dev` and `https://aryp-production.rsshost.workers.dev` return HTTP 200 health with `SYNTHETIC_ONLY`.
- Latest branch-account smoke (2026-08-19): the scope selector and migration now cover all 27 branches and all 9 franchisees. Production API login was verified for `BR-027` Manager (1 branch, 10 customers, 8 pledges) and `FR-009` Franchisee Admin (3 branches, 30 customers, 24 pledges). Cross-tenant action checks continue to return HTTP 403.
- Latest customer-identity smoke (2026-08-19): removed the hard-coded `Siti Nur Aina` profile from the shared mockup/SAG template. `/api/session` now returns a masked synthetic customer profile selected from the authenticated branch scope, with branch-specific synthetic aliases; BR-002 resolves to Hafizah binti Ismail / `CUS-004` and BR-027 resolves to Nur Syazana binti Azmi / `CUS-197`. The dashboard, customer panel, pawn flow and SAG preview use that scoped profile/branch instead of presenting one person in every cawangan.

## Baki sebelum production

Requirement decisions, approved regulatory/privacy/security rules, real tenancy model, NFR/SLA, backup/restore, monitoring/incident runbook, UAT/pilot, business sign-off, production domain and production secret ownership are still required. Staging assumptions must not be represented as approved policy.
