# ARYP — Soalan Pemuktamadan Keperluan Client v0.1

**Tujuan:** satu borang keputusan untuk menggantikan assumption demo dengan polisi client yang diluluskan. Dokumen ini merangkumi semua item SRS yang masih memerlukan pengesahan, termasuk konflik, rujukan regulatori dan keperluan production.

> Cara jawab setiap item: tulis `SETUJU CADANGAN`, `UBAH: ...`, `TIDAK BERKENAAN`, atau `BLOCKED: ...`. Jika `UBAH`, nyatakan owner, bukti, tarikh kuat kuasa dan approver.

## Keputusan yang telah diberikan untuk assumption demo

- Model operasi: banyak cawangan, dengan tenant branch-scoped dan visibility franchisor yang dikawal.
- Role kerja sementara: BRANCH_MANAGER, TELLER, VAULT_CUSTODIAN, FRANCHISOR_SUPERVISOR, EXECUTIVE dan AUDITOR.
- Maker-checker diwajibkan; maker tidak boleh meluluskan transaksi sendiri.
- Staging menggunakan e-mel + kata laluan; MFA wajib sebelum production.
- Formula pembiayaan configurable dan versioned; formula demo bukan polisi muktamad.
- Bayaran, tunai, auction dan provider luaran kekal simulasi/mock.
- Customer fields synthetic dan configurable sehingga data model client diluluskan.
- Retention, privacy, regulatory dan NFR direkod sebagai configurable/PENDING_CLIENT.
- Hosting sementara: Cloudflare Workers + Supabase; residency/cross-border belum disahkan.
- Laluan release: staging → UAT/pilot → production selepas semua gate dan sign-off.

## Jawapan ringkas client

- Nama organisasi/entity pemilik keputusan: ______________________________
- Sponsor eksekutif: ______________________________
- Product Owner: ______________________________
- Tarikh sesi keputusan: ______________________________
- Versi keputusan yang diluluskan: ______________________________

## Senarai keputusan lengkap (203 item)

Setiap item di bawah perlu mempunyai jawapan, owner dan bukti. Requirement berlabel `DARIPADA SRS` masih perlu disahkan jika ia memberi kesan kepada formula, wang, marhun, privacy, regulatory atau production.

### GOV — Tadbir urus, kuasa keputusan dan kawalan perubahan

Gate: Gate GOV: RACI, kuasa keputusan, change control dan sumber dokumen rasmi telah diluluskan oleh sponsor.

#### 1. GOV-01 — Namakan sponsor eksekutif, Product Owner tunggal, pemilik Operasi, Kewangan, Shariah, Undang-undang/Compliance, Data, Keselamatan dan Teknologi. Tetapkan pengganti jika pemilik tiada.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Sponsor  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Surat pelantikan/RACI dan carta organisasi projek.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 2. GOV-02 — Takrif kuorum dan tahap kelulusan bagi polisi wang, formula, Shariah, akses, data, integrasi dan go-live. Nyatakan perkara yang memerlukan lembaga/jawatankuasa.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Sponsor + Setiausaha Projek  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Terms of Reference dan matriks kuasa keputusan.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 3. GOV-04 — Tetapkan proses change request selepas baseline: pencetus, analisis impak kos/jadual/data/ujian, badan kelulusan, versioning dan komunikasi cawangan.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** PMO/Product Owner  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Templat CR dan aliran change control.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 4. GOV-05 — Tetapkan tempat simpanan rasmi dokumen, konvensyen nama, pengelasan SULIT, kawalan akses, tempoh semakan dan rekod minit.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** PMO + Security  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Document management SOP.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### BUS — Hasil perniagaan, skop, pengecualian dan KPI

Gate: Gate BUS: scope baseline, KPI dan model nilai telah diluluskan; setiap pengecualian mempunyai owner dan risiko diterima.

#### 5. BUS-01 — Sahkan objektif: automasi end-to-end gadaian, pengiraan, rekod pelanggan, lelongan, teller/tunai, laporan dan pemantauan francaisor.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Sponsor + Product Owner  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Business case dan objective tree.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 6. BUS-02 — Takrif skop keluaran pertama, pilot dan rollout penuh. Nyatakan fungsi yang wajib sebelum wang/barang sebenar diproses.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Steering Committee  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Scope matrix Must/Should/Could/Won't.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 7. BUS-03 — Tetapkan KPI: masa pendaftaran/gadaian/tebusan, ketepatan kiraan, kadar rekonsiliasi, variance tunai, overdue, kehilangan marhun, delivery notis, uptime dan kepuasan pengguna.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Operations + Finance  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** KPI dictionary serta laporan semasa.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 8. BUS-04 — Nyatakan model hasil dan kos: KK, fi & caj, royalti, fi iklan, caj lelong, kos provider, franchise fee dan perakaunan antara entiti.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Finance + Commercial  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Model kewangan dan perjanjian francais berkaitan.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 9. BUS-05 — Senaraikan proses manual yang sengaja dikekalkan, pemilik, kawalan, tempoh dan trigger untuk automasi kemudian.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Operations  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Process inventory/as-is SOP.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### ORG — Model francaisor, francaisi, cawangan dan tenancy

Gate: Gate ORG: model tenant, pemilikan data dan kuasa konfigurasi disahkan melalui ujian akses silang tenant.

#### 10. ORG-01 — Sahkan hierarki: satu francaisor YSV, banyak francaisi dan satu/lebih cawangan bagi setiap francaisi. Sahkan sama ada entiti lain diperlukan.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Franchise Operations  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Senarai entiti undang-undang, francaisi dan cawangan.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 11. ORG-02 — Tentukan pemilik rekod pelanggan, transaksi, wang dan marhun; hak francaisor untuk melihat, mengeksport, membetulkan atau menahan data.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Legal + Data Owner  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Perjanjian francais + legal opinion.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 12. ORG-03 — Sahkan sempadan repeat customer, cooling period dan blacklist: seluruh rangkaian, francaisi atau cawangan; tentukan konflik dan perkongsian data.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Operations + Compliance  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Polisi pelanggan/risiko dan contoh kes.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 13. ORG-04 — Sahkan portal HO read-only pada transaksi cawangan versus kuasa konfigurasi pusat, emergency intervention dan pembetulan.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Franchisor Product Owner  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Role policy dan contoh konfigurasi pusat.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 14. ORG-05 — Takrif lifecycle francaisi/cawangan: onboarding, pertukaran pemilik, penggabungan, penggantungan, penamatan, archival dan akses selepas keluar rangkaian.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Franchise Ops + Legal  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Franchise lifecycle SOP.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 15. ORG-06 — Sahkan konfigurasi yang diwarisi dari HO dan yang boleh diubah francaisi/cawangan; tetapkan effective date dan precedence.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Product Owner  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Configuration authority matrix.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### OPS — Model operasi cawangan dan hari perniagaan

Gate: Gate OPS: day-in-the-life bagi sekurang-kurangnya teller, eksekutif dan pengurus lulus playback termasuk outage dan Tutup Hari.

#### 16. OPS-01 — Putuskan drawer berasingan bagi teller/kaunter/syif atau drawer kongsi; nyatakan handover dan dual count.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Branch Operations + Finance  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** SOP kaunter dan cash drawer semasa.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 17. OPS-02 — Tetapkan business date, waktu cut-off, zon masa, hujung minggu/cuti, transaksi selepas cut-off dan kuasa reopen Tutup Hari.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Operations + Finance  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** SOP operasi, jadual cawangan dan kalendar cuti.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 18. OPS-03 — Putuskan skop mod offline/degraded: view-only atau transaksi terhad; urutan nombor, limit, bukti, sync, konflik dan reconciliation.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Operations + Technology + Risk  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Risk assessment internet cawangan dan BCP.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 19. OPS-04 — Takrif pembukaan syif, float request/issue/acknowledge, pertukaran teller, rehat, tutup syif dan late close.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Branch Operations  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Swimlane SOP dan borang semasa.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 20. OPS-05 — Tetapkan had tunai/takaful per lokasi, trigger amaran, escalation, pengawal/pengangkutan wang dan bank-in kecemasan.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Risk + Finance  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Polisi tunai, takaful dan keselamatan fizikal.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 21. OPS-06 — Sahkan peralatan dan persekitaran setiap cawangan: workstation, tablet, MyKad/IRIS, printer A4/resit, scanner, kamera, label/barcode, network dan UPS.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** IT Operations  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Inventori aset/model/OS/driver dan site survey.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 22. OPS-07 — Tentukan bahasa UI/dokumen, aturan nombor/format tarikh, local holidays dan bantuan operasi bagi cawangan luar biasa.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Operations + Brand  
- **Gate / decision-by:** `G3` / `PILOT`  
- **Bukti minimum:** Brand/language guide dan daftar lokasi.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 23. OPS-08 — Sahkan cross-branch servicing: pendaftaran, ansuran, tebusan, pembetulan, complaint dan release di cawangan selain cawangan asal; tentukan pemilikan tunai, lejar dan marhun.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Operations + Finance + Vault  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Cross-branch policy + contoh kes.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### IAM — Pengguna, identiti, akses, had kuasa dan segregation of duties

Gate: Gate IAM: matriks role-permission-approval ditandatangani dan semua toxic combination mempunyai kawalan automatik atau mitigasi diterima.

#### 24. IAM-01 — Sahkan peranan Admin Francaisor, Penyelia Francaisi, Pengurus Cawangan, Eksekutif dan Teller; tambah Finance, Auditor, Vault Custodian, Auction dan Support jika perlu.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** HR + Operations + Security  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** Senarai jawatan dan tugas sebenar.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 25. IAM-02 — Selesaikan konflik Eksekutif boleh membuat, mengesah dan melulus transaksi. Tetapkan maker-checker dan larangan self-approval per tindakan.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Risk + Operations  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** SoD policy dan fraud scenarios.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 26. IAM-03 — Tetapkan threshold approval mengikut amaun, jenis transaksi, variance, void, harga manual, payout, lelongan dan tahap organisasi.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Finance + Operations  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** Delegation of authority terkini.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 27. IAM-04 — Pilih sumber identiti/SSO, MFA, password, session timeout, device trust, concurrent sessions dan lockout.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Security + IT  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** Identity architecture/policies.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 28. IAM-05 — Takrif joiner-mover-leaver, temporary access, delegation, recertification, dormant accounts dan emergency break-glass.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** HR + Security  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** IAM SOP dan HR feed design.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### CUS — Pelanggan, KYC, MyKad/IRIS, consent dan risiko

Gate: Gate CUS: data dictionary, KYC/fallback, dedupe, consent dan semakan risiko lulus ujian kes positif, negatif dan exception.

#### 29. CUS-01 — Sahkan medan wajib pelanggan, jenis pengenalan, warganegara/bukan warganegara, umur minimum, alamat, telefon, e-mel dan akaun bank.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Operations + Legal  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Borang pendaftaran dan data dictionary pelanggan.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 30. CUS-02 — Takrif kontrak IRIS/MyKad reader: data dibaca, consent, imej IC, fallback manual, mismatch, device failure dan rekod bukti.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** IT + Compliance  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Vendor API/SDK, licence dan SOP manual.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 31. CUS-03 — Tentukan matching/deduplication bagi No. IC, pasport, telefon dan pelanggan lama; aliran merge/unmerge serta maker-checker.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Data Owner  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Data sample, duplicate cases dan dedupe rules.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 32. CUS-04 — Sahkan blacklist dalaman/CTOS/sanctions jika berkenaan: sumber, kriteria, skop rangkaian, override, expiry, appeal dan adverse action notice.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Compliance + Risk  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Risk policy, legal basis dan provider contract.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 33. CUS-05 — Takrif consent/notis privasi per tujuan: transaksi, notifikasi, pemasaran, semakan pihak ketiga, biometrik/dokumen dan perkongsian francaisor-francaisi.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** DPO/Legal  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Approved privacy notices dan consent wording.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 34. CUS-06 — Takrif risk rating, enhanced due diligence, PEP/sanctions/AML jika terpakai, source of funds dan transaksi mencurigakan tanpa mendedahkan tipping-off.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Compliance Officer  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** AML/CFT applicability opinion dan policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 35. CUS-07 — Sahkan hak pembetulan data, akses rekod, deletion/restriction jika sah, deceased customer dan identity theft/dispute.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** DPO + Customer Service  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Data subject request SOP.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 36. CUS-08 — Sahkan eligibility mengikut jenis operator: umur minimum, keupayaan mental, anggota/bukan anggota, warganegara/bukan warganegara dan dokumen alternatif. Arahan SKM 3/2026 menetapkan minimum 18 tahun serta waras bagi koperasi.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** Legal + Compliance + Operations  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Eligibility policy + regulatory perimeter memo.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 37. CUS-09 — Takrif product disclosure, aduan, kesukaran kewangan/hardship, rayuan keputusan dan fair-conduct workflow yang dikehendaki regulator/lesen.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** Compliance + Customer Service  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Approved disclosure sheet, complaints/hardship SOP dan SLA.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### HEIR — Waris, wakil, kehilangan SAG, kematian dan pertikaian

Gate: Gate HEIR: semua jenis penuntut dan senarai dokumen disahkan Undang-undang; release test mencegah tuntutan berganda.

#### 38. HEIR-01 — Sahkan siapa boleh dinamakan sebagai waris: suami/isteri, anak ≥18, ibu, ayah atau adik-beradik; bilangan, keutamaan dan perubahan selepas gadaian.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Legal + Operations  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Polisi waris dan borang semasa.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 39. HEIR-02 — Takrif kuasa waris dinamakan vs wakil: lihat, bayar, tebus, menerima marhun atau menerima lebihan; adakah surat kuasa diperlukan.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Legal  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Legal opinion dan approved document checklist.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 40. HEIR-03 — Takrif aliran SAG hilang dan Surat Akuan Sumpah: identity checks, indemnity, approval, waiting period, reprint dan fraud hold.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Legal + Risk  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Templat akuan sumpah dan SOP.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 41. HEIR-04 — Takrif proses kematian/ketidakupayaan: dokumen pusaka, pentadbir, multiple claimants, court order, freeze dan komunikasi.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Legal + Customer Service  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Legal SOP dan sample documents.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 42. HEIR-05 — Takrif dispute/identity theft: status hold, barang tidak boleh bergerak, transaksi dibekukan, SLA siasatan dan escalation.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Risk + Legal  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Dispute management SOP.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### SHR — Struktur produk, akad dan tadbir urus Shariah

Gate: Gate SHR: product paper, akad sequence, glossary dan exception rulings ditandatangani pihak berkuasa Shariah.

#### 43. SHR-01 — Sahkan struktur kontrak sebenar dan istilah: rahn, pembiayaan, KK/ujrah, fi & caj, wakalah, jual-beli komoditi BISAS, royalti dan fi iklan.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Shariah Committee/Advisor  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Shariah product paper yang diluluskan.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 44. SHR-02 — Takrif sequence akad dan syarat sah sebelum payout; tindakan jika BISAS/akad/dokumen gagal atau selesai tidak mengikut urutan.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Shariah + Product Owner  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Shariah process flow + BISAS rules.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 45. SHR-03 — Sahkan nomenklatur pada UI, resit, SAG dan lejar—termasuk konflik istilah KK, ujrah/upah simpan dan fi.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Shariah + Legal + Brand  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Approved glossary dan wording.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 46. SHR-04 — Sahkan bagaimana pembetulan, reversal, void, refund, waiver, late event dan auction shortfall/lebihan diperlakukan dari sudut Shariah.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Shariah Committee  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Shariah exception rulings dan examples.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 47. SHR-05 — Takrif version/effective-date bagi polisi Shariah dan kesan kepada kontrak sedia ada apabila kadar atau struktur berubah.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Shariah Secretariat  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Shariah governance/change policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### VAL — Harga emas, mutu, penilaian dan item marhun

Gate: Gate VAL: price feed, taxonomy, precision dan valuation golden cases ditandatangani serta diuji pada peralatan sebenar.

#### 48. VAL-01 — Sahkan sumber Harga Emas YAPEIM mengikut mutu, unit RM/gram, jadual mutu yang dibenarkan, masa efektif dan pihak yang menerbitkan.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Product + Finance  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Price feed specification dan sample payload/history.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 49. VAL-02 — Takrif stale-price threshold, cache, fallback manual, second approval, sebab override dan larangan backdate.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Risk + Operations  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Price outage/override policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 50. VAL-03 — Sahkan formula NM = harga mengikut mutu × berat; precision harga/berat/NM, treatment batu/aksesori, berat kasar/bersih dan multi-item.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Valuation Lead + Finance  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Valuation rulebook + weighing examples.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 51. VAL-04 — Takrif kategori barang, deskripsi, gambar, tanda khas, bilangan, seal/tag/barcode, keadaan dan risiko barang palsu/berongga.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Valuation + Vault  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Marhun taxonomy dan sample photos/forms.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 52. VAL-05 — Sahkan alat timbang, resolusi, kalibrasi, certificate expiry, device integration dan fallback entry manual.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Operations + Quality  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Equipment register + calibration SOP.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 53. VAL-06 — Takrif revaluation, correction sebelum/selepas akad, maker-checker, dispute pelanggan dan cap nilai/berat luar biasa.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Risk + Valuation  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Exception policy dan approval limits.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### CALC — Buku peraturan pengiraan dan golden test

Gate: Gate CALC: semua P0 ditandatangani Finance dan Shariah; sebelum build, 100% input serta expected results golden cases diluluskan bebas daripada kod. Automasi dan keputusan pass ialah gate semasa build/release.

#### 54. CALC-01 — Betulkan jadual pembulatan: SRS menyatakan RM0.08–RM0.09 → RM1.00. Sahkan sama ada sepatutnya RM0.10 dan sama ada pembiayaan sentiasa dibulat turun ke 5 sen.

- **Sumber:** `DARIPADA SRS—KONFLIK`  
- **Pemilik dicadangkan:** Finance + Shariah  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Arahan polisi bertandatangan + contoh 0.00 hingga 0.99.  
- **Cadangan kerja:** Wajib pilih satu tafsiran rasmi; jangan hard-code sehingga contoh golden dan owner meluluskan.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 55. CALC-02 — Sahkan denominator Fi & Caj bagi 10 bulan; contoh SRS menggunakan 234 hari walaupun tempoh 6+4 bulan. Pilih hari tetap, actual calendar days atau kaedah lain.

- **Sumber:** `DARIPADA SRS—KONFLIK`  
- **Pemilik dicadangkan:** Finance + Shariah  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Calculation policy + contoh leap year/month-end.  
- **Cadangan kerja:** Wajib pilih satu tafsiran rasmi; jangan hard-code sehingga contoh golden dan owner meluluskan.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 56. CALC-03 — Sahkan KK minimum 15 hari sebagai max(hari sebenar,15) atau kaedah lain; formula SRS menulis tolak caj minimum.

- **Sumber:** `DARIPADA SRS—KONFLIK`  
- **Pemilik dicadangkan:** Finance + Shariah  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Approved formula dan contoh tebus hari 0,1,14,15,16.  
- **Cadangan kerja:** Wajib pilih satu tafsiran rasmi; jangan hard-code sehingga contoh golden dan owner meluluskan.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 57. CALC-04 — Sahkan precision dan titik pembulatan KK: simpan nilai harian berprecision tinggi lalu bulat total, atau bulat RM0.90 sehari sebelum darab.

- **Sumber:** `DARIPADA SRS—KONFLIK`  
- **Pemilik dicadangkan:** Finance  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Precision/rounding standard dan reconciliation examples.  
- **Cadangan kerja:** Wajib pilih satu tafsiran rasmi; jangan hard-code sehingga contoh golden dan owner meluluskan.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 58. CALC-05 — Sahkan payment waterfall ansuran: KK, fi/caj, principal, royalti/iklan atau urutan lain; partial/overpayment dan baki prinsipal bagi KK seterusnya.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Finance + Shariah  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Approved waterfall dan contoh multiple instalments.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 59. CALC-06 — Sahkan syarat auto-lanjut selepas 6 bulan: jumlah KK yang mesti dibayar, tarikh akhir, grace period, partial payment, reversal dan notis kegagalan.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Operations + Shariah  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Extension rule + boundary cases.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 60. CALC-07 — Tafsir ‘Bilangan Sambungan Dibenar: Tiada’ dan ‘Nilai Pinjaman Baru: Tiada’: tiada sambungan, tanpa had, atau tebus dahulu + cooling period 2 hari.

- **Sumber:** `DARIPADA SRS—AMBIGU`  
- **Pemilik dicadangkan:** Product Owner + Shariah  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Product ruling dan lifecycle diagram.  
- **Cadangan kerja:** Wajib pilih satu tafsiran rasmi; jangan hard-code sehingga contoh golden dan owner meluluskan.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 61. CALC-08 — Takrif ‘kadar upah simpan’ dalam harga asas lelong dan hubungannya dengan KK/fi & caj; sahkan caj lelong 3% × NM serta point-in-time NM.

- **Sumber:** `DARIPADA SRS—AMBIGU`  
- **Pemilik dicadangkan:** Finance + Shariah  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Auction settlement formula + examples.  
- **Cadangan kerja:** Wajib pilih satu tafsiran rasmi; jangan hard-code sehingga contoh golden dan owner meluluskan.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 62. CALC-09 — Sahkan royalti 7.20% dan fi iklan 1.40% atas KK: accrual harian atau realization, rounding, reversal, tax dan penerima.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance + Commercial  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Franchise agreement + accounting treatment.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 63. CALC-10 — Takrif day-count: inclusive/exclusive, timezone, time-of-day, leap year, DST tidak berkenaan, month-end, cut-off dan backdated events.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Finance + Technology  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Date convention standard.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 64. CALC-11 — Takrif precision internal, paparan, posting lejar, resit dan settlement bagi setiap amount; larang floating point binary untuk wang.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Finance + Architecture  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Money/decimal standard.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 65. CALC-13 — Jika operator ialah koperasi, bandingkan SRS dengan Arahan SKM 3/2026: amaun pembiayaan maksimum ialah nilai lebih rendah antara RM300,000 atau 80% nilai marhun (bukan margin produk wajib 80%); agregat 25% Kumpulan Wang Anggota; maksimum 18 bulan; kadar anggota/bukan anggota; tiada fi/caj; dan Ibra’ penyelesaian awal. Tentukan rule set sebenar bagi setiap entiti dan kontrak lama/baru.

- **Sumber:** `RUJUKAN SEMASA—KONFLIK MATERIAL`  
- **Pemilik dicadangkan:** Legal + SKM Compliance + Shariah + Finance  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Matriks SRS–SKM–lesen–entiti + legal/Shariah ruling + effective-date migration plan.  
- **Cadangan kerja:** Wajib pilih satu tafsiran rasmi; jangan hard-code sehingga contoh golden dan owner meluluskan.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### PWN — Kitar hayat gadaian, akad, payout dan pembetulan

Gate: Gate PWN: lifecycle diagram dan exception matrix lulus walkthrough setiap persona serta reconciliation wang/barang/dokumen.

#### 66. PWN-01 — Sahkan urutan pelanggan → penilaian → kiraan → approval → BISAS/akad → payout → SAG → vault; siapa boleh pause/cancel dan pada state mana.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Operations + Shariah  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Signed BPMN/state diagram.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 67. PWN-02 — Takrif status lengkap: Draft, Awaiting Approval, Approved, Akad Pending, Payout Pending, Active, Overdue, Auction Ready, Redeemed, Auctioned, Cancelled, Void/Disputed.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Product Owner  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** State dictionary.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 68. PWN-03 — Sahkan minimum RM100, maksimum 70% NM, request pelanggan di bawah maksimum, had agregat pelanggan/cawangan dan approval nilai tinggi.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Credit/Risk + Finance  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Financing policy dan authority limits.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 69. PWN-04 — Takrif kaedah payout tunai/transfer, payee validation, bank account ownership, approval, pending/failed/duplicate/retry dan reversal.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance + Operations  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Payout SOP + bank/provider contract.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 70. PWN-05 — Sahkan numbering SAG/reference per tenant/cawangan/tahun, reservation ketika offline, gap/duplicate dan reprint.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Operations + Audit  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Numbering standard.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 71. PWN-06 — Takrif edit/void/cancel sebelum dan selepas akad/payout; maker-checker, customer acknowledgement, journal reversal dan marhun disposition.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Legal + Finance + Operations  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Exception matrix.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 72. PWN-07 — Takrif transaksi serentak/duplicate clicks, idempotency key, record locking dan recovery selepas timeout.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Architecture + QA  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Concurrency scenarios.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### PAY — Ansuran, KK, lanjutan, tebusan dan pembayaran

Gate: Gate PAY: payment/channel/release matrix dan golden settlement tests diluluskan; tiada marhun dilepas atas dana pending.

#### 73. PAY-01 — Sahkan jenis bayaran yang diterima: ansuran principal, KK sahaja, fi/caj, settlement penuh; minimum/maksimum dan kombinasi dibenarkan.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance + Shariah  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Payment policy + examples.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 74. PAY-02 — Sahkan tunai, kad, e-wallet, FPX/online banking dan transfer; tentukan channel mana untuk ansuran/tebusan dan bila marhun boleh dilepas.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance + Operations  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Channel matrix dan settlement SLA.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 75. PAY-03 — Takrif pembayaran oleh pihak ketiga/wakil, nama payer, resit, refund destination dan semakan AML/fraud jika terpakai.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Compliance + Finance  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Third-party payment policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 76. PAY-04 — Takrif jumlah tebus real-time, quote expiry, pembayaran separa ketika quote aktif, cut-off hari dan perubahan caj selepas kegagalan gateway.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance + Product  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Redemption quote specification.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 77. PAY-05 — Takrif release marhun: receipt settled, identity/docs complete, dual control vault, customer acknowledgement dan no outstanding hold.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Vault + Operations  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Release checklist.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 78. PAY-06 — Takrif refund/overpayment, wrong payment, chargeback, reversal selepas release dan unclaimed refund.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Finance + Risk  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Refund/chargeback SOP.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 79. PAY-07 — Sahkan cooling period dua hari selepas tebusan: kiraan hari, skop pelanggan/rangkaian, cuti, override dan transaksi pada saat boundary.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Product + Risk  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Cooling-period rule + cases.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 80. PAY-08 — Jika operator koperasi, sahkan gadaian semula, kadar keuntungan perlu dijelaskan, pelarasan baki kepada pembiayaan baharu dan Ibra’ wajib penyelesaian awal seperti Arahan SKM 3/2026; selaraskan dengan cooling period SRS.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** Shariah + Finance + Product  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Shariah/legal ruling + refinance/redemption examples.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### CASH — Teller, float, buku tunai, Tutup Hari dan bank-in

Gate: Gate CASH: cash movement catalog, drawer model dan Tutup Hari ditandatangani; simulated day balances hingga bank statement.

#### 81. CASH-01 — Takrif float: sumber bank, request, approve, issue, teller acknowledge, top-up, return dan carry-forward harian/mingguan.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance Operations  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Cash SOP + current forms.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 82. CASH-02 — Petakan cash-in/out hanya bagi tunai fizikal; asingkan kad/FPX/e-wallet/transfer sebagai clearing/settlement bukan drawer cash.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Channel accounting map.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 83. CASH-03 — Sahkan expected cash = opening + cash-in − cash-out ± approved movements; denomination count, recount, variance reason dan threshold approval.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance + Branch Ops  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Balancing worksheet dan variance policy.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 84. CASH-04 — Takrif Tutup Hari: checklist, pending blockers, close sequence teller/cawangan, lock, late settlement, reopen dan audit.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance Controller  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Day-end SOP.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 85. CASH-05 — Takrif void/adjustment: reason code, evidence, maker-checker, time limit, posting/reversal dan customer receipt impact.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance + Risk  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Void/adjustment policy.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 86. CASH-06 — Takrif bank-in: preparation, cash in transit, slip upload, bank confirmation, partial/rejected deposit dan reconciliation statement.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Treasury  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Bank-in SOP + bank statement sample.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 87. CASH-07 — Takrif cheque jika ada, petty cash, expenses, inter-drawer/inter-branch transfer, counterfeit/suspect cash dan emergency evacuation.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Finance + Security  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Complete cash movement catalog.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 88. CASH-08 — Sahkan dashboard HO real-time, had cash on-hand/takaful, alert, acknowledgement, escalation dan data freshness.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Risk + Franchisor Ops  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Monitoring requirement + limits.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### LED — Lejar perakaunan, rekonsiliasi, cukai dan e-Invois

Gate: Gate LED: event-to-journal matrix, COA, e-Invois applicability dan reconciliation design ditandatangani Finance/Tax.

#### 89. LED-01 — Pilih sama ada sistem ini sublejar atau general ledger; tetapkan chart of accounts per francaisi/cawangan dan ownership jurnal.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** CFO/Financial Controller  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** COA, accounting architecture dan sample TB.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 90. LED-02 — Luluskan journal rule bagi gadaian/payout, KK accrual/receipt, fi/caj, ansuran principal, tebusan, royalti, iklan, lelongan, surplus/shortfall, float, bank-in, fee provider, refund, void dan impairment.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Finance  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Signed event-to-journal matrix.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 91. LED-03 — Takrif accrual versus cash recognition, cutoff, posting date/business date/value date, period lock dan prior-period adjustment.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Finance  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Accounting policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 92. LED-04 — Sahkan e-Invois/MyInvois applicability per entiti/transaksi berdasarkan turnover dan garis panduan HASiL semasa; tentukan consolidated, individual, self-billed, rejection/cancellation dan QR/UUID.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Tax + Finance IT  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Tax opinion + latest MyInvois guideline/SDK contract.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 93. LED-05 — Takrif integrasi SQL/MYOB/sistem akaun: master mapping, batch/API, frequency, retry, duplicate prevention, error queue dan reprocessing.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance IT  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Target system interface spec + sample files.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 94. LED-06 — Takrif bank/payment settlement dan fee reconciliation per provider, merchant, batch, value date, chargeback dan missing settlement.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Treasury  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Statements, settlement reports dan matching rules.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 95. LED-07 — Sahkan tax treatment SST/other taxes, withholding dan intercompany/franchise billing; jangan bina kadar tanpa tax sign-off.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Tax Advisor  
- **Gate / decision-by:** `G4` / `BUILD`  
- **Bukti minimum:** Tax memo dan invoice samples.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### VLT — Vault, chain-of-custody, stocktake dan perlindungan aset

Gate: Gate VLT: semua item boleh dijejak melalui simulated receipt-to-release; stocktake dan kehilangan diuji dengan dual control.

#### 96. VLT-01 — Takrif hierarki lokasi fizikal: cawangan, vault/safe, zon, rak, bekas/packet; capacity, restricted zones dan relokasi.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Vault Manager  
- **Gate / decision-by:** `G5` / `BUILD`  
- **Bukti minimum:** Vault layout dan location register.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 97. VLT-02 — Takrif movement types: receive, put-away, retrieve, inspect, revalue, transfer, auction, release, return; from/to, reason, dual acknowledgement dan time limit.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Vault + Risk  
- **Gate / decision-by:** `G5` / `BUILD`  
- **Bukti minimum:** Movement SOP + custody forms.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 98. VLT-03 — Sahkan dual control bagi vault entry, seal breaking, release dan high-value items; larang maker yang sama apabila polisi memerlukan.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Security + Vault  
- **Gate / decision-by:** `G5` / `BUILD`  
- **Bukti minimum:** Physical security/SoD policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 99. VLT-04 — Takrif stocktake full/cycle/random, scan method, freeze window, found/missing/extra/damaged, recount dan approval variance.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Internal Audit + Vault  
- **Gate / decision-by:** `G5` / `BUILD`  
- **Bukti minimum:** Stocktake SOP + historical report.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 100. VLT-05 — Takrif transfer antara cawangan/auction venue: packing, manifest, courier/security, cash-in-transit equivalent, insurance dan acceptance.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Risk + Logistics  
- **Gate / decision-by:** `G5` / `BUILD`  
- **Bukti minimum:** Transfer and insurance policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 101. VLT-06 — Takrif lost/damaged/tampered seal, robbery/fire/flood, police/takaful report, customer remediation dan legal hold.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Risk + Legal  
- **Gate / decision-by:** `G5` / `BUILD`  
- **Bukti minimum:** Incident/claims SOP.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 102. VLT-07 — Tentukan label/barcode/QR, printer/scanner, data pada label, reprint control dan pemisahan PII daripada visual umum.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Vault + Security  
- **Gate / decision-by:** `G5` / `BUILD`  
- **Bukti minimum:** Label design + hardware test.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### AUC — Tunggakan, notis, lucut hak dan lelongan

Gate: Gate AUC: eligibility, notice evidence dan settlement golden tests diluluskan; dry run auction seimbang dari vault hingga bank.

#### 103. AUC-01 — Sahkan trigger: tiada bayaran KK selepas 6 bulan atau tamat 10 bulan; grace period, payment pending, dispute, deceased, moratorium dan holiday handling.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Operations + Legal + Shariah  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Delinquency/auction policy.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 104. AUC-02 — Takrif state Aktif → Tertunggak → Sedia Lelong → Dilelong termasuk review, approval, withdrawal, sold, unsold, cancelled dan relist.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Auction Owner  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Auction state machine.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 105. AUC-03 — Sahkan kandungan, channel, lead time dan proof-of-delivery bagi notis sebelum 6/10 bulan, lucut hak dan lelongan; failed delivery/escalation.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Legal + Customer Comms  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Legal-approved notice matrix/templates.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 106. AUC-04 — Luluskan reserve/base price, caj lelong, upah simpan/KK/fi, bid rules, tax, auctioneer fee, sold price dan settlement waterfall.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance + Shariah + Legal  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Signed auction calculation examples.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 107. AUC-05 — Takrif bayaran lebihan ke akaun pelanggan: validation, payer entity, failed transfer, notification, claim by heir dan unclaimed-money treatment.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance + Legal  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Surplus SOP + legal opinion.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 108. AUC-06 — Takrif shortfall: adakah pelanggan dituntut, waived, impaired atau ditanggung entiti; collection conduct dan jurnal.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Finance + Legal  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Credit loss/collection policy.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 109. AUC-07 — Takrif lot/batch, auction venue/provider, bidder/KYC, bid capture/import, deposit, payment deadline, title transfer dan reconciliation.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Auction + Procurement  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Auctioneer contract/interface spec.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 110. AUC-08 — Takrif dispute/late redemption/withdrawal selepas list, cut-off, fee liability dan approval.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Legal + Auction Owner  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Exception policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 111. AUC-09 — Jika operator koperasi, petakan Arahan SKM 3/2026: notis bertulis, dua minggu selepas notis, kaedah lelong awam/e-lelong/tender, rekod bida boleh diaudit, konflik kepentingan, hak semak rekod, defisit dan surplus. Selesaikan tempoh surplus SKM sekurang-kurangnya satu tahun berbanding aturan Akta 370/JANM yang berkenaan.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** Legal + SKM Compliance + Finance  
- **Gate / decision-by:** `G3` / `DESIGN`  
- **Bukti minimum:** Auction/WTD legal opinion + SOP + regulator clarification jika perlu.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### DOC — Dokumen, resit, tandatangan, nombor dan rekod

Gate: Gate DOC: semua template, merge fields, signature, versioning, retention dan sample output ditandatangani Legal/Shariah/Operations.

#### 112. DOC-01 — Serahkan template rasmi SAG, Akuan KK, Wakalah, Notis Jual-Beli Komoditi, Borang Pembiayaan, resit, Borang Penebusan, notis, maklumat lelongan dan surat lebihan.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Legal + Operations  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Fail Word/PDF asal + sample completed.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 113. DOC-02 — Sahkan jenis tandatangan/acknowledgement: wet, electronic, digital signature, OTP, biometric atau checkbox; saksi, timestamp dan evidence.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Legal + Shariah  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Legal opinion + signing policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 114. DOC-03 — Takrif numbering, template version/effective date, data snapshot, locale, QR/barcode dan hash jika perlu.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Records Manager  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Document control standard.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 115. DOC-04 — Takrif print/reprint: reason, watermark SALINAN, copy count, device failure, queued print dan customer preference digital/paper.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Operations + Legal  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Print/reprint SOP.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 116. DOC-05 — Takrif storage, format archival, encryption, retention/legal hold, access, export dan disposal setiap document class.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Records + DPO + Legal  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Records retention schedule.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 117. DOC-06 — Sahkan dokumen yang dihantar melalui e-mel/SMS/link, access expiry, authentication dan redaction/masking.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Security + Customer Comms  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Secure delivery policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### NOT — Notifikasi, consent, kandungan dan bukti penghantaran

Gate: Gate NOT: notification matrix dan legal evidence diluluskan; sandbox test meliputi sent, fail, retry, opt-out dan wrong contact.

#### 118. NOT-01 — Sahkan event dan timing: notis 14 hari sebelum tamat 6 bulan, 14 hari sebelum 10 bulan, payment, extension, overdue, auction, surplus dan system alerts.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Operations + Legal  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Notification matrix.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 119. NOT-02 — Luluskan kandungan BM/English, terminology Shariah/legal, PII masking, contact/support dan template version.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Legal + Shariah + Brand  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Approved message templates.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 120. NOT-03 — Pilih SMS/e-mel/WhatsApp provider dan tentukan transactional versus marketing, opt-in/out, sender ID, quiet hours dan fallback.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Customer Comms + DPO  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Provider contract + consent policy.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 121. NOT-04 — Takrif queued/sent/delivered/failed/bounced/read jika ada, retry/backoff, duplicate suppression dan manual resend.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Technology + Operations  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Delivery state model + webhooks.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 122. NOT-05 — Takrif bukti notis yang mencukupi untuk lelongan dan sengketa: payload, provider receipt, timestamp, destination masked dan template version.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Legal  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Legal evidence requirement.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### INT — Integrasi, API, provider dan peranti

Gate: Gate INT: provider, kontrak, sandbox, error/reconciliation dan operasi sokongan lengkap bagi setiap interface P0.

#### 123. INT-01 — Inventori provider sebenar bagi BISAS, harga emas, IRIS/MyKad, payment/FPX/e-wallet, bank payout, SMS/WhatsApp, SMTP, accounting, CTOS/blacklist dan MyInvois.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Procurement + IT  
- **Gate / decision-by:** `G8` / `BUILD`  
- **Bukti minimum:** Vendor list, owner, contract, environment dan contact.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 124. INT-02 — Per interface, lengkapkan auth, endpoints, schema, version, idempotency, timeout, retry, rate limit, signature, IP allowlist, certificates dan secrets rotation.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Integration Architect  
- **Gate / decision-by:** `G8` / `BUILD`  
- **Bukti minimum:** OpenAPI/file spec/SDK dan security pack.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 125. INT-03 — Takrif business state bagi pending/fail/unknown/duplicate/late callback dan compensating action; jangan samakan timeout dengan gagal.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Product + Architecture  
- **Gate / decision-by:** `G8` / `BUILD`  
- **Bukti minimum:** Sequence diagrams + error catalog.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 126. INT-04 — Takrif reconciliation source, frequency, expected latency, cutoff, unmatched queue, manual resolution dan reprocessing.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Finance + Operations  
- **Gate / decision-by:** `G8` / `BUILD`  
- **Bukti minimum:** Reconciliation design + sample reports.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 127. INT-05 — Takrif SLA, maintenance windows, incident notification, data residency/subprocessors, liability, exit/data export dan DR setiap vendor.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Legal + Procurement + Security  
- **Gate / decision-by:** `G8` / `BUILD`  
- **Bukti minimum:** DPA/SLA/contract schedules.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 128. INT-06 — Lengkapkan hardware compatibility bagi reader IRIS, scanner, printer multifungsi/resit, labeler, timbang dan kamera; driver, OS, browser, spooler, health check.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** IT Operations  
- **Gate / decision-by:** `G8` / `BUILD`  
- **Bukti minimum:** Hardware model/driver matrix.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### REP — Laporan, dashboard, data dictionary dan eksport

Gate: Gate REP: report catalog, sample expected outputs dan metric dictionary disahkan melalui reconciliation terhadap golden dataset.

#### 129. REP-01 — Katalogkan laporan transaksi harian, status marhun, kewangan cawangan/konsolidasi, teller, cash position dan dashboard prestasi; serahkan contoh expected output.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Operations + Finance  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Report catalog + sample files.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 130. REP-02 — Takrif metric/semantic dictionary untuk gadaian, pembiayaan, tebusan, hasil, KK, overdue, marhun, cash dan variance.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Data Owner + Finance  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** KPI/data dictionary.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 131. REP-03 — Sahkan export PDF/Excel/CSV, row limits, async generation, password/encryption, masking, watermark, retention dan audit download.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Security + Data Owner  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Export security policy.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 132. REP-04 — Takrif real-time versus T+1, data freshness label, timezone/business date, late corrections dan restatement.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Finance + Data  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Reporting SLA.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 133. REP-05 — Takrif schedule/delivery, recipient groups, secure links, failed jobs dan distribution revocation.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Operations + Security  
- **Gate / decision-by:** `G10` / `BUILD`  
- **Bukti minimum:** Distribution matrix.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### ADM — Pentadbiran, master data, polisi dan effective dating

Gate: Gate ADM: configuration catalog dan change controls lulus test version/effective-date/rollback/audit.

#### 134. ADM-01 — Senaraikan konfigurasi pusat: kadar, had, mutu/harga, approval, notis, polisi, status cawangan dan integrasi; tentukan owner dan scope inheritance.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Product Owner + Finance  
- **Gate / decision-by:** `G1` / `BUILD`  
- **Bukti minimum:** Master/config catalog.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 135. ADM-02 — Takrif maker-checker, future effective date, preview impak, rollback dan larangan backdate bagi config kewangan/Shariah.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Risk + Shariah + Finance  
- **Gate / decision-by:** `G1` / `BUILD`  
- **Bukti minimum:** Configuration change policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 136. ADM-03 — Takrif reference data: reason codes, item types, relationship, bank, channel, branch calendar, currency, language dan status.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Data Steward  
- **Gate / decision-by:** `G1` / `BUILD`  
- **Bukti minimum:** Reference data dictionary.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 137. ADM-04 — Takrif bulk upload, validation preview, duplicate detection, approval dan error report.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Operations Admin  
- **Gate / decision-by:** `G1` / `BUILD`  
- **Bukti minimum:** Bulk admin SOP + templates.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### DATA — Model data, kualiti, migrasi, retention dan pelupusan

Gate: Gate DATA: model/data dictionary, migration scope, reconciliation dan retention diluluskan; rehearsal memenuhi toleransi sifar wang/barang.

#### 138. DATA-01 — Sahkan entiti dan hubungan: organisasi, user, customer/heir, pledge, item, valuation, calculation snapshot, akad, payment, cash drawer, journal, vault movement, auction, document, notification, approval dan audit.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Data Architect + Domain Owners  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Conceptual/logical data model.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 139. DATA-02 — Lengkapkan data dictionary: nama, definisi, type, precision, required, validation, classification, owner, lineage, retention dan masking.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Data Owner/DPO  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Approved data dictionary.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 140. DATA-03 — Inventori sistem/fail legacy, volume, quality, keys, attachment, history, duplicates, unknown values dan data yang tidak patut dimigrasi.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Data Migration Lead  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Source inventory + profiling report.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 141. DATA-04 — Takrif reconciliation migrasi: row/count/amount/hash, sampling dokumen, opening balances, cutover freeze, delta load, rollback dan sign-off.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Finance + Data  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Migration strategy + reconciliation workbook.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 142. DATA-05 — Takrif data quality rules dan owner bagi invalid IC, duplicate customer, orphan pledge/item/payment, missing document dan inconsistent status.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Data Steward + Operations  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** DQ rules + remediation backlog.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 143. DATA-06 — Tetapkan retention per record class, legal hold, archival access, anonymisation/deletion dan backup expiry; selaraskan PDPA, cukai, audit dan undang-undang berkaitan.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Records + DPO + Legal  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Legal-approved retention schedule.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 144. DATA-07 — Takrif data residency, cross-border transfer, processor/subprocessor, encryption key location dan export controls.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** DPO + Security  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Data flow map/DPIA/vendor register.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### PRV — Privasi dan hak subjek data

Gate: Gate PRV: legal roles, DPIA, notices/consent, DPO/DBN applicability dan rights workflow ditandatangani DPO/Legal.

#### 145. PRV-01 — Kenal pasti pengawal/pemproses data bagi YSV, francaisi dan vendor; tujuan serta legal basis setiap aktiviti pemprosesan.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** DPO/Legal  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Data processing inventory/ROPA + legal opinion.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 146. PRV-02 — Tentukan sama ada ambang pelantikan DPO dipenuhi (termasuk data sensitif/kewangan dan pemantauan sistematik) serta proses pendaftaran/komunikasi.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** Management + DPO  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** DPO assessment dan appointment evidence.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 147. PRV-03 — Takrif data breach detection, triage, register, assessment, notification regulator/subjek, evidence dan latihan mengikut garis panduan semasa.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** DPO + Security  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Incident/DBN plan dan breach form.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 148. PRV-04 — Laksanakan privacy by design/DPIA untuk MyKad, dokumen ID, data kewangan, blacklist, biometrik jika ada, monitoring dan integrasi vendor.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** DPO + Product  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** DPIA + remediation register.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 149. PRV-05 — Takrif data subject request: akses, correction, withdrawal/objection dan lain-lain hak terpakai; identity proof, SLA dan exception.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** DPO + Customer Service  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** DSR SOP/templates.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 150. PRV-06 — Takrif minimisation, masking, screen privacy, non-production data, analytics, log redaction dan secure disposal.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** DPO + Security  
- **Gate / decision-by:** `G6` / `DESIGN`  
- **Bukti minimum:** Privacy control matrix.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### SEC — Keselamatan aplikasi, infrastruktur, fraud dan audit

Gate: Gate SEC: threat model, audit/fraud catalog dan security test plan diluluskan; tiada risiko kritikal tanpa rawatan.

#### 151. SEC-02 — Tetapkan encryption in transit/at rest, key management/rotation, secrets vault, certificate lifecycle dan larangan secrets dalam kod/log.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Security Architecture  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** Cryptography/secrets standard.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 152. SEC-03 — Takrif immutable audit events: auth, view sensitive data, create/update/approve, formula/config, payment, cash, vault, document, export dan admin/support.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Security + Internal Audit  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** Audit event catalog.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 153. SEC-04 — Takrif fraud rules/alerts: velocity, duplicate identity/account, unusual override, after-hours, split transactions, repeated variance, failed auth dan suspicious auction.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Fraud/Risk  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** Fraud typology/rules + case workflow.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 154. SEC-06 — Takrif workstation/device security, patching, EDR, browser policy, USB/print/download, session privacy dan physical screen controls.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** IT Security  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** Endpoint standard.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 155. SEC-07 — Tetapkan incident severity, 24×7 contact, containment, forensic preservation, regulator/customer decision, recovery dan post-incident review.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** CISO + DPO  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** Incident response plan/runbooks.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 156. SEC-08 — Tentukan sama ada organisasi/sistem ialah NCII atau tertakluk keperluan Cyber Security Act 2024; jika tidak, dokumentasikan rationale dan controls baseline.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** Legal + CISO  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** Legal/regulatory applicability assessment.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### NFR — Keperluan bukan fungsian yang terukur

Gate: Gate NFR: semua sasaran mempunyai angka, kaedah ukur, beban ujian, owner dan ambang lulus.

#### 157. NFR-01 — Sahkan bilangan francaisi/cawangan, pengguna/teller serentak, pelanggan, gadaian/hari, items/pledge, payments, documents, attachment sizes dan pertumbuhan 5 tahun.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Business + Architecture  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Volume forecast dan peak profile.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 158. NFR-02 — Tetapkan p95/p99 response time bagi search, quote, save, approval, payment, print dan dashboard; masa job batch/report.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Product + Architecture  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Performance SLO table.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 159. NFR-03 — Tetapkan availability per channel/jam operasi, planned maintenance, error budget dan degraded-mode expectations.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Business + IT Ops  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Availability/SLA policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 160. NFR-04 — Tetapkan RTO/RPO per service/data, backup frequency, restore point, regional/site failure dan manual BCP.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Business Continuity + IT  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Business impact analysis + DR targets.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 161. NFR-06 — Sahkan desktop/tablet/mobile scope, OS/browser versions, resolutions, printer/reader support dan lifecycle support.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** IT + Product  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Compatibility matrix.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 162. NFR-07 — Tetapkan scalability, data query/export limits, archival, maintainability, deployment frequency, rollback time dan test coverage targets.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** CTO/Engineering  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Engineering quality SLO.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 163. NFR-08 — Takrif audit/log retention, clock synchronization, observability latency dan support diagnostic access.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** SRE + Security  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Logging/observability standard.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### ARC — Seni bina, platform, persekitaran dan deployment

Gate: Gate ARC: target architecture/ADRs diluluskan dan spikes membuktikan risiko teknikal P0 termasuk tenant, payment, BISAS dan offline.

#### 164. ARC-02 — Pilih hosting/cloud/on-prem, region/data residency, managed services, network connectivity cawangan, HA topology dan procurement constraint.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** CTO + Procurement + Security  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Target architecture + TCO/risk decision.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 165. ARC-03 — Takrif tenant isolation pada database/query/storage/cache/search/report/export; row-level policy dan defence in depth.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Architecture + Security  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Tenant security design.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 166. ARC-04 — Takrif environments dev/test/UAT/performance/staging/production, data policy, access, parity, refresh dan separation of duties.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Platform Engineering  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Environment strategy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 167. ARC-06 — Takrif transaction boundaries/outbox/queues bagi payment, BISAS, notification, documents dan accounting; retry/idempotency.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Solution Architect  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Sequence/consistency ADRs.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 168. ARC-07 — Takrif observability stack, metrics/logs/traces, dashboards, synthetic probes, alert routing dan cost retention.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** SRE  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Observability design.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### BCP — Backup, pemulihan bencana dan kesinambungan perniagaan

Gate: Gate BCP: restore, failover dan branch outage rehearsal lulus dengan bukti RTO/RPO serta reconciliation.

#### 169. BCP-01 — Lengkapkan BIA bagi fungsi gadaian, tebusan/release, cash close, vault, lelongan, notification dan reporting; maximum tolerable outage.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Business Continuity  
- **Gate / decision-by:** `G9` / `UAT`  
- **Bukti minimum:** BIA yang diluluskan.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 170. BCP-02 — Takrif backup database/object/document/config/secrets, frequency, immutability, encryption, retention, offsite dan monitoring.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** IT Operations + Security  
- **Gate / decision-by:** `G9` / `UAT`  
- **Bukti minimum:** Backup design/policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 171. BCP-03 — Takrif failover/failback dan reconciliation transaksi in-flight/provider callbacks; ownership go/no-go.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Incident Commander + Architecture  
- **Gate / decision-by:** `G9` / `UAT`  
- **Bukti minimum:** DR runbook.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 172. BCP-04 — Takrif manual/degraded branch pack: numbering, paper forms, limits, approval, custody, cash dan safe data entry selepas recovery.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Operations + Risk  
- **Gate / decision-by:** `G9` / `UAT`  
- **Bukti minimum:** Branch BCP pack.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 173. BCP-05 — Tetapkan drill cadence, scenario, observer, evidence, issue remediation dan audit reporting.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Business Continuity  
- **Gate / decision-by:** `G9` / `UAT`  
- **Bukti minimum:** Annual test plan.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### SUP — Sokongan, incident, change, SLA dan vendor exit

Gate: Gate SUP: support model, SLA, runbooks, monitoring dan vendor exit diluluskan serta diuji sebelum pilot.

#### 174. SUP-01 — Pilih model L1/L2/L3, waktu sokongan, bahasa, saluran, on-call dan owner bagi app, infra, integrasi, device, data dan vendor.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** IT Service Owner  
- **Gate / decision-by:** `G9` / `PILOT`  
- **Bukti minimum:** Support operating model/RACI.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 175. SUP-02 — Takrif severity berdasarkan pelanggan, wang, vault, cawangan, privacy/security dan regulatory impact; response/restore/update SLA.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Business + IT Ops  
- **Gate / decision-by:** `G9` / `PILOT`  
- **Bukti minimum:** Incident severity/SLA matrix.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 176. SUP-03 — Takrif service request seperti user access, branch/config, reprint, data correction dan report; approval serta audit.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Service Owner  
- **Gate / decision-by:** `G9` / `PILOT`  
- **Bukti minimum:** Service catalog.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 177. SUP-04 — Takrif problem management, root cause, known error, post-incident review dan backlog prevention.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** IT Operations  
- **Gate / decision-by:** `G9` / `PILOT`  
- **Bukti minimum:** Problem/PIR template.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 178. SUP-05 — Tetapkan monitoring ownership, alert noise, maintenance, certificate/secret renewal, capacity dan patch cadence.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** SRE/Platform  
- **Gate / decision-by:** `G9` / `PILOT`  
- **Bukti minimum:** Operations calendar/runbooks.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 179. SUP-06 — Takrif IP/source code ownership, licences, escrow jika perlu, data export, documentation handover, vendor transition dan deletion certificate.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Legal + Procurement + CTO  
- **Gate / decision-by:** `G9` / `PILOT`  
- **Bukti minimum:** Contract/exit plan.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### TST — Strategi ujian, UAT, kriteria penerimaan dan bukti

Gate: Gate TST: traceability, golden dataset, test/UAT plan dan defect gate diluluskan sebelum sprint pembangunan core.

#### 180. TST-03 — Takrif test levels: unit/property, component, integration/contract, end-to-end, migration, security, performance, accessibility, DR dan operational rehearsal.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** QA Lead  
- **Gate / decision-by:** `G11` / `BUILD`  
- **Bukti minimum:** Master test plan.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 181. TST-04 — Takrif UAT persona/site/scenario, data, training, evidence, defect severity, retest, waiver dan sign-off.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Business Test Lead  
- **Gate / decision-by:** `G11` / `BUILD`  
- **Bukti minimum:** UAT plan/scripts/sign-off.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 182. TST-05 — Takrif provider/device certification dan negative scenarios: timeout, duplicate callback, stale price, reader/printer fail, offline/reconnect.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Integration QA + IT Ops  
- **Gate / decision-by:** `G11` / `BUILD`  
- **Bukti minimum:** Certification matrix.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 183. TST-07 — Tetapkan defect severity/priority, triage SLA, go-live threshold, accepted-risk authority dan regression scope.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** QA + Product Owner  
- **Gate / decision-by:** `G11` / `BUILD`  
- **Bukti minimum:** Defect management policy.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### CHG — Latihan, SOP, perubahan organisasi, pilot dan rollout

Gate: Gate CHG: SOP, training, pilot charter, rollout dan hypercare siap; pengguna pilot lulus competency.

#### 184. CHG-01 — Inventori SOP yang perlu dicipta/ubah bagi KYC, valuation, pledge, cash, vault, auction, close, incident, privacy dan support.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Operations Excellence  
- **Gate / decision-by:** `G11` / `PILOT`  
- **Bukti minimum:** SOP register dengan owner/version.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 185. CHG-02 — Takrif audience dan competency: teller, executive, manager, supervisor, HO admin, finance, vault, auction, auditor dan support.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Training Lead  
- **Gate / decision-by:** `G11` / `PILOT`  
- **Bukti minimum:** Training needs analysis.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 186. CHG-04 — Pilih 1–3 cawangan pilot mengikut profil volume/network/staff/device; duration, scope, parallel run dan success/stop criteria.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Steering Committee  
- **Gate / decision-by:** `G11` / `PILOT`  
- **Bukti minimum:** Pilot charter.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 187. CHG-06 — Takrif rollout waves, readiness per cawangan, data cutover, onsite/remote support, freeze, hypercare, KPIs dan rollback.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Deployment Lead  
- **Gate / decision-by:** `G11` / `PILOT`  
- **Bukti minimum:** Rollout playbook.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 188. CHG-07 — Takrif komunikasi pelanggan/staf, perubahan dokumen/terma, channel bantuan dan complaint escalation.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Change + Legal  
- **Gate / decision-by:** `G11` / `PILOT`  
- **Bukti minimum:** Communication plan.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### REG — Undang-undang, kawal selia, cukai dan kebolehgunaan

Gate: Gate REG: regulatory perimeter dan obligation-to-control matrix ditandatangani penasihat berkelayakan; semua gap P0 mempunyai pelan.

#### 189. REG-01 — Sahkan lesen, syarat operasi, rekod/laporan, resit, notis, tempoh, lelongan dan pemeriksaan di bawah Akta Pemegang Pajak Gadai 1972 [Akta 81] serta peraturan/garis panduan KPKT yang terpakai kepada model ARYP.

- **Sumber:** `DARIPADA SRS + RUJUKAN SEMASA`  
- **Pemilik dicadangkan:** Legal/Compliance  
- **Gate / decision-by:** `G12` / `DESIGN`  
- **Bukti minimum:** Legal opinion + licence conditions + compliance obligations register.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 190. REG-02 — Sahkan badan/standard yang benar-benar mempunyai bidang kuasa (KPKT, BNM, SKM, KUSKOP atau lain-lain) berdasarkan entiti, lesen dan produk; dokumentasi jika tidak terpakai.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** General Counsel  
- **Gate / decision-by:** `G12` / `DESIGN`  
- **Bukti minimum:** Regulatory perimeter memo.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 191. REG-03 — Nilai pemakaian Akta Kredit Pengguna 2025 [Akta 873] dan piawaian kelakuan/authorisation kepada YSV/francaisi/pajak gadai atau penyedia servis berkaitan.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** Legal/Compliance  
- **Gate / decision-by:** `G12` / `DESIGN`  
- **Bukti minimum:** Legal opinion terkini.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 192. REG-04 — Nilai status reporting institution dan skop AML/CFT/CPF/TFS; jika terpakai, tentukan CDD, screening, record, suspicious transaction, governance dan confidentiality.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** Compliance/MLRO  
- **Gate / decision-by:** `G12` / `DESIGN`  
- **Bukti minimum:** AML legal assessment + approved policy.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 193. REG-05 — Sahkan PDPA 2010/pindaan 2024, pendaftaran kelas pengawal data, DPO, breach, processor, cross-border, rights dan security obligations.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** DPO + Legal  
- **Gate / decision-by:** `G12` / `DESIGN`  
- **Bukti minimum:** PDPA compliance assessment/ROPA/DPIA.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 194. REG-06 — Sahkan keperluan HASiL e-Invois/MyInvois mengikut entiti, turnover, transaksi, tempoh peralihan dan SDK/guideline versi semasa.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** Tax  
- **Gate / decision-by:** `G12` / `DESIGN`  
- **Bukti minimum:** Tax opinion + registration/integration plan.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 195. REG-07 — Sahkan treatment lebihan lelongan tidak dituntut di bawah Akta Wang Tak Dituntut 1965 [Akta 370]: bila payable, aging, register, notice, submission dan claim evidence.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** Finance + Legal  
- **Gate / decision-by:** `G12` / `DESIGN`  
- **Bukti minimum:** Legal/Finance opinion + WTD SOP.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 196. REG-08 — Sahkan kebolehterimaan rekod/tandatangan elektronik/digital, evidence dan retention di bawah undang-undang berkaitan serta syarat dokumen pajak gadai.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** Legal  
- **Gate / decision-by:** `G12` / `DESIGN`  
- **Bukti minimum:** Legal opinion + signature/evidence standard.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 197. REG-09 — Nilai pemakaian Akta Keselamatan Siber 2024 [Akta 854]/NCII dan lain-lain kewajipan pelaporan insiden sektor; dokumentasikan rationale.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** CISO + Legal  
- **Gate / decision-by:** `G12` / `DESIGN`  
- **Bukti minimum:** Cyber regulatory assessment.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 198. REG-10 — Sahkan statutory/audit/tax/contract retention dan limitation periods; selesaikan konflik dengan minimisation/deletion.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Legal + Tax + DPO  
- **Gate / decision-by:** `G12` / `DESIGN`  
- **Bukti minimum:** Approved retention matrix.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 199. REG-11 — Bagi setiap operator koperasi, nilai Arahan Aktiviti Pajak Gadai Islam (Ar-Rahnu) SKM Bil. 3/2026 yang berkuat kuasa 1 Ogos 2026: kelulusan aktiviti/cawangan/kontrak, operator sendiri, KWA dan mudah tunai, latihan/peralatan, takaful, eligibility, had/kadar/tempoh, tiada fi/caj, Ibra’, gadaian semula, lelongan, aduan, jawatankuasa, audit/risk dan laporan suku tahunan.

- **Sumber:** `RUJUKAN SEMASA—KONFLIK MATERIAL`  
- **Pemilik dicadangkan:** Board + SKM Compliance + Legal + Shariah  
- **Gate / decision-by:** `G12` / `DESIGN`  
- **Bukti minimum:** Signed obligation-to-control matrix + licence/approval + gap plan.  
- **Cadangan kerja:** Wajib pilih satu tafsiran rasmi; jangan hard-code sehingga contoh golden dan owner meluluskan.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 200. REG-12 — Sahkan duti setem instrumen demi instrumen dan keperluan Sistem Taksir Sendiri Duti Setem (STSDS) yang bermula berfasa pada 1 Januari 2026, termasuk TIN, taksiran, pembayaran, sijil dan rekod tujuh tahun jika terpakai.

- **Sumber:** `RUJUKAN SEMASA—SAHKAN PEMAKAIAN`  
- **Pemilik dicadangkan:** Tax + Legal + Document Operations  
- **Gate / decision-by:** `G12` / `DESIGN`  
- **Bukti minimum:** Stamp-duty position paper + document matrix + STSDS process.  
- **Cadangan kerja:** Minta Legal/Compliance sahkan pemakaian mengikut entiti, lesen dan tarikh; sistem kekal `PENDING_CLIENT`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

### EVD — Artefak, bukti pelanggan dan definition of build-ready

Gate: Gate EVD: baseline keperluan lengkap, testable, traceable dan signed; perubahan selepas itu melalui change control.

#### 201. EVD-02 — Sediakan semua dokumen/transaksi/laporan sebenar—template kosong dan sekurang-kurangnya satu contoh lengkap yang betul bagi setiap jenis.

- **Sumber:** `DARIPADA SRS`  
- **Pemilik dicadangkan:** Operations + Finance + Legal  
- **Gate / decision-by:** `G12` / `BUILD`  
- **Bukti minimum:** Document/report sample pack.  
- **Cadangan kerja:** Sahkan SRS sebagai baseline; jika belum ada bukti, gunakan konfigurasi reversible dan label `ASSUMED—NOT APPROVED`.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 202. EVD-03 — Sediakan kontrak/SDK/API/sample payload/test credentials bagi setiap provider dan peranti; license/SLA/DPA/contact.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Procurement + IT  
- **Gate / decision-by:** `G12` / `BUILD`  
- **Bukti minimum:** Integration evidence pack.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 203. EVD-04 — Sediakan data statistik/legacy: volume, peak, branches/users, sample anonymised data, source schema, quality dan opening balances.

- **Sumber:** `PERLU KEPUTUSAN`  
- **Pemilik dicadangkan:** Data Owner + Finance  
- **Gate / decision-by:** `G12` / `BUILD`  
- **Bukti minimum:** Data discovery pack.  
- **Cadangan kerja:** Gunakan konfigurasi versioned dengan status `PENDING_CLIENT` sehingga keputusan bertulis diterima.  
- **Jawapan client:** `SETUJU CADANGAN` / `UBAH: ____________________` / `TIDAK BERKENAAN` / `BLOCKED: ____________________`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

## Cadangan kerja untuk pengesahan pilihan (23 item)

Item ini bukan blocker keputusan client kerana ia ialah cadangan implementasi. Jawab hanya jika client mahu pendekatan lain.

#### 204. GOV-03 — Gunakan satu state model: BELUM DIBINCANG → DALAM SEMAKAN → DIPUTUSKAN → DILULUSKAN, dengan cabang terkawal BLOCKED, TIDAK BERKENAAN, DITOLAK atau DIKECUALIKAN DENGAN RISIKO. Setiap cabang wajib mempunyai alasan, kuasa dan bukti.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Product Owner  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Decision register yang dikawal versi + status transition rules.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 205. GOV-06 — Setujui cadence bengkel, playback, prototaip, demo sprint, risk review dan steering committee; tentukan SLA jawapan pelanggan.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Project Manager  
- **Gate / decision-by:** `G1` / `DESIGN`  
- **Bukti minimum:** Kalendar projek dan communication plan.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 206. BUS-06 — Takrif prinsip pengalaman pelanggan dan pekerja: bahasa, privasi di kaunter, tempoh menunggu, bantuan untuk OKU/warga emas dan saluran aduan.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Customer Experience  
- **Gate / decision-by:** `G1` / `PILOT`  
- **Bukti minimum:** Service blueprint dan customer charter.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 207. IAM-06 — Log sebab, approver, sebelum/selepas dan correlation ID untuk tindakan privileged; larang akaun kongsi.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Security  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** Audit policy dan log sample.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 208. SHR-06 — Tetapkan Shariah review/audit sampling, evidence pack dan exception reporting.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Shariah Audit  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Shariah audit programme.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 209. CALC-12 — Wujudkan rule version, effective date dan immutable calculation snapshot pada transaksi supaya pengiraan lama boleh diulang selepas polisi berubah.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Product + Architecture  
- **Gate / decision-by:** `G2` / `DESIGN`  
- **Bukti minimum:** Calculation engine design + audit sample.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 210. INT-07 — Wujudkan integration observability: correlation ID, latency, success rate, queues, synthetic checks, alert owner dan runbook.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** SRE/IT Ops  
- **Gate / decision-by:** `G8` / `BUILD`  
- **Bukti minimum:** Dashboard/runbook design.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 211. REP-06 — Takrif drill-down, comparison cawangan, targets, alert thresholds dan accessibility bagi dashboard.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Product + UX  
- **Gate / decision-by:** `G10` / `PILOT`  
- **Bukti minimum:** Dashboard wireframe/KPI acceptance.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 212. ADM-05 — Paparkan audit compare sebelum/selepas, siapa/masa/sebab/approver dan link change request.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Security + Product  
- **Gate / decision-by:** `G1` / `BUILD`  
- **Bukti minimum:** Audit sample.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 213. ADM-06 — Takrif lifecycle bersama bagi case/task/hold/exception yang digunakan untuk dispute, fraud, privacy request, unmatched reconciliation, integration failure dan pembetulan: category, state, priority, owner, SLA, evidence, escalation, resolution dan reopen.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Product + Operations + Risk  
- **Gate / decision-by:** `G1` / `BUILD`  
- **Bukti minimum:** Cross-domain case model + state diagram + queue/RACI.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 214. SEC-01 — Luluskan klasifikasi data/aset, threat model dan risk assessment termasuk account takeover, insider fraud, duplicate payout, tenant leakage, price manipulation dan vault release.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** CISO/Risk  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** Threat model/risk register.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 215. SEC-05 — Tetapkan secure SDLC: code review, dependency/SAST/secret scanning, DAST, penetration test, vulnerability SLA dan release gate.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Engineering + Security  
- **Gate / decision-by:** `G7` / `DESIGN`  
- **Bukti minimum:** Secure SDLC policy.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 216. NFR-05 — Sasaran WCAG 2.2 AA, keyboard, focus, error text, contrast, zoom, screen reader dan touch target 44×44; tentukan pengecualian.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Product + UX  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Accessibility acceptance checklist.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 217. ARC-01 — Luluskan architecture principles: ledger-first, immutable audit, transactional consistency, idempotency, least privilege, tenant isolation dan external-provider resilience.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Architecture Board  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Architecture decision record (ADR) set.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 218. ARC-05 — Takrif CI/CD, infrastructure as code, artifact signing, approvals, DB migration, feature flags, canary/rollback dan evidence release.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Engineering + DevOps  
- **Gate / decision-by:** `G9` / `DESIGN`  
- **Bukti minimum:** Deployment/release architecture.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 219. TST-01 — Bina traceability SRS/decision → requirement → design/API/data → test → evidence → approval; tentukan tool dan owner.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** BA Lead + QA  
- **Gate / decision-by:** `G11` / `BUILD`  
- **Bukti minimum:** Requirements traceability matrix.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 220. TST-02 — Luluskan golden cases untuk semua formula, journal dan state transition termasuk boundary time, rounding, partial/reversal dan concurrency. Pisahkan gate: (1) sebelum build—input/expected result ditandatangani bebas daripada kod; (2) semasa build—cases diautomasi; (3) sebelum release—100% automated tests lulus.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Finance + Shariah + QA  
- **Gate / decision-by:** `G11` / `BUILD`  
- **Bukti minimum:** Signed golden dataset/expected outputs + automated regression report.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 221. TST-06 — Takrif test data privacy, synthetic/masked data, refresh, account/access dan cleanup.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** QA + DPO  
- **Gate / decision-by:** `G11` / `BUILD`  
- **Bukti minimum:** Test data management plan.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 222. CHG-03 — Sediakan train-the-trainer, quick reference, video/demo, sandbox, assessment, attendance dan refresher.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Training + Product  
- **Gate / decision-by:** `G11` / `PILOT`  
- **Bukti minimum:** Training pack/certification record.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 223. CHG-05 — Pilot exit minimum: 100% golden tests; tiada Critical/High security; dua Tutup Hari seimbang; provider reconciliation 100%; tiada item vault tanpa lokasi; restore drill dan UAT sign-off.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Sponsor + Domain Owners  
- **Gate / decision-by:** `G11` / `PILOT`  
- **Bukti minimum:** Pilot evidence pack.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 224. EVD-01 — Sediakan semua polisi/rulebook yang ditandatangani: produk/Shariah, formula, payment, cash, vault, auction, access/SoD, privacy/security, accounting/tax dan retention.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** PMO + Domain Owners  
- **Gate / decision-by:** `G12` / `BUILD`  
- **Bukti minimum:** Approved policy pack.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 225. EVD-05 — Lengkapkan signed decision register, glossary, BPMN/state diagrams, role matrix, data dictionary, API specs, journal matrix, NFR sheet, test plan dan traceability matrix.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Product Owner + BA Lead  
- **Gate / decision-by:** `G12` / `BUILD`  
- **Bukti minimum:** Build-ready requirements pack.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

#### 226. EVD-06 — Tandatangani Build-Ready Certificate oleh Business, Operations, Finance, Shariah, Legal/Compliance, DPO/Security, Technology dan Product Owner.

- **Sumber:** `CADANGAN KERJA`  
- **Pemilik dicadangkan:** Sponsor  
- **Gate / decision-by:** `G12` / `BUILD`  
- **Bukti minimum:** Signed certificate di akhir dokumen.  
- **Jawapan client:** `DITERIMA` / `UBAH: ____________________` / `DITOLAK`  
- **Owner + approver + tarikh kuat kuasa:** ______________________________________________  

## Format keputusan akhir

Selepas semua jawapan diisi, setiap item akan dipindahkan ke decision register dengan status `DIPUTUSKAN`, `DILULUSKAN`, `BLOCKED`, `TIDAK BERKENAAN` atau `DITERIMA DENGAN RISIKO`. Assumption demo akan digantikan hanya selepas owner dan approver dinamakan.

**Nota penting:** menjawab dokumen ini tidak dengan sendirinya memberikan kelulusan Shariah, undang-undang, regulatory, privacy, security atau production. Bukti dan sign-off pihak berkuasa masih diperlukan.
