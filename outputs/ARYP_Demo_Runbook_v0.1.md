# ARYP — Demo Runbook AB-0.1

**Status:** DRAF PRE-CONTRACT / DATA SINTETIK  
**Seed:** `ARYP_demo_seed_v0.1.json`  
**Baseline:** `ARYP_Assumption_Baseline_v0.1.md`

## Tujuan demo

Menunjukkan bahawa sistem boleh mengurus aliran ARYP end-to-end dalam satu pengalaman yang konsisten, sambil membezakan dengan jelas antara simulasi dan keputusan produksi.

## Persona demo

| Persona | User ID | Fokus |
|---|---|---|
| Penyelia Francaisor | USR-001 | Pantau semua cawangan, laporan dan audit. |
| Pengurus Cawangan | USR-002 | Semak/approve transaksi cawangan BR-001. |
| Eksekutif | USR-003 | Daftar pelanggan, valuation dan sediakan gadaian. |
| Teller | USR-004 | Simulasi cash-in/cash-out, cash count dan day-end. |
| Custodian Vault | USR-005 | Simulasi check-in/check-out dan chain-of-custody. |
| Auditor | USR-006 | Semak event, approval, exception dan tenant boundary. |

## Scenario 1 — Gadaian baharu

**Seed:** CUS-001, MAR-001, PLG-001, BR-001  
**Assumption:** A-VAL-001, A-CALC-001–005, A-PWN-001, A-PAY-001

1. Login sebagai `USR-003` dan pilih BR-001.
2. Cari `CUS-001`; tunjukkan masked identifier dan risk state `CLEAR`.
3. Buka MAR-001: purity 916, 6.48g, fixture price RM603/g.
4. Paparkan NM simulasi RM3,907.44 dan financing provisional RM2,730.00.
5. Hantar ke approval; tunjukkan maker/checker dan self-approval blocked.
6. Login sebagai `USR-002`, approve untuk demo sahaja.
7. Jana SAG watermark `DRAF—BUKAN DOKUMEN RASMI`.
8. Jana simulated cash-out dan vault check-in.

**Expected:** Pledge `PLG-001` berada pada `PLEDGED_ACTIVE`; semua event mempunyai actor, timestamp, branch dan `SIMULATION` marker.

## Scenario 2 — Tebusan simulasi

**Seed:** CUS-002, PLG-002, PAY-002  
**Assumption:** A-PAY-001, A-CALC-002, A-VLT-001

1. Login sebagai `USR-003` dan cari PLG-002.
2. Tunjukkan quote provisional dan breakdown financing/KK/fi.
3. Pilih mock payment `SUCCESS`.
4. Paparkan receipt watermark `DRAF`.
5. Minta approval dan simulasi vault check-out melalui dual control.

**Expected:** State `REDEMPTION_SIMULATED`; tiada provider sebenar, tiada wang sebenar dan tiada physical release.

## Scenario 3 — Repeat customer dan risk hold

**Seed:** CUS-003, CUS-005  
**Assumption:** A-DATA-001, A-DATA-002, A-ORG-001

1. Cari CUS-003 merentasi scope BR-001 dan buka sejarah gadaian sintetik.
2. Tunjukkan `REPEAT_REVIEW`, kemudian tekan semakan risiko sebagai Pengurus.
3. Sahkan status berubah kepada `REVIEWED_SIMULATED`/`Disemak · REPEAT_REVIEW` dan event audit ALLOWED.
4. Cari CUS-005, tunjukkan sejarah ringkas dan cuba semakan risiko.
5. Paparkan hold `BLACKLIST_REVIEW`; cubaan semakan menghasilkan DENIED `blacklist_hold` dan tiada bypass.

**Expected:** Sejarah customer boleh dilihat, repeat review boleh disahkan secara simulasi, blacklist hold tidak boleh dilepasi, dan kedua-dua keputusan direkodkan dalam audit.

## Scenario 4 — Teller dan Tutup Hari

**Seed:** BR-001, PAY-001, PAY-003  
**Assumption:** A-CASH-001, A-IAM-002, A-LED-001

1. Login sebagai `USR-004`.
2. Masukkan opening float fixture.
3. Tunjukkan simulated cash-out pledge dan simulated cash-in instalment.
4. Lakukan cash count dengan variance fixture.
5. Minta manager review; cuba void sebagai teller dan tunjukkan blocked state.
6. Jalankan day-end simulation.

**Expected:** Baki expected/actual, variance reason, approval event dan day-end snapshot wujud; tiada posting bank sebenar.

## Scenario 5 — Vault dan stocktake

**Seed:** VLT-001, VLT-002  
**Assumption:** A-VLT-001

1. Login sebagai `USR-005`.
2. Tunjukkan location hierarchy `VAULT-A-01`.
3. Paparkan check-in dan simulated check-out dengan actor/reason.
4. Jalankan stocktake terhadap senarai fixture.
5. Cuba check-out tanpa dual control.

**Expected:** Movement tanpa actor/reason atau approval ditolak; audit trail tidak boleh dipadam.

## Scenario 6 — Overdue, notifikasi dan lelongan

**Seed:** PLG-003, PLG-004, AUC-001, AUC-002, NOT-001, NOT-002  
**Assumption:** A-PWN-001, A-AUC-001, A-NOT-001, A-CALC-005

1. Buka PLG-003 pada `OVERDUE`.
2. Tunjukkan simulated reminder `SENT_SIMULATED` dan `RETRY_SIMULATED`.
3. Buka PLG-004 pada `AUCTION_READY`.
4. Tunjukkan dua hasil auction: surplus dan shortfall.
5. Paparkan bahawa auto-settlement/actual refund/collection disabled.

**Expected:** State transitions dan timers boleh dilihat; sistem tidak mendakwa keputusan legal atau financial telah diluluskan.

## Scenario 7 — Dashboard francaisor dan audit

**Seed:** semua branch/franchisee  
**Assumption:** A-ORG-001, A-ORG-002, A-SEC-001, A-REP-001

1. Login sebagai `USR-001`.
2. Tunjukkan jumlah pledge, simulated cash position, vault count dan auction queue.
3. Drill-down dari franchisee → branch → pledge.
4. Login sebagai `USR-006` dan buka audit event.
5. Cuba cross-tenant action atau destructive delete.

**Expected:** HO boleh monitor mengikut scope; action terlarang ditolak dan direkodkan.

## Demo exit checklist

- [ ] Semua scenario 1–7 boleh dimainkan tanpa exception yang tidak direkodkan.
- [ ] Semua amount, dokumen dan provider state ditanda simulation/provisional.
- [ ] Tiada PII, production secret, live provider call atau actual payment.
- [ ] Setiap assumption ID boleh dikesan dari UI/event ke assumption register.
- [ ] Setiap denied action menghasilkan audit event.
- [ ] Seed boleh di-reset tanpa kehilangan baseline.
- [ ] Client menerima senarai perkara yang perlu disahkan selepas kontrak.
