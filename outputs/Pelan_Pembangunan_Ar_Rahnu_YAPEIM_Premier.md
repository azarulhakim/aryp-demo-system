# Pelan Pembangunan Sistem Transaksi Gadaian Ar-Rahnu YAPEIM Premier

**Status:** Draf perancangan v0.1  
**Tarikh:** 15 Ogos 2026  
**Berdasarkan:** SRS Ar-Rahnu YAPEIM Premier v1.0, 13 halaman  
**Klasifikasi:** **SULIT — untuk kegunaan projek YSV/Ar-Rahnu YAPEIM Premier sahaja**

---

## 1. Keputusan eksekutif

SRS ini sudah memadai untuk menerangkan **skop perniagaan peringkat tinggi**, tetapi **belum build-ready** untuk sistem kewangan produksi. Sistem yang diminta bukan sekadar aplikasi pendaftaran gadaian. Ia ialah platform operasi berbilang francaisi yang mengurus:

1. pelanggan, waris, dokumen identiti dan senarai hitam;
2. penilaian emas serta harga YAPEIM;
3. akad, pembiayaan, BISAS dan Surat Akuan Gadaian (SAG);
4. ansuran, Kadar Keuntungan (KK), tebusan dan lanjutan;
5. inventori marhun dan chain-of-custody bilik kebal;
6. teller, cash drawer, opening float, bank-in dan Tutup Hari;
7. lelongan, lebihan/kurangan dan bayaran balik pelanggan;
8. kelulusan maker-checker dan segregation of duties;
9. laporan cawangan dan pemantauan francaisor;
10. dokumen, resit dan notifikasi;
11. integrasi peranti, bayaran, komoditi dan perakaunan; dan
12. audit, keselamatan, pemulihan bencana serta pematuhan.

**Saranan utama:** laksanakan projek melalui tiga tahap — **MVP UAT**, **pilot 1–3 cawangan**, kemudian **rollout berperingkat**. Jangan benarkan transaksi wang produksi sehingga Calculation Rulebook, matriks kelulusan, kontrak integrasi, dan golden test mendapat kelulusan bertulis Operasi, Kewangan dan penasihat Shariah.

### Legenda dokumen

- **[SRS]** dinyatakan dalam dokumen asal.
- **[CADANGAN]** reka bentuk atau amalan yang dicadangkan.
- **[KEPUTUSAN]** perkara yang mesti disahkan oleh YSV sebelum implementasi berkaitan diteruskan.

---

## 2. Latar belakang dan konteks jenama

**[SRS]** YAPEIM Smart Venture Sdn. Bhd. (YSV) ialah francaisor dan sistem perlu menyokong banyak francaisi serta banyak cawangan. Francaisor melihat keseluruhan rangkaian; francaisi hanya melihat cawangan seliaan.

Sumber awam mengesahkan Ar-Rahnu YaPEIM Premier disenaraikan sebagai francaisor tempatan oleh MyFEX KUSKOP, dan laman rasminya menerangkan YSV sebagai institusi milik penuh YAPEIM serta pusat setempat bagi produk Ar-Rahnu YAPEIM Premier:

- [Carian Francais MyFEX KUSKOP](https://myfexv2.kuskop.gov.my/semak?page=2)
- [Laman rasmi Ar-Rahnu YAPEIM Premier / YSV](https://arrahnupremier.com.my/2023/06/kunjungan-dan-pemantauan-pelaksanaan-francais-ar-rahnu-yapeim/)

**[CADANGAN JENAMA]** Mockup menggunakan logo hitam–emas yang tertanam dalam SRS, dengan palet sokongan maroon dan krim daripada templat dokumen:

| Token | Nilai kerja | Penggunaan |
|---|---:|---|
| Arang/hitam | `#171612` | Header, konteks premium, keselamatan |
| Emas | `#C7972D` | Aksen jenama, navigasi aktif, tindakan utama |
| Maroon | `#990033` | Kelulusan sensitif, amaran dan dokumen rasmi |
| Krim | `#FFF1CB` | Sorotan lembut dan status menunggu |
| Ivory | `#F4F1E9` | Latar aplikasi |
| Hijau | `#126C4B` | Status berjaya dan sepadan |

**[KEPUTUSAN JENAMA]** YAPEIM mengumumkan perubahan logo dan akronim kepada “YAPEIM” selepas kelulusan Lembaga pada 2024. SRS dan logo produk masih menggunakan “YaPEIM”. Sebelum reka bentuk produksi, YSV perlu membekalkan fail logo SVG, panduan penggunaan logo, font, dan keputusan sama ada identiti produk lama atau identiti baharu mesti digunakan. Rujukan: [Pemakluman perubahan logo YAPEIM](https://www.yapeim.my/pemakluman-penukaran-logo-dan-akronim-yayasan-pembangunan-ekonomi-islam-malaysia-yapeim/).

---

## 3. Penilaian kesediaan SRS

### 3.1 Perkara yang sudah jelas

- Struktur francaisor → francaisi → cawangan.
- Lima peranan asas: Admin Francaisor, Penyelia Francaisi, Pengurus, Eksekutif dan Teller.
- Aliran besar gadaian, ansuran/tebusan, vault, lelongan dan tunai.
- Formula asas Nilai Marhun, margin 70%, KK, Fi & Caj, royalti, fi iklan dan caj lelong.
- Dokumen utama: SAG, wakalah, notis komoditi, borang pembiayaan, resit, penebusan dan lelongan.
- Integrasi sasaran: IRIS, harga emas, BISAS, payment gateway, SMS/e-mel, perbankan, printer dan perakaunan.
- Keperluan audit: transaksi kewangan tidak boleh dipadam; void mesti melalui kelulusan.

### 3.2 Perkara P0 yang menghalang pembinaan selamat

| P0 | Percanggahan / kekurangan | Risiko jika dibina secara literal | Keputusan yang diperlukan |
|---:|---|---|---|
| 1 | Pembulatan `.08–.09 → RM1.00`, sedangkan contoh menunjukkan RM2,735.21 menjadi RM2,735.20 | Pembiayaan terlebih/terkurang | Sahkan sama ada sepatutnya `.10`, turun 5 sen, nearest 5 sen atau aturan lain |
| 2 | Tempoh maksimum 10 bulan menggunakan denominator **234 hari** | Fi & Caj salah | Sahkan bulan kalendar atau bilangan hari tetap, inclusive/exclusive dan tahun lompat |
| 3 | Formula tebus menyebut “− Caj Minimum 15 hari” | Caj mungkin ditolak, bukan dikenakan minimum | Sahkan `KK = max(hari sebenar, 15)` serta contoh hari 1/14/15/16 |
| 4 | Contoh KK membulatkan caj sehari sebelum didarab jumlah hari | Hasil berbeza daripada kira tepat kemudian bulat | Sahkan titik dan precision pembulatan |
| 5 | “Ansuran” tidak mempunyai payment waterfall | Baki prinsipal dan KK masa hadapan tidak dapat ditentukan | Sahkan turutan KK → fi → prinsipal atau turutan lain |
| 6 | Auto-lanjut empat bulan memerlukan bayaran KK, tetapi amaun dan grace period tidak dinyatakan | Status lelong salah | Sahkan syarat tepat pada tamat enam bulan |
| 7 | “Bilangan sambungan dibenar: Tiada” boleh bermaksud tiada sambungan atau tiada had | Kitar hayat kontrak tidak jelas | Bezakan lanjutan, pembaharuan dan gadaian baharu selepas cooling period |
| 8 | Harga asas lelong menggunakan “upah simpan”; istilah tidak dipadankan kepada KK/Fi & Caj | Settlement lelong salah | Sahkan komponen dan urutan settlement |
| 9 | Semua payout disebut cash-out dan semua bayaran disebut cash-in walaupun ada pindahan/FPX/e-wallet | Baki drawer salah | Pisahkan lejar tunai, bank dan gateway/clearing |
| 10 | Eksekutif boleh membuat dan meluluskan transaksi | Self-approval dan fraud risk | Matriks maker-checker mengikut tindakan serta had amaun |
| 11 | Drawer, cut-off dan mod offline belum ditetapkan | Tutup Hari, atribusi tunai dan sync tidak dapat direka | Sahkan drawer per teller/shift, business date dan had offline |
| 12 | Tiada kontrak API/provider sebenar | Integrasi, timeline dan kos tidak boleh dianggarkan tepat | Dapatkan dokumentasi, sandbox, SLA dan pemilik teknikal setiap provider |

### 3.3 Kesimpulan readiness

| Kawasan | Status |
|---|---|
| Skop modul | Cukup untuk perancangan |
| Formula kewangan | **Belum lulus untuk coding produksi** |
| Proses Shariah/BISAS | Belum lengkap |
| RBAC dan had kelulusan | Belum lengkap |
| Model teller/tunai | Sebahagian lengkap |
| Vault/lelongan | Aliran besar ada, pengecualian tiada |
| Integrasi | Nama ada, kontrak tiada |
| Non-functional requirements | Hampir tiada |
| Keselamatan/PDPA/DR | Perlu spesifikasi baharu |
| Laporan/dokumen | Senarai ada, layout dan data dictionary tiada |

---

## 4. Skop modul sasaran

### 4.1 Tenant, organisasi dan akses

- Hierarki francaisor, francaisi dan cawangan.
- Skop pengguna kepada satu atau beberapa cawangan.
- Role-based dan attribute-based access.
- Matriks had kelulusan mengikut jenis transaksi dan amaun.
- Delegasi sementara, step-up MFA dan break-glass berjejak.
- Maker tidak boleh meluluskan rekod yang dibuat sendiri.

### 4.2 Pelanggan, waris dan risiko

- Pendaftaran melalui IRIS/MyKad serta fallback manual beralasan.
- Pencarian nombor IC, telefon dan nama.
- Deduplication dan sejarah pelanggan.
- Senarai hitam pusat dengan hasil minimum, tanpa mendedahkan PII francaisi lain.
- Akaun bank dan bukti pengesahan.
- Waris yang dibenarkan, dokumen hubungan dan keutamaan tuntutan.
- Consent, masking dan akses dokumen sensitif.

### 4.3 Harga emas, penilaian dan formula

- Senarai mutu/karat dan harga bertimestamp.
- Snapshot harga pada setiap penilaian.
- Satu gadaian boleh mengandungi beberapa item.
- Berat kasar, tolakan batu/komponen dan berat bersih.
- Foto, seal, barcode/QR dan nota penilai.
- Formula versioned dan effective-dated.
- Calculation trace: input, nilai perantaraan, aturan pembulatan dan output.
- Simulator polisi dan golden tests sebelum publish.

### 4.4 Gadaian, akad dan payout

- Wizard pelanggan → item → penilaian → pembiayaan → akad → kelulusan → payout → vault.
- BISAS/komoditi dengan idempotency, status dan rekonsiliasi.
- SAG dan dokumen berangka siri.
- Payout tunai atau bank dengan lejar saluran yang betul.
- Cash-out hanya bagi pembayaran daripada drawer.
- Pautan lengkap transaksi, dokumen, approval dan audit.

### 4.5 Ansuran, KK, lanjutan dan tebusan

- Quote jumlah “as of” tarikh/masa transaksi.
- Payment allocation yang diluluskan.
- Tunai, kad, e-wallet, FPX atau online banking.
- Pending, failed, expired, reversed, refunded dan chargeback.
- Auto-lanjut hanya apabila syarat rulebook dipenuhi.
- Tebusan penggadai, wakil/waris dan SAG hilang.
- Release vault selepas bayaran settled dan dual control.
- Cooling period dua hari mengikut skop yang disahkan.

### 4.6 Vault dan chain-of-custody

- Hierarki cawangan → vault → safe → rak/bin.
- Beg tamper-evident, seal dan barcode/QR.
- Handover dua pihak, lokasi semasa dan pergerakan append-only.
- Checkout untuk tebusan, audit atau lelongan.
- Stock take, blind count, varians dan exception case.
- Tiada pembetulan lokasi tanpa movement event berjejak.

### 4.7 Teller dan sublejar tunai

- Float bank → cawangan → drawer teller.
- Drawer per teller/shift sebagai default kerja yang paling selamat.
- Cash-in/cash-out automatik hanya untuk mod tunai.
- Lejar double-entry bagi drawer, bank, clearing dan liability.
- Denomination cash count, varians dan kelulusan.
- Void melalui reversal; rekod asal kekal.
- Tutup Hari, exceptional reopen dan bank-in.
- Rekonsiliasi bank dan gateway.

### 4.8 Lelongan

- Eligibility scheduler mengikut versi polisi.
- Status: Aktif → Tertunggak → Layak → Notis → Kelulusan → Dijadual → Dijual/Tidak Terjual → Settlement.
- Legal hold, pertikaian, payment pending dan withdrawal.
- Harga asas, reserve, lot, pembeli, hasil dan kos.
- Lebihan sebagai liability pelanggan sehingga berjaya dibayar.
- Shortfall sebagai kes berasingan tertakluk polisi undang-undang.

### 4.9 Dokumen, notifikasi dan laporan

- Templat versioned, hash dan snapshot data.
- Reprint berwatermark dan audit eksport.
- SMS/e-mel/WhatsApp mengikut consent dan polisi.
- Status queued, sent, delivered, failed dan retry.
- Laporan harian operasi, teller, marhun, lelongan dan kewangan.
- Dashboard HO dengan timestamp kesegaran data.
- PDF dan Excel dengan angka sama seperti sumber.

---

## 5. Peranan dan matriks akses kerja

Matriks ini ialah **cadangan awal** sehingga ditandatangani YSV.

| Kawasan | Admin Francaisor | Penyelia Francaisi | Pengurus | Eksekutif | Teller |
|---|---|---|---|---|---|
| Pelanggan | Baca/audit global | Baca skop | Baca cawangan | Operasi | Operasi |
| Gadaian | Baca global | Baca skop | Lulus pengecualian | Operasi / lulus kerja orang lain jika diberi kuasa | Operasi |
| Ansuran/tebusan | Baca | Baca | Lulus void/pengecualian | Operasi | Operasi |
| Vault | Pantau | Pantau | Urus/lulus | Operasi | Intake/handover |
| Tunai | Pantau/konfigurasi | Pantau | Urus/lulus | Drawer jika ditugaskan | Drawer sendiri |
| Lelongan | Polisi/pantau | Pantau | Urus/lulus | Proses | Tiada atau handover |
| Polisi/formula | Cipta/review/publish melalui maker-checker | Tetapan terhad | Baca | Baca snapshot | Baca snapshot |
| Pengguna | Global | Cawangan seliaan | Lihat roster | Tiada | Tiada |
| Laporan | Global | Francaisi | Cawangan | Operasi sendiri | Syif sendiri |

### Kawalan wajib

- Admin HO read-only terhadap transaksi operasi kecuali break-glass yang diluluskan.
- Teller tidak mempunyai hak approve, void, edit formula atau backdate.
- Maker tidak boleh menjadi checker bagi transaksi sama.
- Penerima/pembayar tunai tidak boleh meluluskan void atau adjustment transaksi itu.
- Fakta yang berubah selepas approval membatalkan approval lama.
- Approval sensitif merekod versi transaksi, amaun, sebab dan approver.

---

## 6. Aliran end-to-end utama

### 6.1 Mula syif teller

Log masuk + MFA → pilih cawangan/kaunter → semak internet, IRIS dan printer → terima float → kira dan akui tunai → buka drawer → dashboard.

**Gate:** transaksi tunai disekat jika drawer belum dibuka atau Tutup Hari sebelumnya belum selesai.

### 6.2 Pelanggan dan gadaian baharu

Imbas MyKad → cari duplikasi → semak blacklist → sahkan/daftar pelanggan → daftar waris dan akaun bank → tambah item → harga emas bertimestamp → kira Nilai Marhun → pilih pembiayaan → BISAS/akad → approval → payout → SAG/resit → cash-out atau bank posting → intake vault.

**Gate:** payout tidak boleh berlaku jika BISAS/akad, approval atau dokumen wajib gagal mengikut rulebook.

### 6.3 Ansuran dan auto-lanjut

Cari SAG/IC → quote baki → tentukan allocation → pilih kaedah → sahkan payment → journal/resit → pada enam bulan, semak jumlah KK yang diwajibkan → lanjut empat bulan atau masuk default.

### 6.4 Tebusan

Cari kontrak → sahkan penggadai/waris/SAG → kira jumlah tebus → payment settled → arahan keluar vault → dual confirmation → serahan → resit dan borang → kontrak ditutup → cooling period.

### 6.5 Lelongan

Scheduler menandakan kelayakan → notis dan bukti → semakan pengurus → legal hold check → keluar vault → jadual/lot → rekod jual → settlement → lebihan/shortfall → surat dan rekonsiliasi.

### 6.6 Tutup Hari

Sistem kira baki → teller masukkan denomination → varians dan justifikasi → pengurus lulus → pastikan tiada transaksi pending/unsynced → kunci syif/business date → bank-in → pengesahan dan rekonsiliasi.

### 6.7 Void atau adjustment

Permintaan dengan sebab/lampiran → approver berbeza → reversal journal → dokumen pembetulan → audit. **Tiada delete rekod kewangan.**

---

## 7. Seni bina sasaran

### 7.1 Prinsip

**[CADANGAN]** Mulakan dengan **modular monolith**, bukan microservices. Gadaian, bayaran, teller, lejar dan vault mempunyai invariant yang lebih selamat dikomit dalam satu transaksi pangkalan data. Modul kekal dipisahkan secara kod supaya boleh diasingkan kemudian jika volum benar-benar memerlukan.

```text
Web kaunter / back-office / portal HO
                 │
       WAF + identity + MFA
                 │
         Application API
  ┌──────────────┼────────────────┐
  │ Customer     │ Policy/Formula │
  │ Pledge       │ Payment        │
  │ Teller/Ledger│ Vault/Auction  │
  │ Docs/Notify  │ Reporting      │
  └──────────────┼────────────────┘
                 │
     PostgreSQL + object storage
                 │
      Transactional outbox/queue
                 │
 IRIS · Harga emas · BISAS · Payment
 SMS/e-mel · Bank · Accounting · Printer
```

### 7.2 Komponen rujukan

| Lapisan | Cadangan |
|---|---|
| UI | Web responsif, desktop/counter-first; PWA hanya untuk cache dan draft terkawal |
| Backend | Modular monolith TypeScript/.NET/Java; satu stack dipilih mengikut pasukan |
| Database | PostgreSQL dengan transaksi ACID, decimal money, tenant/branch scope dan audit |
| Fail | Object storage private untuk IC, foto marhun, slip dan dokumen |
| Async | Queue + transactional outbox untuk notifikasi, laporan dan integrasi |
| Cache | Cache tidak berautoriti sahaja; bukan tempat baki tunai atau status kontrak |
| Auth | MFA, role/permission granular, branch scope, step-up dan session policy |
| Reporting | Operational views + snapshot/read model untuk dashboard konsolidasi |
| Observability | Structured log, correlation ID, metrics invariant dan alert ber-runbook |
| Deployment | Dev, integration, UAT, staging dan production yang benar-benar berasingan |

### 7.3 Multi-tenancy

Semua rekod operasi mesti mempunyai `franchisee_id` dan `branch_id`, dengan kawalan akses di UI **dan** server/database. Hubungan kritikal menggunakan foreign key tenant-aware untuk mengelakkan rekod satu francaisi merujuk rekod francaisi lain.

Francaisor memperoleh grant read/audit merentasi tenant. Tindakan operasi rentas tenant hanya melalui break-glass berjangka dengan sebab, MFA dan audit.

### 7.4 Data teras

| Domain | Entiti utama |
|---|---|
| Organisasi | Francaisor, francaisi, cawangan, pengguna, role, permission, branch scope |
| Pelanggan | Customer, identifier, contact, consent, bank account, waris, blacklist check, document |
| Polisi | Product policy version, formula version, gold price, purity, publication, calculation run |
| Gadaian | Pledge, item, valuation, offer, contract, akad, BISAS order, disbursement, status event |
| Bayaran | Payment intent, provider event, allocation, refund, receipt, settlement |
| Teller | Drawer, shift, float, cash movement, cash count, discrepancy, day close, bank-in |
| Lejar | Account, journal, journal line, reversal, period, reconciliation |
| Vault | Vault, location, bag/seal, custody, movement, stock take, exception |
| Lelong | Case, notice, lot, result, settlement, surplus, shortfall, legal hold |
| Sokongan | Document template, generated document, notification, outbox/inbox, audit, report run |

### 7.5 Ketepatan data

- Wang disimpan sebagai decimal, bukan floating-point.
- Berat emas sekurang-kurangnya empat tempat perpuluhan secara dalaman.
- Kejadian menggunakan timestamp; operasi teller turut menyimpan `business_date`.
- Formula, harga emas dan dokumen disimpan sebagai snapshot/version pada transaksi.
- Journal posted, audit dan chain-of-custody tidak boleh diubah atau dipadam.
- Semua webhook/job menggunakan idempotency key.

---

## 8. Strategi offline

**[SRS]** Offline disenaraikan sebagai isu discovery, bukan requirement yang telah diputuskan.

**[CADANGAN FASA 1]** Sistem kekal online-authoritative. Sediakan dual WAN/4G dan mod degraded yang membenarkan:

- melihat cache minimum;
- mengisi draf;
- kiraan tunai tempatan;
- cetak semula dokumen yang sudah sah; dan
- memaparkan status peranti/integrasi.

Jangan benarkan secara offline pada fasa awal:

- payout atau penerimaan wang;
- tebusan dan release vault;
- KYC baharu tanpa semakan blacklist;
- approval/void;
- lelongan;
- edit harga/polisi; atau
- payment bukan tunai.

Jika transaksi kewangan offline diwajibkan, ia perlu projek tambahan dengan device registration, encrypted queue, had amaun, reference provisional, conflict resolution, resit “pending sync” dan rekonsiliasi wajib. Anggaran effort naik dengan ketara.

---

## 9. Integrasi dan spike awal

| Integrasi | Spike yang perlu dibuat | Soalan utama |
|---|---|---|
| IRIS/MyKad | Uji SDK, OS, browser dan peranti sebenar | Perlu local bridge Windows? Boleh fallback manual? |
| Harga emas YAPEIM | Uji auth, purity list, timestamp dan kegagalan | Berapa lama quote sah? Siapa boleh override? |
| BISAS | Uji sandbox, idempotency, reverse dan reconcile | Mesti confirmed sebelum akad atau payout? |
| FPX/e-wallet/bank | Uji hosted flow, webhook, settlement dan refund | Inbound sahaja atau juga disbursement? |
| SMS/e-mel/WhatsApp | Uji template, delivery state dan retry | Saluran rasmi dan bukti notis yang diterima? |
| Printer/resit | Uji A4, thermal, barcode/QR dan reprint | Model printer setiap cawangan? Perlu print bridge? |
| Perakaunan | Peta carta akaun dan journal batch | SQL/MYOB versi mana? API, fail atau import? |
| CTOS | Discovery polisi dan consent | Wajib atau pilihan? Fail-open atau fail-closed? |

Setiap adapter mesti mempunyai timeout, retry terkawal, deduplication, dead-letter queue, audit reference dan laporan rekonsiliasi.

---

## 10. Pelan pembangunan berfasa

### Fasa 0 — Discovery dan sign-off (4–6 minggu)

**Hasil wajib:**

- Calculation & Shariah Rulebook.
- Golden test workbook bagi pembulatan, hari 1/14/15/16, enam bulan, 10 bulan, tahun lompat, ansuran, tebusan dan lelongan.
- State machine setiap domain.
- Matriks role, permission, approval dan had amaun.
- Data dictionary dan report dictionary.
- Templat akhir SAG, akad, wakalah, resit, notis dan surat lelongan.
- Kontrak/sandbox semua integrasi.
- NFR: volum, availability, performance, retention, RPO/RTO dan data residency.
- Brand kit rasmi.

**Exit gate:** Operasi + Kewangan + Shariah + Audit + IT menandatangani baseline.

### Fasa 1 — Foundation, UX dan seni bina (4–6 minggu; boleh bertindih dengan akhir Fasa 0)

- Tenant/francaisi/cawangan.
- Auth, MFA, RBAC, SoD dan audit.
- Design system dan prototype terperinci.
- Database baseline, CI/CD, environment dan observability.
- Spikes IRIS, printer, harga emas dan BISAS.

**Exit gate:** threat model, tenancy tests, prototype sign-off dan integration proof-of-concept.

### Fasa 2 — Core Pawn MVP untuk UAT (10–12 minggu)

- Pelanggan, MyKad, waris, blacklist.
- Harga emas, penilaian, multi-item dan formula engine.
- Wizard gadaian, approval, BISAS sandbox, payout UAT dan dokumen.
- Vault asas dan audit movement.
- Ansuran/tebusan asas.
- Laporan operasi minimum.

**Exit gate:** satu aliran gadaian → approval → payout → vault → tebusan lulus UAT menggunakan golden data.

### Fasa 3 — Teller, tunai dan kawalan operasi (8–10 minggu)

- Drawer/shift, float dan cash movement.
- Double-entry subledger.
- Cash count, discrepancy, void/reversal dan Tutup Hari.
- Bank-in, rekonsiliasi dan cash dashboard.
- Stock take serta dual custody.

**Exit gate:** semua journal seimbang; day-end dan restore test lulus.

### Fasa 4 — Lelongan, integrasi produksi dan portal HO (8–10 minggu)

- Scheduler notis dan default.
- Lelongan hingga settlement surplus/shortfall.
- Payment, SMS/e-mel, BISAS, harga emas dan hardware produksi.
- Dashboard francaisor, perbandingan cawangan dan laporan konsolidasi.
- Accounting/CTOS hanya jika skop disahkan.

**Exit gate:** reconciliation provider dan simulated 10-month lifecycle lulus.

### Fasa 5 — Hardening, UAT dan pilot 1–3 cawangan (6–8 minggu)

- Security review dan penetration test.
- Performance, concurrency, failover dan DR restore.
- UAT persona sebenar dan hardware lab.
- Data migration rehearsal.
- SOP, latihan, cutover dan rollback.
- Pilot sekurang-kurangnya satu kitaran Tutup Hari dan rekonsiliasi bank penuh.

**Exit gate:** tiada finding kritikal/tinggi terbuka; sign-off Operasi, Kewangan, Shariah, Security dan cawangan pilot.

### Fasa 6 — Rollout berperingkat dan hypercare (4–6 minggu minimum)

- Wave mengikut francaisi/cawangan.
- Checklist onboarding, data, peranti, user dan float.
- Pemantauan KPI teknikal serta invariant kewangan.
- Rollback per wave.
- Hypercare dan transition kepada support BAU.

### Anggaran kalendar

Dengan pasukan selari yang sesuai, sasaran realistik ialah **36–44 minggu** hingga pilot/rollout pertama yang selamat. Integrasi, offline, migrasi dan perubahan formula boleh menambah tempoh.

Jika dibina oleh seorang pembangun sepenuh masa, anggaran kasar ialah **18–30 bulan**, dengan risiko tinggi pada QA kewangan, integrasi perkakasan, keselamatan dan sokongan operasi. Sistem ini tidak sesuai dianggap projek solo jangka pendek.

---

## 11. Pasukan yang disyorkan

| Peranan | Cadangan kapasiti |
|---|---:|
| Product owner YSV | 1, berkuasa membuat keputusan |
| BA/Product manager | 1 |
| Tech lead/architect | 1 |
| Backend engineers | 2–3 |
| Frontend engineers | 2 |
| QA automation/integration | 2 |
| UX/UI designer | 0.5–1 |
| DevOps/SRE | 0.5–1 |
| Security/privacy | Part-time pada setiap gate |
| SME Operasi, Kewangan, Shariah, Audit | Wakil tetap pelanggan |

### Dependency pelanggan

YSV perlu menyediakan:

- pemilik keputusan Operasi, Kewangan, Shariah, Audit dan IT;
- contoh transaksi sebenar dan boundary cases;
- formula yang ditandatangani;
- semua templat dokumen;
- provider/API, sandbox dan credentials UAT;
- model IRIS dan printer;
- contoh penyata bank dan mapping akaun;
- volum francaisi, cawangan, teller dan transaksi;
- data legacy dan polisi migrasi; dan
- brand kit rasmi.

---

## 12. Backlog epic dan saiz relatif

| Epic | Saiz | Dependency |
|---|---:|---|
| Rulebook dan discovery | L | SME dan sign-off |
| Tenant/RBAC/audit | XL | Role matrix dan threat model |
| Pelanggan/waris/blacklist | M | IRIS, PDPA dan data dictionary |
| Formula engine | XL | Golden tests |
| Gadaian/akad/BISAS/payout | XXL | Formula, RBAC, dokumen dan integrasi |
| Vault asas | L | ID item, barcode/seal dan lokasi |
| Ansuran/tebusan | XL | Payment waterfall dan lejar |
| Teller/Tutup Hari | XXL | Drawer, cut-off dan chart of accounts |
| Laporan minimum | M–L | Definisi KPI stabil |
| Lelongan | XL | State, formula, notis dan vault |
| Integrasi produksi | XXL | Provider contract/sandbox |
| Portal francaisor | L | Multi-tenant read model |
| Security/DR/readiness | XL–XXL | NFR dan infrastruktur |
| Accounting atau CTOS | XL setiap satu | Kontrak luar |
| Offline kewangan | XXL | Semua workflow stabil dahulu |
| Migrasi dan rollout | XXL | Kualiti data dan pilot exit gate |

**Laluan kritikal:** Rulebook → tenancy/RBAC/data model → customer/formula → gadaian/BISAS/dokumen → lejar/teller/vault → ansuran/tebusan → lelongan → integrasi → security/UAT/pilot → migrasi/rollout.

---

## 13. Acceptance criteria peringkat sistem

### Ketepatan kewangan

- Semua golden tests memberi output yang diluluskan.
- Setiap journal posted seimbang debit = kredit.
- Retry webhook/job tidak mengubah baki kali kedua.
- Tunai, bank dan gateway tidak bercampur.
- Void menghasilkan reversal dan tidak memadam rekod asal.

### Keselamatan dan tenant

- Francaisi A tidak boleh membaca atau menulis data Francaisi B.
- Pengguna hanya melihat cawangan yang diberikan.
- IC, telefon dan bank dimask pada UI/log/eksport mengikut permission.
- MFA dan step-up berfungsi pada tindakan sensitif.
- Akses dokumen, eksport dan break-glass diaudit.

### Operasi

- Drawer belum dibuka tidak boleh memproses tunai.
- Tebusan serentak terhadap gadaian sama hanya boleh berjaya sekali.
- Vault release tidak boleh berlaku sebelum settlement dan dual control.
- Tutup Hari mengunci business date.
- Lelongan disekat apabila legal hold, dispute atau payment pending wujud.

### Integrasi

- Setiap call mempunyai reference/idempotency key.
- Timeout/retry tidak menduplikasi transaksi.
- Delayed atau out-of-order webhook diproses dengan betul.
- Reconciliation report boleh menjelaskan setiap perbezaan.
- Status kegagalan jelas kepada pengguna dan mempunyai runbook.

---

## 14. Strategi ujian

| Jenis ujian | Liputan wajib |
|---|---|
| Unit | Formula, rounding, dates, allocation, state transition |
| Property/invariant | Debit = kredit, retry tidak mengubah baki, satu lokasi aktif/item |
| Integration | DB sebenar, queue, object storage dan provider sandbox |
| Tenant/RBAC | Dua francaisi, beberapa cawangan, semua negative cross-tenant cases |
| Concurrency | Dua teller tebus gadaian sama, duplicate webhook, day-close serentak |
| Hardware | IRIS dan setiap model printer di lab sebenar |
| Visual regression | SAG, resit, borang, notis dan surat lelongan |
| Performance | Volum kaunter serentak, scheduler harian dan laporan HO |
| Security | SAST/DAST, dependency scan, penetration test, secret/access review |
| DR | Backup restore, queue replay, validation journal/vault/teller selepas restore |
| UAT | Persona Teller, Eksekutif, Pengurus, Penyelia dan Admin Francaisor |

### Golden test minimum formula

- Pecahan sen `.01` hingga `.09`.
- Tebus pada hari 1, 14, 15 dan 16.
- Tarikh mula 28/29 Februari dan 29/30/31 haribulan.
- Tamat enam bulan dan 10 bulan.
- Tahun lompat.
- Ansuran sebelum/selepas enam bulan.
- KK dibayar separa/penuh.
- Payment reversal dan overpayment.
- Auction sold, unsold, surplus, shortfall dan withdrawal.

---

## 15. Keselamatan, privasi dan audit

- Jalankan compliance traceability bersama penasihat undang-undang/Shariah; sebutan BNM/SKM/KUSKOP dalam SRS belum menjadi control matrix.
- Enkripsi data sensitif semasa transit dan simpanan.
- Gunakan blind index/HMAC untuk carian IC; jangan log IC penuh.
- Object storage private dengan URL singkat dan audit.
- Jangan simpan PAN/CVV; gunakan hosted/tokenized payment.
- MFA untuk Pengurus, Penyelia dan HO; step-up bagi approval, export sensitif dan role change.
- Session timeout, re-auth, device/session controls dan revocation.
- Upload validation, malware scan, content type dan size limit.
- Watermark eksport/dokumen sulit.
- Audit append-only: actor, masa, device, branch, before/after, sebab, approval dan correlation ID.
- Retention, legal hold, data residency, hak pembetulan dan pelupusan selamat perlu diluluskan.

### Sasaran DR awal untuk perbincangan

**[CADANGAN, bukan SRS]** RPO 15 minit dan RTO 4 jam. Sasaran akhir mesti berdasarkan maksimum kerugian operasi yang boleh diterima YSV. Ujian restore sekurang-kurangnya suku tahunan.

---

## 16. Mockup dan spesifikasi UX

### 16.1 Prototype konsep yang disediakan

Prototype interaktif menggunakan data rekaan dan merangkumi:

1. app shell, konteks cawangan dan role switcher;
2. dashboard kaunter/operasi;
3. pelanggan, blacklist, dokumen dan waris;
4. wizard gadaian lima langkah;
5. kalkulator penilaian sementara berdasarkan contoh SRS;
6. ansuran dan tebusan;
7. vault, lokasi dan handover;
8. pipeline lelongan;
9. teller, buku tunai, cash count dan Tutup Hari;
10. peti masuk kelulusan dan had kuasa;
11. notifikasi dan templat dokumen;
12. laporan dan eksport; dan
13. polisi pusat, pengguna serta kesihatan integrasi.

Prototype ini ialah **full-scope concept mockup**, bukan spesifikasi visual produksi yang telah diluluskan. Nilai, had, formula dan data hanyalah demonstrasi.

### 16.2 Definition of complete bagi handoff produksi

Selepas keputusan P0, UX produksi dianggarkan memerlukan **70–75 template skrin desktop**, tidak termasuk modal dan variasi state:

| Kumpulan | Anggaran template |
|---|---:|
| Akses, MFA dan sesi | 5 |
| Dashboard mengikut peranan | 5 |
| Pelanggan/waris/blacklist | 5 |
| Gadaian dan akad | 9 |
| Ansuran/tebusan | 6 |
| Lelongan | 6 |
| Vault | 6 |
| Teller/tunai/bank-in | 10 |
| Kelulusan | 3 |
| Laporan/pemantauan | 5 |
| Pentadbiran/integrasi/audit | 10 |
| Global search/notifikasi/profil | 4 |

State yang turut wajib: loading, empty, validation error, permission denied, offline/degraded, timeout, data stale, duplicate customer, IRIS failure, harga emas stale, BISAS pending/failed, payment pending/failed, SMS failed dan printer unavailable.

### 16.3 Aksesibiliti dan responsive

- Sasaran WCAG 2.2 AA.
- Operasi keyboard penuh dan focus yang jelas.
- Status menggunakan ikon + teks, bukan warna sahaja.
- Touch target minimum 44×44 px.
- Nilai RM menggunakan tabular figures dan alignment kanan.
- Desktop ialah platform utama transaksi berat.
- Tablet menyokong kaunter/pengurus.
- Telefon menyokong dashboard, carian, approval dan notifikasi; cash count/valuation kompleks kekal desktop/tablet kecuali diwajibkan.

---

## 17. Pilot exit criteria

Pilot hanya boleh lulus apabila:

- 100% golden tests formula lulus dan ditandatangani;
- tiada finding security kritikal/tinggi terbuka;
- dua Tutup Hari berturut-turut seimbang bagi setiap cawangan pilot;
- bank/payment/BISAS reconciliation menjelaskan 100% transaksi;
- tiada item vault tanpa lokasi atau movement sah;
- semua notis dan dokumen mempunyai versi serta audit;
- backup restore dan recovery drill lulus;
- support runbook, incident owner dan rollback diuji;
- pengguna pilot menandatangani UAT; dan
- Operations, Finance, Shariah, Security dan IT memberi go-live approval.

---

## 18. Soalan keputusan untuk YSV

### P0 — jawab sebelum coding formula/lejar

1. Adakah pembulatan `.08–.09` sepatutnya ke `.10`, dan adakah pembiayaan sentiasa dibulat turun ke 5 sen?
2. Apakah denominator rasmi Fi & Caj bagi 10 bulan; bulan kalendar atau hari tetap?
3. Adakah KK minimum 15 hari bermaksud `max(hari sebenar, 15)`?
4. Adakah KK harian dibulat setiap hari atau hanya jumlah terkumpul dibulat di akhir?
5. Apakah payment waterfall ansuran, dan adakah KK seterusnya berdasarkan pembiayaan asal atau baki prinsipal?
6. Berapa jumlah KK yang mesti dibayar pada enam bulan untuk auto-lanjut empat bulan, dan adakah grace period?
7. Apakah maksud “Bilangan Sambungan Dibenar: Tiada”?
8. Apakah komponen “upah simpan” dan settlement penuh lelongan?
9. Bolehkah Eksekutif melulus kerja sendiri? Apakah threshold Teller/Eksekutif/Pengurus/Penyelia?
10. Drawer per teller, kaunter atau syif? Apakah cut-off Tutup Hari?

### P1 — jawab sebelum pilot

11. Adakah Admin HO benar-benar read-only pada transaksi cawangan?
12. Repeat customer, blacklist dan cooling period merentasi seluruh YSV atau hanya satu francaisi?
13. Adakah tebusan penuh dibenarkan melalui payment gateway atau wajib di cawangan?
14. Apakah provider dan kontrak IRIS, harga emas, BISAS, gateway, SMS/WhatsApp dan accounting?
15. Apakah OS, browser dan model printer/reader di cawangan?
16. Apakah proses bagi auction unsold, dispute, withdrawal, shortfall dan lebihan tidak dituntut?
17. Apakah polisi MFA, session, retention, data residency, RPO/RTO dan support SLA?
18. Berapa jumlah francaisi, cawangan, teller serentak, transaksi harian dan data legacy?
19. Sila sediakan semua dokumen rasmi dan expected report samples.
20. Logo/panduan jenama manakah yang mesti digunakan untuk produk ini?

---

## 19. Pelan tindakan 10 hari bekerja pertama

| Hari | Aktiviti | Output |
|---:|---|---|
| 1 | Kick-off dengan sponsor dan owner keputusan | RACI dan cadence |
| 2 | Workshop formula/istilah Shariah | Calculation issue register |
| 3 | Workshop ansuran, tebusan, lanjutan dan lelongan | State machine + examples |
| 4 | Workshop teller, drawer, cut-off dan bank-in | Cash operation rulebook |
| 5 | Workshop role, approval dan SoD | Signed access matrix draft |
| 6 | Inventori integrasi dan hardware | Provider/spike plan |
| 7 | Dokumen, laporan dan data dictionary | Template/report backlog |
| 8 | NFR, security, PDPA, DR dan support | NFR baseline |
| 9 | Review prototype dengan lima persona | UX decision log |
| 10 | Playback dan baseline approval | Gate 0 plan serta sprint backlog |

---

## 20. Rumusan

Sistem ini boleh dibina, tetapi ia perlu diperlakukan sebagai **platform transaksi kewangan dan custody aset**, bukan CRUD biasa. Tiga pelindung terpenting ialah:

1. formula dan kitar hayat yang ditandatangani serta diuji menggunakan golden examples;
2. lejar, approval dan custody yang immutable, atomik dan boleh diaudit; dan
3. rollout melalui UAT serta pilot terkawal sebelum peluasan rangkaian.

Mockup boleh digunakan sekarang untuk menyelaraskan bahasa operasi dan susunan skrin. Nilai dan state yang masih provisional tidak boleh dianggap polisi muktamad sehingga soalan P0 dijawab.
