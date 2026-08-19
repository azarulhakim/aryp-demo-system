# ARYP Demo System AB-0.1

Ini ialah aplikasi demo full-stack kecil untuk ARYP, bukan sekadar mockup HTML. Ia mempunyai server HTTP, API JSON, data seed sintetik, state transitions, role checks, maker-checker, tenant denial dan audit event.

## Jalankan

```text
cd app
node server.mjs
```

Buka `http://localhost:4173` untuk UI utama dengan visual mockup ARYP asal yang telah disambungkan ke API demo (sejarah pelanggan, semakan repeat/risk hold, kelulusan, payout, vault acceptance/check-in, completion, redemption, stocktake, tutup hari, lelong, audit explorer, audit boundary dan reset). UI memuatkan semula ringkasan state daripada API apabila dibuka. Setiap event audit membawa `correlation_id`. UI API-backed scaffold yang lebih ringkas boleh dicuba di `http://localhost:4173/system.html`; kedua-duanya menggunakan endpoint API yang sama.

## API demo

- `GET /api/health`
- `GET /api/session`
- `GET /api/customers`
- `GET /api/pledges`
- `GET /api/audit`
- `POST /api/actions`
- `POST /api/role`
- `POST /api/reset`

Semakan pantas selepas server berjalan:

```text
npm test
```

Smoke test ini meliputi maker-checker, role vault, repeat customer, blacklist hold, stocktake, dual-control denial, auction, drill-down, tenant boundary dan reset.

Semua wang, provider dan keputusan adalah `SIMULATION`. Data production, PII, secrets dan integrasi live belum dibenarkan. Seed boleh diganti selepas client memberikan keputusan rasmi.
