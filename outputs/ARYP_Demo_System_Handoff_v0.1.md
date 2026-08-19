# ARYP — Handoff Sistem Demo AB-0.1

**Status:** PRE-CONTRACT / SINTETIK / SIMULASI SAHAJA  
**Pakej:** `ARYP_Demo_System_v0.1.zip`

## Cara menjalankan

1. Extract ZIP pada komputer demo.
2. Buka terminal dalam folder `app`.
3. Jalankan `node server.mjs`.
4. Buka `http://localhost:4173/` menggunakan Chrome, Edge atau Safari.
5. Muka utama ialah mockup visual ARYP asal yang telah disambungkan ke API demo.
6. Gunakan `Reset demo` sebelum setiap pembentangan.
7. Apabila dibuka semula, ringkasan status pada mockup akan dimuatkan daripada state API semasa; setiap tindakan API boleh dikesan melalui `correlation_id` dalam audit.

## Aliran yang boleh dicuba

- Tukar peranan Teller/Pengurus/Francaisor.
- Muat fixture pelanggan `CUS-003` atau `CUS-005`; semak sejarah gadaian sintetik.
- Untuk `CUS-003`, tekan semakan risiko dan tunjukkan status `Disemak · REPEAT_REVIEW`.
- Untuk `CUS-005`, cuba semakan risiko dan tunjukkan `BLACKLIST_REVIEW` kekal ditahan; tiada bypass.
- Lulus atau tolak gadaian dengan maker-checker.
- Lengkapkan cash-out dan vault check-in.
- Terima beg vault, jalankan stocktake atau cuba check-out tanpa dual control.
- Lengkapkan checklist teller dan tutup hari simulasi.
- Simulasikan overdue, surplus dan shortfall lelongan.
- Buka drill-down laporan dan cuba akses tenant `BR-999`.
- Lihat 8 event audit API terkini pada halaman Pentadbiran; event DENIED turut muncul selepas refresh automatik.
- Gunakan `/system.html` untuk melihat state API dan audit event secara ringkas.

## Semakan teknikal

Dalam terminal folder `app`, jalankan:

```text
npm run check
npm test
```

Ujian meliputi role restriction, maker-checker, state transition, repeat-customer history, blacklist hold, invalid input, audit event/correlation ID, dual-control denial, tenant boundary, bridge iframe dan reset.

Liputan demo semasa: **7/7 journey interaktif end-to-end (simulasi)**. Ini bermaksud semua laluan demo boleh dimainkan dengan seed sintetik; ia tidak bermaksud 226 requirement telah diluluskan untuk production.

## Had demo

- Semua data dan jumlah ialah fixture sintetik `ARYP-DEMO-SEED-001`.
- Server menggunakan state dalam memori; restart server mengembalikan seed asal.
- Tiada database, payment provider, SMS, e-Invoice, vault device atau integrasi live.
- Jangan masukkan MyKad, telefon sebenar, akaun bank, secret, marhun sebenar atau wang sebenar.
- Formula, fi, had kuasa, tempoh, Shariah, cukai dan regulatory rule masih andaian sementara.

Selepas kontrak dan dokumen pemuktamadan client diterima, ganti seed/andaian, jalankan impact analysis terhadap 226 requirement ID, dan ulang semula security, privacy, regulatory, NFR, UAT serta sign-off sebelum pilot atau production.
