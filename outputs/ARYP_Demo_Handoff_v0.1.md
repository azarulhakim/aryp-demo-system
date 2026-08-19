# ARYP — Handoff Demo untuk Client

**Versi:** AB-0.1  
**Status:** PRE-CONTRACT / SINTETIK / SIMULASI SAHAJA

## Cara berkongsi

1. Hantar fail `Pakej_Mockup_Ar_Rahnu_YAPEIM_Premier.zip`.
2. Penerima extract ZIP.
3. Buka `Mockup_Interaktif_Ar_Rahnu_YAPEIM_Premier.html` dengan Chrome, Edge atau Safari.
4. Tiada login, database, server atau internet diperlukan untuk mencuba laluan demo asas.
5. Jika state berubah, tekan **Reset demo** di bahagian atas atau buka semula fail HTML.

## Urutan demo disyorkan (15–20 minit)

1. **Dashboard:** tukar peranan Teller → Pengurus → Francaisor.
2. **Gadaian baharu:** lengkapkan langkah 1–5, sahkan cash-out dan dual-control vault.
3. **Tebusan:** sahkan dokumen dan post bayaran mock; tekan submit semula untuk lihat idempotency.
4. **Risk hold:** Pelanggan → muat `CUS-003` dan `CUS-005`.
5. **Vault:** jalankan stocktake; cuba check-out tanpa dual control.
6. **Lelongan:** majukan `PLG-003` ke overdue; lihat `AUC-001` surplus dan `AUC-002` shortfall.
7. **Laporan & audit:** drill-down `FR-001 → BR-001 → PLG-001`; cuba akses `BR-999`.

## Peraturan penggunaan

- Semua nama, ID, jumlah wang, harga emas, status provider dan dokumen ialah fixture sintetik.
- Label `PROVISIONAL`, `SIMULATION` dan `DEMO—NOT PRODUCTION` mesti kekal semasa pembentangan.
- Jangan masukkan MyKad, telefon, akaun bank, rahsia, wang sebenar atau data pelanggan ke dalam mockup.
- Jangan anggap formula, kuasa kelulusan, tempoh, fi, Shariah, cukai atau peraturan dalam demo sebagai polisi yang diluluskan.

## Selepas kontrak diberikan

Gantikan seed dan andaian menggunakan Dokumen Penemuan dan Pemuktamadan client. Kemudian ulang semula formula, RBAC, privacy, regulatory, NFR, integrasi, UAT dan sign-off sebelum sebarang pilot atau production release.

