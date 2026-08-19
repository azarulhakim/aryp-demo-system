# ARYP — Production Deployment Gate v0.1

**Tarikh:** 2026-08-17  
**Keputusan:** **RELEASE BLOCKED — endpoint production-named live untuk synthetic demonstration sahaja**  
**Skop semakan:** aplikasi demo `app/`, API, UI, persistence, security dan hosting.

## Status semasa

- Demo/prototype: **100% journey playable (7/7)**.
- Production readiness: **0%**.
- Data: synthetic/demo sahaja.
- Hosting target untuk **staging**: Cloudflare Workers + Supabase (projek `aryp-staging`).
- Staging Worker pada akaun Cloudflare betul telah live di `https://aryp-staging.rsshost.workers.dev`.
- Production-named Worker pada akaun Cloudflare betul telah live di `https://aryp-production.rsshost.workers.dev`, tetapi masih menggunakan dataset synthetic dan Supabase staging project.
- Supabase migration foundation + lockdown telah diterapkan melalui connector; Edge Function `aryp-api` aktif dengan JWT verification.
- **Production readiness kekal 0%** kerana production domain, secrets, UAT, regulatory/security sign-off dan data sebenar belum diluluskan.

## Blocker P0

1. API tiada authentication sebenar; `x-demo-role` boleh dipalsukan oleh caller.
2. State transaksi dan audit hanya berada dalam memory; restart atau multi-instance akan kehilangan/mencampur data.
3. Endpoint approval, cash-out, vault, auction, reset dan audit boleh dicapai tanpa session, membership atau tenant authorization.
4. Tiada tenant isolation sebenar; branch audit di-hardcode kepada `BR-001`.
5. Tiada database transaction, idempotency, immutable audit store atau maker-checker identity yang boleh dipercayai.
6. Tiada TLS/reverse proxy, rate limit, CSRF/origin control, security headers atau production observability.

## Blocker P1

- Request body dan input domain tiada size/schema validation.
- UI diagnostic menggunakan `innerHTML` dengan data API yang akan menjadi tidak selamat apabila data luar masuk.
- Third-party scripts/CDN tidak dipin dan CSP masih membenarkan execution yang terlalu luas.
- CSP/bridge masih mengandungi localhost/`targetOrigin='*'` yang perlu ditetapkan semula untuk domain deployment.
- Health endpoint hanya menyemak seed memory, bukan database dan dependency readiness.

## Laluan wajib sebelum go-live

1. Client sahkan requirement, scope release, formula, Shariah, regulatory perimeter, RBAC/SoD, privacy, NFR dan UAT.
2. Pilih hosting dan region secara rasmi (contoh: Node managed host atau Cloudflare Workers + database).
3. Sediakan authentication/JWT, server-side authorization, membership dan tenant/RLS.
4. Ganti memory state dengan database migrations, transaction boundary, backup/restore dan durable append-only audit.
5. Tambah validation, body limits, CSRF/origin control, rate limits, TLS, security headers, safe DOM rendering dan dependency pinning.
6. Sediakan staging → UAT → pilot dengan monitoring, alerting, rollback dan incident runbook.
7. Luluskan security, privacy, regulatory, NFR, QA/UAT dan business sign-off sebelum production cutover.

## Perkara yang tidak dilakukan

- Tiada **production release** dibuat. Endpoint production-named yang dideploy hanyalah synthetic demonstration; ia bukan kelulusan go-live.
- Tiada production secret, PII, wang sebenar atau live provider digunakan.
- Tiada perubahan requirement atau andaian demo dianggap sebagai kelulusan production.

## Bukti semakan

- `npm run check` — lulus.
- `npm test` — lulus; 21 audit events disahkan dalam smoke test.
- Local health — lulus dengan status `SYNTHETIC_ONLY`.
- Security gate — **BLOCKED (P0)**.
- Infrastructure gate — **BLOCKED (tiada hosting/persistence/auth production)**.

Deployment boleh dimulakan semula selepas target hosting, domain, database/auth owner dan keputusan production rasmi tersedia.

## Staging foundation yang telah disediakan

- `platform/worker/` — Cloudflare Worker + authenticated staging shell + static mockup.
- `supabase/migrations/20260817000000_aryp_staging.sql` — synthetic seed, shared state, memberships, RLS dan audit table.
- `supabase/migrations/20260817000001_aryp_staging_lockdown.sql` — explicit deny policies untuk client roles.
- `supabase/functions/aryp-api/index.ts` — server-side API dengan JWT + membership check dan service-role boundary.
- Wrangler dry-run lulus; local Worker health lulus dengan `SYNTHETIC_ONLY`.
- Remote migration telah diterapkan melalui Supabase connector; CLI Management API masih memulangkan `403` untuk akaun lokal, tetapi ini tidak menghalang deployment staging connector.
- Smoke test remote: `/api/health` = 200, root shell = 200, API tanpa token = 401, Edge Function tanpa token = 401.
- Smoke test production-named: `/api/health` = 200, root shell = 200, API tanpa token = 401.
- Langkah staging yang masih diperlukan: daftar satu Auth user, masukkan UUID user ke `public.aryp_memberships`, kemudian jalankan authenticated smoke/UAT.

## Keputusan staging

Staging dan endpoint production-named boleh dikongsi untuk demonstrasi synthetic selepas operator mempunyai membership. Jangan masukkan PII, wang sebenar, marhun sebenar, production secret atau live provider. Endpoint production-named belum boleh dianggap production release sehingga semua gate dan sign-off diluluskan.

## Account correction

The two accidental Workers on the wrong Cloudflare account (`aryp-staging` and `aryp-production`) were deleted after explicit user instruction. The correct-account endpoints on `rsshost.workers.dev` remain active.
