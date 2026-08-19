# ARYP — Matriks Liputan Demo AB-0.1

**Status:** DRAF PRE-CONTRACT / DATA SINTETIK  
**Maksud 100%:** semua laluan demo yang dipersetujui boleh diterangkan atau dicuba menggunakan mockup dan seed; ini bukan kelulusan production.

| Scenario runbook | Liputan semasa | Cara cuba dalam mockup | Baki untuk demo 100% |
|---|---|---|---|
| 1. Gadaian baharu | **Interaktif end-to-end** | Gadaian baharu → lengkapkan lima langkah → sahkan bayaran → dual control vault → selesai | Tiada blocker demo; formula masih provisional. |
| 2. Tebusan simulasi | **Interaktif end-to-end** | Ansuran & tebusan → tandakan dokumen → teruskan bayaran; submit kedua kekal idempotent | Tiada blocker demo; provider masih mock. |
| 3. Repeat customer / risk hold | **Interaktif end-to-end (simulasi)** | Pelanggan → muat CUS-003/CUS-005 → lihat history → semak repeat atau cuba review blacklist hold | Tambah sejarah cross-branch yang lebih luas selepas data client diterima. |
| 4. Teller / tutup hari | **Interaktif end-to-end** | Teller & tunai → ubah cash count/variance → lengkapkan checklist → tutup hari | Tiada blocker demo; posting bank masih simulasi. |
| 5. Vault / stocktake | **Interaktif end-to-end (simulasi)** | Marhun & vault → terima beg, stocktake fixture atau cuba check-out tanpa dual control | Tambah perbandingan foto/seal dan varians fizikal terperinci. |
| 6. Overdue / notifikasi / lelongan | **Interaktif end-to-end (simulasi)** | Lelongan → majukan PLG-003 ke overdue atau pilih AUC-001/AUC-002; keputusan lelong direkodkan API | Tambah timer notis yang bergerak mengikut tarikh fixture. |
| 7. Dashboard / audit | **Interaktif end-to-end (simulasi)** | Pentadbiran → lihat audit API, cuba akses BR-999; Laporan → drill-down FR-001 → BR-001 → PLG-001 | Tambah filter actor/masa dan eksport audit. |

## Indeks semasa

- Laluan interaktif penuh: **7/7**.
- Laluan interaktif terhad: **0/7**.
- Laluan paparan konsep: **0/7**.
- Liputan skrin navigasi: **11/11**.
- Data demo: **synthetic only**, `ARYP-DEMO-SEED-001`.

## Definition of Done demo 100%

1. Semua tujuh scenario boleh dimulakan, dimainkan, di-reset dan menghasilkan status yang boleh dilihat. **Status ini kini dicapai untuk demo AB-0.1.**
2. Semua action berjaya dan ditolak menghasilkan event demo dengan actor, masa, branch, sebab dan assumption ID.
3. Semua nilai, dokumen, provider dan settlement kekal `SIMULATION`/`PROVISIONAL`.
4. Semua perubahan boleh dipetakan semula kepada seed, runbook dan assumption baseline.
5. Smoke test lulus pada desktop, tablet, mobile, light/dark mode dan offline-open.
