# ARYP — Autonomous Assumption Register v0.1

**Mode:** pembangunan dipercepatkan berasaskan assumption untuk demo/UAT. Register ini tidak sama dengan kelulusan production.

Saya akan terus membuat keputusan teknikal dan operasi yang reversible. Untuk perkara berisiko tinggi, saya tetap memilih default simulasi supaya pembangunan bergerak, tetapi mengekalkan label `ASSUMED—NOT APPROVED` dan tidak mengaktifkan wang/data/provider sebenar.

## Default global yang digunakan

- Multi-branch tenant model; branch users see assigned branches and franchisor/auditor views are explicitly privileged.
- Six demo roles; maker-checker and no self-approval for risk/financial/custody actions.
- Malay-first UI, MYR-SIMULATION currency, Asia/Kuala_Lumpur timezone and dd/mm/yyyy display.
- Synthetic/masked data only; no production PII, secrets, real cash, real marhun or live provider calls.
- Formula and policies are versioned/configurable; unresolved values use `PENDING_CLIENT` and never silently become production policy.
- Payments, cash, notifications, identity readers, price feeds, auction settlement and external integrations use mock adapters.
- Default-deny authorization, tenant isolation, correlation IDs, append-only audit plumbing and masked-by-default exports.
- No offline money/custody transaction; degraded mode is view-only until an approved offline policy exists.
- Release path is staging → UAT/pilot → production, with rollback and gate evidence required at each transition.

## Cara register ini digunakan

- `AUTO-ACCEPTED WORKING DEFAULT`: terus dilaksanakan; perubahan kemudian melalui change request.
- `AUTO-ASSUMED FOR DEMO`: terus digunakan dalam synthetic environment.
- `CLIENT SIGN-OFF BEFORE PRODUCTION`: tidak boleh dianggap polisi rasmi atau digunakan dengan data/wang sebenar.

## Semua requirement (226 item)

### 1. GOV-01 — Namakan sponsor eksekutif, Product Owner tunggal, pemilik Operasi, Kewangan, Shariah, Undang-undang/Compliance, Data, Keselamatan dan Teknologi. Tetapkan pengganti jika pemilik tiada.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Sponsor; Surat pelantikan/RACI dan carta organisasi projek.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 2. GOV-02 — Takrif kuorum dan tahap kelulusan bagi polisi wang, formula, Shariah, akses, data, integrasi dan go-live. Nyatakan perkara yang memerlukan lembaga/jawatankuasa.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Sponsor + Setiausaha Projek; Terms of Reference dan matriks kuasa keputusan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 3. GOV-03 — Gunakan satu state model: BELUM DIBINCANG → DALAM SEMAKAN → DIPUTUSKAN → DILULUSKAN, dengan cabang terkawal BLOCKED, TIDAK BERKENAAN, DITOLAK atau DIKECUALIKAN DENGAN RISIKO. Setiap cabang wajib mempunyai alasan, kuasa dan bukti.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Product Owner; Decision register yang dikawal versi + status transition rules.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 4. GOV-04 — Tetapkan proses change request selepas baseline: pencetus, analisis impak kos/jadual/data/ujian, badan kelulusan, versioning dan komunikasi cawangan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** PMO/Product Owner; Templat CR dan aliran change control.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 5. GOV-05 — Tetapkan tempat simpanan rasmi dokumen, konvensyen nama, pengelasan SULIT, kawalan akses, tempoh semakan dan rekod minit.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** PMO + Security; Document management SOP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 6. GOV-06 — Setujui cadence bengkel, playback, prototaip, demo sprint, risk review dan steering committee; tentukan SLA jawapan pelanggan.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Project Manager; Kalendar projek dan communication plan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 7. BUS-01 — Sahkan objektif: automasi end-to-end gadaian, pengiraan, rekod pelanggan, lelongan, teller/tunai, laporan dan pemantauan francaisor.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Sponsor + Product Owner; Business case dan objective tree.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 8. BUS-02 — Takrif skop keluaran pertama, pilot dan rollout penuh. Nyatakan fungsi yang wajib sebelum wang/barang sebenar diproses.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Steering Committee; Scope matrix Must/Should/Could/Won't.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 9. BUS-03 — Tetapkan KPI: masa pendaftaran/gadaian/tebusan, ketepatan kiraan, kadar rekonsiliasi, variance tunai, overdue, kehilangan marhun, delivery notis, uptime dan kepuasan pengguna.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Operations + Finance; KPI dictionary serta laporan semasa.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 10. BUS-04 — Nyatakan model hasil dan kos: KK, fi & caj, royalti, fi iklan, caj lelong, kos provider, franchise fee dan perakaunan antara entiti.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Commercial; Model kewangan dan perjanjian francais berkaitan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 11. BUS-05 — Senaraikan proses manual yang sengaja dikekalkan, pemilik, kawalan, tempoh dan trigger untuk automasi kemudian.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Operations; Process inventory/as-is SOP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 12. BUS-06 — Takrif prinsip pengalaman pelanggan dan pekerja: bahasa, privasi di kaunter, tempoh menunggu, bantuan untuk OKU/warga emas dan saluran aduan.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G1`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Customer Experience; Service blueprint dan customer charter.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 13. ORG-01 — Sahkan hierarki: satu francaisor YSV, banyak francaisi dan satu/lebih cawangan bagi setiap francaisi. Sahkan sama ada entiti lain diperlukan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Franchise Operations; Senarai entiti undang-undang, francaisi dan cawangan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 14. ORG-02 — Tentukan pemilik rekod pelanggan, transaksi, wang dan marhun; hak francaisor untuk melihat, mengeksport, membetulkan atau menahan data.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal + Data Owner; Perjanjian francais + legal opinion.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 15. ORG-03 — Sahkan sempadan repeat customer, cooling period dan blacklist: seluruh rangkaian, francaisi atau cawangan; tentukan konflik dan perkongsian data.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Operations + Compliance; Polisi pelanggan/risiko dan contoh kes.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 16. ORG-04 — Sahkan portal HO read-only pada transaksi cawangan versus kuasa konfigurasi pusat, emergency intervention dan pembetulan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Franchisor Product Owner; Role policy dan contoh konfigurasi pusat.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 17. ORG-05 — Takrif lifecycle francaisi/cawangan: onboarding, pertukaran pemilik, penggabungan, penggantungan, penamatan, archival dan akses selepas keluar rangkaian.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Franchise Ops + Legal; Franchise lifecycle SOP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 18. ORG-06 — Sahkan konfigurasi yang diwarisi dari HO dan yang boleh diubah francaisi/cawangan; tetapkan effective date dan precedence.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Product Owner; Configuration authority matrix.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 19. OPS-01 — Putuskan drawer berasingan bagi teller/kaunter/syif atau drawer kongsi; nyatakan handover dan dual count.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Branch Operations + Finance; SOP kaunter dan cash drawer semasa.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 20. OPS-02 — Tetapkan business date, waktu cut-off, zon masa, hujung minggu/cuti, transaksi selepas cut-off dan kuasa reopen Tutup Hari.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Operations + Finance; SOP operasi, jadual cawangan dan kalendar cuti.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 21. OPS-03 — Putuskan skop mod offline/degraded: view-only atau transaksi terhad; urutan nombor, limit, bukti, sync, konflik dan reconciliation.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Operations + Technology + Risk; Risk assessment internet cawangan dan BCP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 22. OPS-04 — Takrif pembukaan syif, float request/issue/acknowledge, pertukaran teller, rehat, tutup syif dan late close.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Branch Operations; Swimlane SOP dan borang semasa.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 23. OPS-05 — Tetapkan had tunai/takaful per lokasi, trigger amaran, escalation, pengawal/pengangkutan wang dan bank-in kecemasan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Risk + Finance; Polisi tunai, takaful dan keselamatan fizikal.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 24. OPS-06 — Sahkan peralatan dan persekitaran setiap cawangan: workstation, tablet, MyKad/IRIS, printer A4/resit, scanner, kamera, label/barcode, network dan UPS.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** IT Operations; Inventori aset/model/OS/driver dan site survey.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 25. OPS-07 — Tentukan bahasa UI/dokumen, aturan nombor/format tarikh, local holidays dan bantuan operasi bagi cawangan luar biasa.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Operations + Brand; Brand/language guide dan daftar lokasi.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 26. OPS-08 — Sahkan cross-branch servicing: pendaftaran, ansuran, tebusan, pembetulan, complaint dan release di cawangan selain cawangan asal; tentukan pemilikan tunai, lejar dan marhun.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Operations + Finance + Vault; Cross-branch policy + contoh kes.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 27. IAM-01 — Sahkan peranan Admin Francaisor, Penyelia Francaisi, Pengurus Cawangan, Eksekutif dan Teller; tambah Finance, Auditor, Vault Custodian, Auction dan Support jika perlu.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** HR + Operations + Security; Senarai jawatan dan tugas sebenar.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 28. IAM-02 — Selesaikan konflik Eksekutif boleh membuat, mengesah dan melulus transaksi. Tetapkan maker-checker dan larangan self-approval per tindakan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Risk + Operations; SoD policy dan fraud scenarios.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 29. IAM-03 — Tetapkan threshold approval mengikut amaun, jenis transaksi, variance, void, harga manual, payout, lelongan dan tahap organisasi.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Operations; Delegation of authority terkini.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 30. IAM-04 — Pilih sumber identiti/SSO, MFA, password, session timeout, device trust, concurrent sessions dan lockout.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Security + IT; Identity architecture/policies.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 31. IAM-05 — Takrif joiner-mover-leaver, temporary access, delegation, recertification, dormant accounts dan emergency break-glass.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** HR + Security; IAM SOP dan HR feed design.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 32. IAM-06 — Log sebab, approver, sebelum/selepas dan correlation ID untuk tindakan privileged; larang akaun kongsi.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Security; Audit policy dan log sample.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 33. CUS-01 — Sahkan medan wajib pelanggan, jenis pengenalan, warganegara/bukan warganegara, umur minimum, alamat, telefon, e-mel dan akaun bank.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Operations + Legal; Borang pendaftaran dan data dictionary pelanggan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 34. CUS-02 — Takrif kontrak IRIS/MyKad reader: data dibaca, consent, imej IC, fallback manual, mismatch, device failure dan rekod bukti.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** IT + Compliance; Vendor API/SDK, licence dan SOP manual.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 35. CUS-03 — Tentukan matching/deduplication bagi No. IC, pasport, telefon dan pelanggan lama; aliran merge/unmerge serta maker-checker.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Data Owner; Data sample, duplicate cases dan dedupe rules.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 36. CUS-04 — Sahkan blacklist dalaman/CTOS/sanctions jika berkenaan: sumber, kriteria, skop rangkaian, override, expiry, appeal dan adverse action notice.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Compliance + Risk; Risk policy, legal basis dan provider contract.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 37. CUS-05 — Takrif consent/notis privasi per tujuan: transaksi, notifikasi, pemasaran, semakan pihak ketiga, biometrik/dokumen dan perkongsian francaisor-francaisi.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** DPO/Legal; Approved privacy notices dan consent wording.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 38. CUS-06 — Takrif risk rating, enhanced due diligence, PEP/sanctions/AML jika terpakai, source of funds dan transaksi mencurigakan tanpa mendedahkan tipping-off.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Compliance Officer; AML/CFT applicability opinion dan policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 39. CUS-07 — Sahkan hak pembetulan data, akses rekod, deletion/restriction jika sah, deceased customer dan identity theft/dispute.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** DPO + Customer Service; Data subject request SOP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 40. CUS-08 — Sahkan eligibility mengikut jenis operator: umur minimum, keupayaan mental, anggota/bukan anggota, warganegara/bukan warganegara dan dokumen alternatif. Arahan SKM 3/2026 menetapkan minimum 18 tahun serta waras bagi koperasi.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal + Compliance + Operations; Eligibility policy + regulatory perimeter memo.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 41. CUS-09 — Takrif product disclosure, aduan, kesukaran kewangan/hardship, rayuan keputusan dan fair-conduct workflow yang dikehendaki regulator/lesen.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Compliance + Customer Service; Approved disclosure sheet, complaints/hardship SOP dan SLA.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 42. HEIR-01 — Sahkan siapa boleh dinamakan sebagai waris: suami/isteri, anak ≥18, ibu, ayah atau adik-beradik; bilangan, keutamaan dan perubahan selepas gadaian.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal + Operations; Polisi waris dan borang semasa.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 43. HEIR-02 — Takrif kuasa waris dinamakan vs wakil: lihat, bayar, tebus, menerima marhun atau menerima lebihan; adakah surat kuasa diperlukan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal; Legal opinion dan approved document checklist.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 44. HEIR-03 — Takrif aliran SAG hilang dan Surat Akuan Sumpah: identity checks, indemnity, approval, waiting period, reprint dan fraud hold.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal + Risk; Templat akuan sumpah dan SOP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 45. HEIR-04 — Takrif proses kematian/ketidakupayaan: dokumen pusaka, pentadbir, multiple claimants, court order, freeze dan komunikasi.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal + Customer Service; Legal SOP dan sample documents.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 46. HEIR-05 — Takrif dispute/identity theft: status hold, barang tidak boleh bergerak, transaksi dibekukan, SLA siasatan dan escalation.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Risk + Legal; Dispute management SOP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 47. SHR-01 — Sahkan struktur kontrak sebenar dan istilah: rahn, pembiayaan, KK/ujrah, fi & caj, wakalah, jual-beli komoditi BISAS, royalti dan fi iklan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Shariah Committee/Advisor; Shariah product paper yang diluluskan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 48. SHR-02 — Takrif sequence akad dan syarat sah sebelum payout; tindakan jika BISAS/akad/dokumen gagal atau selesai tidak mengikut urutan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Shariah + Product Owner; Shariah process flow + BISAS rules.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 49. SHR-03 — Sahkan nomenklatur pada UI, resit, SAG dan lejar—termasuk konflik istilah KK, ujrah/upah simpan dan fi.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Shariah + Legal + Brand; Approved glossary dan wording.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 50. SHR-04 — Sahkan bagaimana pembetulan, reversal, void, refund, waiver, late event dan auction shortfall/lebihan diperlakukan dari sudut Shariah.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Shariah Committee; Shariah exception rulings dan examples.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 51. SHR-05 — Takrif version/effective-date bagi polisi Shariah dan kesan kepada kontrak sedia ada apabila kadar atau struktur berubah.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Shariah Secretariat; Shariah governance/change policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 52. SHR-06 — Tetapkan Shariah review/audit sampling, evidence pack dan exception reporting.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Shariah Audit; Shariah audit programme.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 53. VAL-01 — Sahkan sumber Harga Emas YAPEIM mengikut mutu, unit RM/gram, jadual mutu yang dibenarkan, masa efektif dan pihak yang menerbitkan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Product + Finance; Price feed specification dan sample payload/history.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 54. VAL-02 — Takrif stale-price threshold, cache, fallback manual, second approval, sebab override dan larangan backdate.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Risk + Operations; Price outage/override policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 55. VAL-03 — Sahkan formula NM = harga mengikut mutu × berat; precision harga/berat/NM, treatment batu/aksesori, berat kasar/bersih dan multi-item.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Valuation Lead + Finance; Valuation rulebook + weighing examples.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 56. VAL-04 — Takrif kategori barang, deskripsi, gambar, tanda khas, bilangan, seal/tag/barcode, keadaan dan risiko barang palsu/berongga.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Valuation + Vault; Marhun taxonomy dan sample photos/forms.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 57. VAL-05 — Sahkan alat timbang, resolusi, kalibrasi, certificate expiry, device integration dan fallback entry manual.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Operations + Quality; Equipment register + calibration SOP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 58. VAL-06 — Takrif revaluation, correction sebelum/selepas akad, maker-checker, dispute pelanggan dan cap nilai/berat luar biasa.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Risk + Valuation; Exception policy dan approval limits.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 59. CALC-01 — Betulkan jadual pembulatan: SRS menyatakan RM0.08–RM0.09 → RM1.00. Sahkan sama ada sepatutnya RM0.10 dan sama ada pembiayaan sentiasa dibulat turun ke 5 sen.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS—KONFLIK`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Shariah; Arahan polisi bertandatangan + contoh 0.00 hingga 0.99.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 60. CALC-02 — Sahkan denominator Fi & Caj bagi 10 bulan; contoh SRS menggunakan 234 hari walaupun tempoh 6+4 bulan. Pilih hari tetap, actual calendar days atau kaedah lain.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS—KONFLIK`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Shariah; Calculation policy + contoh leap year/month-end.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 61. CALC-03 — Sahkan KK minimum 15 hari sebagai max(hari sebenar,15) atau kaedah lain; formula SRS menulis tolak caj minimum.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS—KONFLIK`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Shariah; Approved formula dan contoh tebus hari 0,1,14,15,16.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 62. CALC-04 — Sahkan precision dan titik pembulatan KK: simpan nilai harian berprecision tinggi lalu bulat total, atau bulat RM0.90 sehari sebelum darab.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS—KONFLIK`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance; Precision/rounding standard dan reconciliation examples.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 63. CALC-05 — Sahkan payment waterfall ansuran: KK, fi/caj, principal, royalti/iklan atau urutan lain; partial/overpayment dan baki prinsipal bagi KK seterusnya.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Shariah; Approved waterfall dan contoh multiple instalments.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 64. CALC-06 — Sahkan syarat auto-lanjut selepas 6 bulan: jumlah KK yang mesti dibayar, tarikh akhir, grace period, partial payment, reversal dan notis kegagalan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Operations + Shariah; Extension rule + boundary cases.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 65. CALC-07 — Tafsir ‘Bilangan Sambungan Dibenar: Tiada’ dan ‘Nilai Pinjaman Baru: Tiada’: tiada sambungan, tanpa had, atau tebus dahulu + cooling period 2 hari.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS—AMBIGU`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Product Owner + Shariah; Product ruling dan lifecycle diagram.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 66. CALC-08 — Takrif ‘kadar upah simpan’ dalam harga asas lelong dan hubungannya dengan KK/fi & caj; sahkan caj lelong 3% × NM serta point-in-time NM.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS—AMBIGU`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Shariah; Auction settlement formula + examples.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 67. CALC-09 — Sahkan royalti 7.20% dan fi iklan 1.40% atas KK: accrual harian atau realization, rounding, reversal, tax dan penerima.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Commercial; Franchise agreement + accounting treatment.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 68. CALC-10 — Takrif day-count: inclusive/exclusive, timezone, time-of-day, leap year, DST tidak berkenaan, month-end, cut-off dan backdated events.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Technology; Date convention standard.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 69. CALC-11 — Takrif precision internal, paparan, posting lejar, resit dan settlement bagi setiap amount; larang floating point binary untuk wang.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Architecture; Money/decimal standard.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 70. CALC-12 — Wujudkan rule version, effective date dan immutable calculation snapshot pada transaksi supaya pengiraan lama boleh diulang selepas polisi berubah.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Product + Architecture; Calculation engine design + audit sample.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 71. CALC-13 — Jika operator ialah koperasi, bandingkan SRS dengan Arahan SKM 3/2026: amaun pembiayaan maksimum ialah nilai lebih rendah antara RM300,000 atau 80% nilai marhun (bukan margin produk wajib 80%); agregat 25% Kumpulan Wang Anggota; maksimum 18 bulan; kadar anggota/bukan anggota; tiada fi/caj; dan Ibra’ penyelesaian awal. Tentukan rule set sebenar bagi setiap entiti dan kontrak lama/baru.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—KONFLIK MATERIAL`; **Gate:** `G2`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal + SKM Compliance + Shariah + Finance; Matriks SRS–SKM–lesen–entiti + legal/Shariah ruling + effective-date migration plan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 72. PWN-01 — Sahkan urutan pelanggan → penilaian → kiraan → approval → BISAS/akad → payout → SAG → vault; siapa boleh pause/cancel dan pada state mana.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Operations + Shariah; Signed BPMN/state diagram.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 73. PWN-02 — Takrif status lengkap: Draft, Awaiting Approval, Approved, Akad Pending, Payout Pending, Active, Overdue, Auction Ready, Redeemed, Auctioned, Cancelled, Void/Disputed.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Product Owner; State dictionary.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 74. PWN-03 — Sahkan minimum RM100, maksimum 70% NM, request pelanggan di bawah maksimum, had agregat pelanggan/cawangan dan approval nilai tinggi.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Credit/Risk + Finance; Financing policy dan authority limits.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 75. PWN-04 — Takrif kaedah payout tunai/transfer, payee validation, bank account ownership, approval, pending/failed/duplicate/retry dan reversal.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Operations; Payout SOP + bank/provider contract.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 76. PWN-05 — Sahkan numbering SAG/reference per tenant/cawangan/tahun, reservation ketika offline, gap/duplicate dan reprint.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Operations + Audit; Numbering standard.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 77. PWN-06 — Takrif edit/void/cancel sebelum dan selepas akad/payout; maker-checker, customer acknowledgement, journal reversal dan marhun disposition.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal + Finance + Operations; Exception matrix.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 78. PWN-07 — Takrif transaksi serentak/duplicate clicks, idempotency key, record locking dan recovery selepas timeout.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Architecture + QA; Concurrency scenarios.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 79. PAY-01 — Sahkan jenis bayaran yang diterima: ansuran principal, KK sahaja, fi/caj, settlement penuh; minimum/maksimum dan kombinasi dibenarkan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Shariah; Payment policy + examples.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 80. PAY-02 — Sahkan tunai, kad, e-wallet, FPX/online banking dan transfer; tentukan channel mana untuk ansuran/tebusan dan bila marhun boleh dilepas.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Operations; Channel matrix dan settlement SLA.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 81. PAY-03 — Takrif pembayaran oleh pihak ketiga/wakil, nama payer, resit, refund destination dan semakan AML/fraud jika terpakai.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Compliance + Finance; Third-party payment policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 82. PAY-04 — Takrif jumlah tebus real-time, quote expiry, pembayaran separa ketika quote aktif, cut-off hari dan perubahan caj selepas kegagalan gateway.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Product; Redemption quote specification.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 83. PAY-05 — Takrif release marhun: receipt settled, identity/docs complete, dual control vault, customer acknowledgement dan no outstanding hold.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Vault + Operations; Release checklist.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 84. PAY-06 — Takrif refund/overpayment, wrong payment, chargeback, reversal selepas release dan unclaimed refund.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Risk; Refund/chargeback SOP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 85. PAY-07 — Sahkan cooling period dua hari selepas tebusan: kiraan hari, skop pelanggan/rangkaian, cuti, override dan transaksi pada saat boundary.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Product + Risk; Cooling-period rule + cases.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 86. PAY-08 — Jika operator koperasi, sahkan gadaian semula, kadar keuntungan perlu dijelaskan, pelarasan baki kepada pembiayaan baharu dan Ibra’ wajib penyelesaian awal seperti Arahan SKM 3/2026; selaraskan dengan cooling period SRS.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Shariah + Finance + Product; Shariah/legal ruling + refinance/redemption examples.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 87. CASH-01 — Takrif float: sumber bank, request, approve, issue, teller acknowledge, top-up, return dan carry-forward harian/mingguan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Finance Operations; Cash SOP + current forms.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 88. CASH-02 — Petakan cash-in/out hanya bagi tunai fizikal; asingkan kad/FPX/e-wallet/transfer sebagai clearing/settlement bukan drawer cash.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Finance; Channel accounting map.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 89. CASH-03 — Sahkan expected cash = opening + cash-in − cash-out ± approved movements; denomination count, recount, variance reason dan threshold approval.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Finance + Branch Ops; Balancing worksheet dan variance policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 90. CASH-04 — Takrif Tutup Hari: checklist, pending blockers, close sequence teller/cawangan, lock, late settlement, reopen dan audit.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Finance Controller; Day-end SOP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 91. CASH-05 — Takrif void/adjustment: reason code, evidence, maker-checker, time limit, posting/reversal dan customer receipt impact.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Finance + Risk; Void/adjustment policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 92. CASH-06 — Takrif bank-in: preparation, cash in transit, slip upload, bank confirmation, partial/rejected deposit dan reconciliation statement.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Treasury; Bank-in SOP + bank statement sample.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 93. CASH-07 — Takrif cheque jika ada, petty cash, expenses, inter-drawer/inter-branch transfer, counterfeit/suspect cash dan emergency evacuation.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Finance + Security; Complete cash movement catalog.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 94. CASH-08 — Sahkan dashboard HO real-time, had cash on-hand/takaful, alert, acknowledgement, escalation dan data freshness.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Risk + Franchisor Ops; Monitoring requirement + limits.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 95. LED-01 — Pilih sama ada sistem ini sublejar atau general ledger; tetapkan chart of accounts per francaisi/cawangan dan ownership jurnal.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** CFO/Financial Controller; COA, accounting architecture dan sample TB.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 96. LED-02 — Luluskan journal rule bagi gadaian/payout, KK accrual/receipt, fi/caj, ansuran principal, tebusan, royalti, iklan, lelongan, surplus/shortfall, float, bank-in, fee provider, refund, void dan impairment.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Finance; Signed event-to-journal matrix.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 97. LED-03 — Takrif accrual versus cash recognition, cutoff, posting date/business date/value date, period lock dan prior-period adjustment.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Finance; Accounting policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 98. LED-04 — Sahkan e-Invois/MyInvois applicability per entiti/transaksi berdasarkan turnover dan garis panduan HASiL semasa; tentukan consolidated, individual, self-billed, rejection/cancellation dan QR/UUID.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Tax + Finance IT; Tax opinion + latest MyInvois guideline/SDK contract.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 99. LED-05 — Takrif integrasi SQL/MYOB/sistem akaun: master mapping, batch/API, frequency, retry, duplicate prevention, error queue dan reprocessing.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Finance IT; Target system interface spec + sample files.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 100. LED-06 — Takrif bank/payment settlement dan fee reconciliation per provider, merchant, batch, value date, chargeback dan missing settlement.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Treasury; Statements, settlement reports dan matching rules.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 101. LED-07 — Sahkan tax treatment SST/other taxes, withholding dan intercompany/franchise billing; jangan bina kadar tanpa tax sign-off.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G4`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Tax Advisor; Tax memo dan invoice samples.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 102. VLT-01 — Takrif hierarki lokasi fizikal: cawangan, vault/safe, zon, rak, bekas/packet; capacity, restricted zones dan relokasi.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G5`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Vault Manager; Vault layout dan location register.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 103. VLT-02 — Takrif movement types: receive, put-away, retrieve, inspect, revalue, transfer, auction, release, return; from/to, reason, dual acknowledgement dan time limit.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G5`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Vault + Risk; Movement SOP + custody forms.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 104. VLT-03 — Sahkan dual control bagi vault entry, seal breaking, release dan high-value items; larang maker yang sama apabila polisi memerlukan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G5`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Security + Vault; Physical security/SoD policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 105. VLT-04 — Takrif stocktake full/cycle/random, scan method, freeze window, found/missing/extra/damaged, recount dan approval variance.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G5`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Internal Audit + Vault; Stocktake SOP + historical report.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 106. VLT-05 — Takrif transfer antara cawangan/auction venue: packing, manifest, courier/security, cash-in-transit equivalent, insurance dan acceptance.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G5`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Risk + Logistics; Transfer and insurance policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 107. VLT-06 — Takrif lost/damaged/tampered seal, robbery/fire/flood, police/takaful report, customer remediation dan legal hold.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G5`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Risk + Legal; Incident/claims SOP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 108. VLT-07 — Tentukan label/barcode/QR, printer/scanner, data pada label, reprint control dan pemisahan PII daripada visual umum.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G5`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Vault + Security; Label design + hardware test.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 109. AUC-01 — Sahkan trigger: tiada bayaran KK selepas 6 bulan atau tamat 10 bulan; grace period, payment pending, dispute, deceased, moratorium dan holiday handling.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Operations + Legal + Shariah; Delinquency/auction policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 110. AUC-02 — Takrif state Aktif → Tertunggak → Sedia Lelong → Dilelong termasuk review, approval, withdrawal, sold, unsold, cancelled dan relist.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Auction Owner; Auction state machine.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 111. AUC-03 — Sahkan kandungan, channel, lead time dan proof-of-delivery bagi notis sebelum 6/10 bulan, lucut hak dan lelongan; failed delivery/escalation.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal + Customer Comms; Legal-approved notice matrix/templates.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 112. AUC-04 — Luluskan reserve/base price, caj lelong, upah simpan/KK/fi, bid rules, tax, auctioneer fee, sold price dan settlement waterfall.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Shariah + Legal; Signed auction calculation examples.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 113. AUC-05 — Takrif bayaran lebihan ke akaun pelanggan: validation, payer entity, failed transfer, notification, claim by heir dan unclaimed-money treatment.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Legal; Surplus SOP + legal opinion.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 114. AUC-06 — Takrif shortfall: adakah pelanggan dituntut, waived, impaired atau ditanggung entiti; collection conduct dan jurnal.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Legal; Credit loss/collection policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 115. AUC-07 — Takrif lot/batch, auction venue/provider, bidder/KYC, bid capture/import, deposit, payment deadline, title transfer dan reconciliation.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Auction + Procurement; Auctioneer contract/interface spec.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 116. AUC-08 — Takrif dispute/late redemption/withdrawal selepas list, cut-off, fee liability dan approval.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal + Auction Owner; Exception policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 117. AUC-09 — Jika operator koperasi, petakan Arahan SKM 3/2026: notis bertulis, dua minggu selepas notis, kaedah lelong awam/e-lelong/tender, rekod bida boleh diaudit, konflik kepentingan, hak semak rekod, defisit dan surplus. Selesaikan tempoh surplus SKM sekurang-kurangnya satu tahun berbanding aturan Akta 370/JANM yang berkenaan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G3`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal + SKM Compliance + Finance; Auction/WTD legal opinion + SOP + regulator clarification jika perlu.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 118. DOC-01 — Serahkan template rasmi SAG, Akuan KK, Wakalah, Notis Jual-Beli Komoditi, Borang Pembiayaan, resit, Borang Penebusan, notis, maklumat lelongan dan surat lebihan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Legal + Operations; Fail Word/PDF asal + sample completed.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 119. DOC-02 — Sahkan jenis tandatangan/acknowledgement: wet, electronic, digital signature, OTP, biometric atau checkbox; saksi, timestamp dan evidence.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Legal + Shariah; Legal opinion + signing policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 120. DOC-03 — Takrif numbering, template version/effective date, data snapshot, locale, QR/barcode dan hash jika perlu.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Records Manager; Document control standard.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 121. DOC-04 — Takrif print/reprint: reason, watermark SALINAN, copy count, device failure, queued print dan customer preference digital/paper.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Operations + Legal; Print/reprint SOP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 122. DOC-05 — Takrif storage, format archival, encryption, retention/legal hold, access, export dan disposal setiap document class.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Records + DPO + Legal; Records retention schedule.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 123. DOC-06 — Sahkan dokumen yang dihantar melalui e-mel/SMS/link, access expiry, authentication dan redaction/masking.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Security + Customer Comms; Secure delivery policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 124. NOT-01 — Sahkan event dan timing: notis 14 hari sebelum tamat 6 bulan, 14 hari sebelum 10 bulan, payment, extension, overdue, auction, surplus dan system alerts.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Operations + Legal; Notification matrix.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 125. NOT-02 — Luluskan kandungan BM/English, terminology Shariah/legal, PII masking, contact/support dan template version.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Legal + Shariah + Brand; Approved message templates.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 126. NOT-03 — Pilih SMS/e-mel/WhatsApp provider dan tentukan transactional versus marketing, opt-in/out, sender ID, quiet hours dan fallback.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Customer Comms + DPO; Provider contract + consent policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 127. NOT-04 — Takrif queued/sent/delivered/failed/bounced/read jika ada, retry/backoff, duplicate suppression dan manual resend.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Technology + Operations; Delivery state model + webhooks.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 128. NOT-05 — Takrif bukti notis yang mencukupi untuk lelongan dan sengketa: payload, provider receipt, timestamp, destination masked dan template version.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Legal; Legal evidence requirement.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 129. INT-01 — Inventori provider sebenar bagi BISAS, harga emas, IRIS/MyKad, payment/FPX/e-wallet, bank payout, SMS/WhatsApp, SMTP, accounting, CTOS/blacklist dan MyInvois.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G8`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Procurement + IT; Vendor list, owner, contract, environment dan contact.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 130. INT-02 — Per interface, lengkapkan auth, endpoints, schema, version, idempotency, timeout, retry, rate limit, signature, IP allowlist, certificates dan secrets rotation.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G8`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Integration Architect; OpenAPI/file spec/SDK dan security pack.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 131. INT-03 — Takrif business state bagi pending/fail/unknown/duplicate/late callback dan compensating action; jangan samakan timeout dengan gagal.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G8`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Product + Architecture; Sequence diagrams + error catalog.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 132. INT-04 — Takrif reconciliation source, frequency, expected latency, cutoff, unmatched queue, manual resolution dan reprocessing.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G8`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Finance + Operations; Reconciliation design + sample reports.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 133. INT-05 — Takrif SLA, maintenance windows, incident notification, data residency/subprocessors, liability, exit/data export dan DR setiap vendor.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G8`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Legal + Procurement + Security; DPA/SLA/contract schedules.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 134. INT-06 — Lengkapkan hardware compatibility bagi reader IRIS, scanner, printer multifungsi/resit, labeler, timbang dan kamera; driver, OS, browser, spooler, health check.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G8`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** IT Operations; Hardware model/driver matrix.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 135. INT-07 — Wujudkan integration observability: correlation ID, latency, success rate, queues, synthetic checks, alert owner dan runbook.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G8`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** SRE/IT Ops; Dashboard/runbook design.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 136. REP-01 — Katalogkan laporan transaksi harian, status marhun, kewangan cawangan/konsolidasi, teller, cash position dan dashboard prestasi; serahkan contoh expected output.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Operations + Finance; Report catalog + sample files.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 137. REP-02 — Takrif metric/semantic dictionary untuk gadaian, pembiayaan, tebusan, hasil, KK, overdue, marhun, cash dan variance.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Data Owner + Finance; KPI/data dictionary.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 138. REP-03 — Sahkan export PDF/Excel/CSV, row limits, async generation, password/encryption, masking, watermark, retention dan audit download.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Security + Data Owner; Export security policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 139. REP-04 — Takrif real-time versus T+1, data freshness label, timezone/business date, late corrections dan restatement.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Finance + Data; Reporting SLA.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 140. REP-05 — Takrif schedule/delivery, recipient groups, secure links, failed jobs dan distribution revocation.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G10`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Operations + Security; Distribution matrix.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 141. REP-06 — Takrif drill-down, comparison cawangan, targets, alert thresholds dan accessibility bagi dashboard.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G10`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Product + UX; Dashboard wireframe/KPI acceptance.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 142. ADM-01 — Senaraikan konfigurasi pusat: kadar, had, mutu/harga, approval, notis, polisi, status cawangan dan integrasi; tentukan owner dan scope inheritance.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G1`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Product Owner + Finance; Master/config catalog.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 143. ADM-02 — Takrif maker-checker, future effective date, preview impak, rollback dan larangan backdate bagi config kewangan/Shariah.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Risk + Shariah + Finance; Configuration change policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 144. ADM-03 — Takrif reference data: reason codes, item types, relationship, bank, channel, branch calendar, currency, language dan status.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Data Steward; Reference data dictionary.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 145. ADM-04 — Takrif bulk upload, validation preview, duplicate detection, approval dan error report.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G1`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Operations Admin; Bulk admin SOP + templates.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 146. ADM-05 — Paparkan audit compare sebelum/selepas, siapa/masa/sebab/approver dan link change request.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G1`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Security + Product; Audit sample.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 147. ADM-06 — Takrif lifecycle bersama bagi case/task/hold/exception yang digunakan untuk dispute, fraud, privacy request, unmatched reconciliation, integration failure dan pembetulan: category, state, priority, owner, SLA, evidence, escalation, resolution dan reopen.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G1`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Product + Operations + Risk; Cross-domain case model + state diagram + queue/RACI.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 148. DATA-01 — Sahkan entiti dan hubungan: organisasi, user, customer/heir, pledge, item, valuation, calculation snapshot, akad, payment, cash drawer, journal, vault movement, auction, document, notification, approval dan audit.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Data Architect + Domain Owners; Conceptual/logical data model.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 149. DATA-02 — Lengkapkan data dictionary: nama, definisi, type, precision, required, validation, classification, owner, lineage, retention dan masking.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Data Owner/DPO; Approved data dictionary.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 150. DATA-03 — Inventori sistem/fail legacy, volume, quality, keys, attachment, history, duplicates, unknown values dan data yang tidak patut dimigrasi.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Data Migration Lead; Source inventory + profiling report.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 151. DATA-04 — Takrif reconciliation migrasi: row/count/amount/hash, sampling dokumen, opening balances, cutover freeze, delta load, rollback dan sign-off.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Data; Migration strategy + reconciliation workbook.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 152. DATA-05 — Takrif data quality rules dan owner bagi invalid IC, duplicate customer, orphan pledge/item/payment, missing document dan inconsistent status.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Data Steward + Operations; DQ rules + remediation backlog.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 153. DATA-06 — Tetapkan retention per record class, legal hold, archival access, anonymisation/deletion dan backup expiry; selaraskan PDPA, cukai, audit dan undang-undang berkaitan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Records + DPO + Legal; Legal-approved retention schedule.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 154. DATA-07 — Takrif data residency, cross-border transfer, processor/subprocessor, encryption key location dan export controls.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** DPO + Security; Data flow map/DPIA/vendor register.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 155. PRV-01 — Kenal pasti pengawal/pemproses data bagi YSV, francaisi dan vendor; tujuan serta legal basis setiap aktiviti pemprosesan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** DPO/Legal; Data processing inventory/ROPA + legal opinion.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 156. PRV-02 — Tentukan sama ada ambang pelantikan DPO dipenuhi (termasuk data sensitif/kewangan dan pemantauan sistematik) serta proses pendaftaran/komunikasi.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Management + DPO; DPO assessment dan appointment evidence.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 157. PRV-03 — Takrif data breach detection, triage, register, assessment, notification regulator/subjek, evidence dan latihan mengikut garis panduan semasa.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** DPO + Security; Incident/DBN plan dan breach form.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 158. PRV-04 — Laksanakan privacy by design/DPIA untuk MyKad, dokumen ID, data kewangan, blacklist, biometrik jika ada, monitoring dan integrasi vendor.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** DPO + Product; DPIA + remediation register.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 159. PRV-05 — Takrif data subject request: akses, correction, withdrawal/objection dan lain-lain hak terpakai; identity proof, SLA dan exception.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** DPO + Customer Service; DSR SOP/templates.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 160. PRV-06 — Takrif minimisation, masking, screen privacy, non-production data, analytics, log redaction dan secure disposal.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G6`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** DPO + Security; Privacy control matrix.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 161. SEC-01 — Luluskan klasifikasi data/aset, threat model dan risk assessment termasuk account takeover, insider fraud, duplicate payout, tenant leakage, price manipulation dan vault release.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** CISO/Risk; Threat model/risk register.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 162. SEC-02 — Tetapkan encryption in transit/at rest, key management/rotation, secrets vault, certificate lifecycle dan larangan secrets dalam kod/log.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Security Architecture; Cryptography/secrets standard.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 163. SEC-03 — Takrif immutable audit events: auth, view sensitive data, create/update/approve, formula/config, payment, cash, vault, document, export dan admin/support.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Security + Internal Audit; Audit event catalog.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 164. SEC-04 — Takrif fraud rules/alerts: velocity, duplicate identity/account, unusual override, after-hours, split transactions, repeated variance, failed auth dan suspicious auction.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Fraud/Risk; Fraud typology/rules + case workflow.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 165. SEC-05 — Tetapkan secure SDLC: code review, dependency/SAST/secret scanning, DAST, penetration test, vulnerability SLA dan release gate.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Engineering + Security; Secure SDLC policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 166. SEC-06 — Takrif workstation/device security, patching, EDR, browser policy, USB/print/download, session privacy dan physical screen controls.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** IT Security; Endpoint standard.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 167. SEC-07 — Tetapkan incident severity, 24×7 contact, containment, forensic preservation, regulator/customer decision, recovery dan post-incident review.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** CISO + DPO; Incident response plan/runbooks.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 168. SEC-08 — Tentukan sama ada organisasi/sistem ialah NCII atau tertakluk keperluan Cyber Security Act 2024; jika tidak, dokumentasikan rationale dan controls baseline.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G7`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal + CISO; Legal/regulatory applicability assessment.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 169. NFR-01 — Sahkan bilangan francaisi/cawangan, pengguna/teller serentak, pelanggan, gadaian/hari, items/pledge, payments, documents, attachment sizes dan pertumbuhan 5 tahun.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Business + Architecture; Volume forecast dan peak profile.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 170. NFR-02 — Tetapkan p95/p99 response time bagi search, quote, save, approval, payment, print dan dashboard; masa job batch/report.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Product + Architecture; Performance SLO table.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 171. NFR-03 — Tetapkan availability per channel/jam operasi, planned maintenance, error budget dan degraded-mode expectations.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Business + IT Ops; Availability/SLA policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 172. NFR-04 — Tetapkan RTO/RPO per service/data, backup frequency, restore point, regional/site failure dan manual BCP.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Business Continuity + IT; Business impact analysis + DR targets.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 173. NFR-05 — Sasaran WCAG 2.2 AA, keyboard, focus, error text, contrast, zoom, screen reader dan touch target 44×44; tentukan pengecualian.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Product + UX; Accessibility acceptance checklist.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 174. NFR-06 — Sahkan desktop/tablet/mobile scope, OS/browser versions, resolutions, printer/reader support dan lifecycle support.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** IT + Product; Compatibility matrix.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 175. NFR-07 — Tetapkan scalability, data query/export limits, archival, maintainability, deployment frequency, rollback time dan test coverage targets.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** CTO/Engineering; Engineering quality SLO.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 176. NFR-08 — Takrif audit/log retention, clock synchronization, observability latency dan support diagnostic access.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** SRE + Security; Logging/observability standard.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 177. ARC-01 — Luluskan architecture principles: ledger-first, immutable audit, transactional consistency, idempotency, least privilege, tenant isolation dan external-provider resilience.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Architecture Board; Architecture decision record (ADR) set.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 178. ARC-02 — Pilih hosting/cloud/on-prem, region/data residency, managed services, network connectivity cawangan, HA topology dan procurement constraint.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** CTO + Procurement + Security; Target architecture + TCO/risk decision.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 179. ARC-03 — Takrif tenant isolation pada database/query/storage/cache/search/report/export; row-level policy dan defence in depth.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Architecture + Security; Tenant security design.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 180. ARC-04 — Takrif environments dev/test/UAT/performance/staging/production, data policy, access, parity, refresh dan separation of duties.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Platform Engineering; Environment strategy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 181. ARC-05 — Takrif CI/CD, infrastructure as code, artifact signing, approvals, DB migration, feature flags, canary/rollback dan evidence release.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Engineering + DevOps; Deployment/release architecture.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 182. ARC-06 — Takrif transaction boundaries/outbox/queues bagi payment, BISAS, notification, documents dan accounting; retry/idempotency.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Solution Architect; Sequence/consistency ADRs.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 183. ARC-07 — Takrif observability stack, metrics/logs/traces, dashboards, synthetic probes, alert routing dan cost retention.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** SRE; Observability design.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 184. BCP-01 — Lengkapkan BIA bagi fungsi gadaian, tebusan/release, cash close, vault, lelongan, notification dan reporting; maximum tolerable outage.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `UAT`
- **Owner/bukti yang akan dikejar:** Business Continuity; BIA yang diluluskan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 185. BCP-02 — Takrif backup database/object/document/config/secrets, frequency, immutability, encryption, retention, offsite dan monitoring.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `UAT`
- **Owner/bukti yang akan dikejar:** IT Operations + Security; Backup design/policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 186. BCP-03 — Takrif failover/failback dan reconciliation transaksi in-flight/provider callbacks; ownership go/no-go.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `UAT`
- **Owner/bukti yang akan dikejar:** Incident Commander + Architecture; DR runbook.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 187. BCP-04 — Takrif manual/degraded branch pack: numbering, paper forms, limits, approval, custody, cash dan safe data entry selepas recovery.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `UAT`
- **Owner/bukti yang akan dikejar:** Operations + Risk; Branch BCP pack.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 188. BCP-05 — Tetapkan drill cadence, scenario, observer, evidence, issue remediation dan audit reporting.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `UAT`
- **Owner/bukti yang akan dikejar:** Business Continuity; Annual test plan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 189. SUP-01 — Pilih model L1/L2/L3, waktu sokongan, bahasa, saluran, on-call dan owner bagi app, infra, integrasi, device, data dan vendor.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** IT Service Owner; Support operating model/RACI.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 190. SUP-02 — Takrif severity berdasarkan pelanggan, wang, vault, cawangan, privacy/security dan regulatory impact; response/restore/update SLA.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Business + IT Ops; Incident severity/SLA matrix.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 191. SUP-03 — Takrif service request seperti user access, branch/config, reprint, data correction dan report; approval serta audit.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Service Owner; Service catalog.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 192. SUP-04 — Takrif problem management, root cause, known error, post-incident review dan backlog prevention.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** IT Operations; Problem/PIR template.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 193. SUP-05 — Tetapkan monitoring ownership, alert noise, maintenance, certificate/secret renewal, capacity dan patch cadence.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** SRE/Platform; Operations calendar/runbooks.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 194. SUP-06 — Takrif IP/source code ownership, licences, escrow jika perlu, data export, documentation handover, vendor transition dan deletion certificate.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G9`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Legal + Procurement + CTO; Contract/exit plan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 195. TST-01 — Bina traceability SRS/decision → requirement → design/API/data → test → evidence → approval; tentukan tool dan owner.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G11`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** BA Lead + QA; Requirements traceability matrix.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 196. TST-02 — Luluskan golden cases untuk semua formula, journal dan state transition termasuk boundary time, rounding, partial/reversal dan concurrency. Pisahkan gate: (1) sebelum build—input/expected result ditandatangani bebas daripada kod; (2) semasa build—cases diautomasi; (3) sebelum release—100% automated tests lulus.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G11`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Finance + Shariah + QA; Signed golden dataset/expected outputs + automated regression report.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 197. TST-03 — Takrif test levels: unit/property, component, integration/contract, end-to-end, migration, security, performance, accessibility, DR dan operational rehearsal.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G11`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** QA Lead; Master test plan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 198. TST-04 — Takrif UAT persona/site/scenario, data, training, evidence, defect severity, retest, waiver dan sign-off.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G11`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Business Test Lead; UAT plan/scripts/sign-off.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 199. TST-05 — Takrif provider/device certification dan negative scenarios: timeout, duplicate callback, stale price, reader/printer fail, offline/reconnect.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G11`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Integration QA + IT Ops; Certification matrix.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 200. TST-06 — Takrif test data privacy, synthetic/masked data, refresh, account/access dan cleanup.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G11`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** QA + DPO; Test data management plan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 201. TST-07 — Tetapkan defect severity/priority, triage SLA, go-live threshold, accepted-risk authority dan regression scope.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G11`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** QA + Product Owner; Defect management policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 202. CHG-01 — Inventori SOP yang perlu dicipta/ubah bagi KYC, valuation, pledge, cash, vault, auction, close, incident, privacy dan support.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G11`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Operations Excellence; SOP register dengan owner/version.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 203. CHG-02 — Takrif audience dan competency: teller, executive, manager, supervisor, HO admin, finance, vault, auction, auditor dan support.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G11`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Training Lead; Training needs analysis.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 204. CHG-03 — Sediakan train-the-trainer, quick reference, video/demo, sandbox, assessment, attendance dan refresher.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G11`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Training + Product; Training pack/certification record.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 205. CHG-04 — Pilih 1–3 cawangan pilot mengikut profil volume/network/staff/device; duration, scope, parallel run dan success/stop criteria.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G11`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Steering Committee; Pilot charter.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 206. CHG-05 — Pilot exit minimum: 100% golden tests; tiada Critical/High security; dua Tutup Hari seimbang; provider reconciliation 100%; tiada item vault tanpa lokasi; restore drill dan UAT sign-off.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G11`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Sponsor + Domain Owners; Pilot evidence pack.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 207. CHG-06 — Takrif rollout waves, readiness per cawangan, data cutover, onsite/remote support, freeze, hypercare, KPIs dan rollback.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G11`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Deployment Lead; Rollout playbook.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 208. CHG-07 — Takrif komunikasi pelanggan/staf, perubahan dokumen/terma, channel bantuan dan complaint escalation.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G11`; **Decision-by:** `PILOT`
- **Owner/bukti yang akan dikejar:** Change + Legal; Communication plan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 209. REG-01 — Sahkan lesen, syarat operasi, rekod/laporan, resit, notis, tempoh, lelongan dan pemeriksaan di bawah Akta Pemegang Pajak Gadai 1972 [Akta 81] serta peraturan/garis panduan KPKT yang terpakai kepada model ARYP.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS + RUJUKAN SEMASA`; **Gate:** `G12`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal/Compliance; Legal opinion + licence conditions + compliance obligations register.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 210. REG-02 — Sahkan badan/standard yang benar-benar mempunyai bidang kuasa (KPKT, BNM, SKM, KUSKOP atau lain-lain) berdasarkan entiti, lesen dan produk; dokumentasi jika tidak terpakai.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G12`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** General Counsel; Regulatory perimeter memo.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 211. REG-03 — Nilai pemakaian Akta Kredit Pengguna 2025 [Akta 873] dan piawaian kelakuan/authorisation kepada YSV/francaisi/pajak gadai atau penyedia servis berkaitan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G12`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal/Compliance; Legal opinion terkini.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 212. REG-04 — Nilai status reporting institution dan skop AML/CFT/CPF/TFS; jika terpakai, tentukan CDD, screening, record, suspicious transaction, governance dan confidentiality.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G12`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Compliance/MLRO; AML legal assessment + approved policy.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 213. REG-05 — Sahkan PDPA 2010/pindaan 2024, pendaftaran kelas pengawal data, DPO, breach, processor, cross-border, rights dan security obligations.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G12`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** DPO + Legal; PDPA compliance assessment/ROPA/DPIA.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 214. REG-06 — Sahkan keperluan HASiL e-Invois/MyInvois mengikut entiti, turnover, transaksi, tempoh peralihan dan SDK/guideline versi semasa.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G12`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Tax; Tax opinion + registration/integration plan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 215. REG-07 — Sahkan treatment lebihan lelongan tidak dituntut di bawah Akta Wang Tak Dituntut 1965 [Akta 370]: bila payable, aging, register, notice, submission dan claim evidence.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G12`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Finance + Legal; Legal/Finance opinion + WTD SOP.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 216. REG-08 — Sahkan kebolehterimaan rekod/tandatangan elektronik/digital, evidence dan retention di bawah undang-undang berkaitan serta syarat dokumen pajak gadai.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G12`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal; Legal opinion + signature/evidence standard.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 217. REG-09 — Nilai pemakaian Akta Keselamatan Siber 2024 [Akta 854]/NCII dan lain-lain kewajipan pelaporan insiden sektor; dokumentasikan rationale.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G12`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** CISO + Legal; Cyber regulatory assessment.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 218. REG-10 — Sahkan statutory/audit/tax/contract retention dan limitation periods; selesaikan konflik dengan minimisation/deletion.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G12`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Legal + Tax + DPO; Approved retention matrix.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 219. REG-11 — Bagi setiap operator koperasi, nilai Arahan Aktiviti Pajak Gadai Islam (Ar-Rahnu) SKM Bil. 3/2026 yang berkuat kuasa 1 Ogos 2026: kelulusan aktiviti/cawangan/kontrak, operator sendiri, KWA dan mudah tunai, latihan/peralatan, takaful, eligibility, had/kadar/tempoh, tiada fi/caj, Ibra’, gadaian semula, lelongan, aduan, jawatankuasa, audit/risk dan laporan suku tahunan.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—KONFLIK MATERIAL`; **Gate:** `G12`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Board + SKM Compliance + Legal + Shariah; Signed obligation-to-control matrix + licence/approval + gap plan.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 220. REG-12 — Sahkan duti setem instrumen demi instrumen dan keperluan Sistem Taksir Sendiri Duti Setem (STSDS) yang bermula berfasa pada 1 Januari 2026, termasuk TIN, taksiran, pembayaran, sijil dan rekod tujuh tahun jika terpakai.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO; CLIENT SIGN-OFF BEFORE PRODUCTION`
- **Rasional:** Simulation-safe default sahaja; nilai rasmi, legal basis, threshold atau rulebook mesti diganti sebelum production.
- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`; **Gate:** `G12`; **Decision-by:** `DESIGN`
- **Owner/bukti yang akan dikejar:** Tax + Legal + Document Operations; Stamp-duty position paper + document matrix + STSDS process.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 221. EVD-01 — Sediakan semua polisi/rulebook yang ditandatangani: produk/Shariah, formula, payment, cash, vault, auction, access/SoD, privacy/security, accounting/tax dan retention.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G12`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** PMO + Domain Owners; Approved policy pack.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 222. EVD-02 — Sediakan semua dokumen/transaksi/laporan sebenar—template kosong dan sekurang-kurangnya satu contoh lengkap yang betul bagi setiap jenis.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `DARIPADA SRS`; **Gate:** `G12`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Operations + Finance + Legal; Document/report sample pack.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 223. EVD-03 — Sediakan kontrak/SDK/API/sample payload/test credentials bagi setiap provider dan peranti; license/SLA/DPA/contact.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G12`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Procurement + IT; Integration evidence pack.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 224. EVD-04 — Sediakan data statistik/legacy: volume, peak, branches/users, sample anonymised data, source schema, quality dan opening balances.

- **Keputusan pembangunan:** `AUTO-ASSUMED FOR DEMO`
- **Rasional:** Configurable, versioned dan synthetic; client boleh mengganti tanpa redesign.
- **Sumber:** `PERLU KEPUTUSAN`; **Gate:** `G12`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Data Owner + Finance; Data discovery pack.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 225. EVD-05 — Lengkapkan signed decision register, glossary, BPMN/state diagrams, role matrix, data dictionary, API specs, journal matrix, NFR sheet, test plan dan traceability matrix.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G12`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Product Owner + BA Lead; Build-ready requirements pack.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

### 226. EVD-06 — Tandatangani Build-Ready Certificate oleh Business, Operations, Finance, Shariah, Legal/Compliance, DPO/Security, Technology dan Product Owner.

- **Keputusan pembangunan:** `AUTO-ACCEPTED WORKING DEFAULT`
- **Rasional:** Cadangan implementasi reversible; boleh diubah melalui change control.
- **Sumber:** `CADANGAN KERJA`; **Gate:** `G12`; **Decision-by:** `BUILD`
- **Owner/bukti yang akan dikejar:** Sponsor; Signed certificate di akhir dokumen.
- **Nilai default:** configurable/versioned, synthetic, audit-able dan boleh di-rollback; jika tiada nilai selamat, status kekal `PENDING_CLIENT`.

## Batas keselamatan

Tiada assumption dalam dokumen ini memberikan kelulusan Shariah, undang-undang, regulatory, privacy, security, NFR atau go-live. Apabila Dokumen Penemuan dan Pemuktamadan client diterima, saya akan buat impact analysis dan menggantikan assumption secara berperingkat.
