# ARYP — Assumption-Based Development Baseline

**Status:** DRAF PRE-CONTRACT — ASSUMED / NOT APPROVED  
**Versi:** AB-0.1  
**Tujuan:** Membina prototaip end-to-end yang boleh didemonstrasikan kepada client sebelum kontrak dan keputusan rasmi diterima.

## 1. Sempadan kerja

Baseline ini membenarkan pembinaan sehingga 100% **demo/prototype scope** menggunakan data sintetik, fixture, mock provider dan peraturan yang boleh diganti. Ia tidak mengizinkan transaksi wang sebenar, payout sebenar, pelepasan marhun, dokumen sah, penggunaan PII sebenar atau sambungan production.

Selepas kontrak diterima, setiap assumption mesti ditukar kepada salah satu status berikut:

- `DILULUSKAN` — keputusan pelanggan/penasihat dengan bukti.
- `DIUBAH` — rule baharu dengan impact analysis dan regression test.
- `TIDAK BERKENAAN` — keputusan rasmi dengan alasan.
- `EXCEPTION` — risk ID, accepting authority, mitigation dan expiry.

## 2. Demo definition of done

Demo dianggap lengkap apabila pengguna boleh menjalankan aliran berikut dengan data sintetik:

1. Login dan memilih francaisi/cawangan mengikut role.
2. Mendaftarkan pelanggan, waris dan item marhun.
3. Menjalankan valuation fixture dan melihat quote gadaian sementara.
4. Menghantar transaksi ke approval dan menghasilkan SAG berwatermark `DRAF`.
5. Mensimulasikan cash-out/payout tanpa pergerakan wang sebenar.
6. Menjalankan simulasi ansuran, tebusan, overdue dan auction eligibility.
7. Melihat pergerakan vault dan chain-of-custody.
8. Menjalankan simulasi lelongan, surplus/shortfall dan settlement.
9. Melihat dashboard francaisor, laporan dan audit trail.
10. Menguji mock API harga emas, payment, MyKad/IRIS, SMS dan accounting.

## 3. Guardrail wajib

| Guardrail | Peraturan demo |
|---|---|
| Data | Data sintetik atau anonymised sahaja; tiada MyKad/telefon sebenar. |
| Wang | Semua amount ditanda `SIMULATION`; tiada bank/payment call sebenar. |
| Marhun | Item maya sahaja; tiada release fizikal atau custody sebenar. |
| Formula | Versioned/configurable dan dipaparkan sebagai `PROVISIONAL`. |
| Dokumen | Semua SAG, resit dan notis mempunyai watermark `DRAF—BUKAN DOKUMEN RASMI`. |
| Integrasi | Adapter + mock/sandbox; retry/idempotency boleh diuji tanpa provider sebenar. |
| Akses | Default-deny, tenant isolation, tiada shared account dan tiada self-approval. |
| Audit | Event append-only; void/reversal digunakan sebagai ganti delete. |
| Release | Payout, release marhun, auction settlement dan production integration disabled by default. |

## 4. Assumption register

| ID | Domain | Assumption sementara | Cara mengganti selepas kontrak |
|---|---|---|---|
| A-GOV-001 | Governance | Scope demo merangkumi semua 32 domain, tetapi release production belum ditetapkan. | Sponsor tandatangan scope matrix, release scope dan acceptance criteria. |
| A-ORG-001 | Tenant | Setiap rekod mempunyai `operator_id`, `franchisee_id` dan `branch_id`; akses cross-tenant disekat. | Legal/Data Owner sahkan entiti, ownership dan perkongsian rekod. |
| A-ORG-002 | HO | Head Office read-only secara lalai; konfigurasi pusat hanya melalui permission khusus. | Product Owner luluskan kuasa view/configure/approve/operate. |
| A-IAM-001 | IAM | Role sementara: Admin, Franchisor Supervisor, Branch Manager, Executive, Teller, Auditor. | Risk/Ops luluskan role-action matrix, limits dan delegation. |
| A-IAM-002 | IAM | Self-approval disekat; maker/checker diwajibkan untuk amount dan event berisiko. | Finance/Risk luluskan threshold dan exception. |
| A-SEC-001 | Security | Default-deny, MFA-capable adapter, unique user, append-only audit dan correlation ID. | CISO luluskan IdP, MFA, event catalogue, retention dan incident rules. |
| A-DATA-001 | Data | Canonical model menyimpan customer, heir, pledge, marhun, payment, vault, auction dan ledger event. | Data Owner sahkan dictionary, lineage, mask, retention dan migration mapping. |
| A-DATA-002 | Privacy | Synthetic/masked data sahaja; consent, DSR dan retention dibina sebagai configurable hooks. | DPO/Legal luluskan purpose, legal basis, retention, residency dan processor terms. |
| A-VAL-001 | Valuation | Harga emas demo datang daripada fixture versioned mengikut purity × weight. | Owner luluskan price source, purity table, refresh policy dan exception. |
| A-CALC-001 | Formula | Margin pembiayaan demo sementara: 70% NM; minimum RM100. | Finance/Shariah luluskan margin, minimum, maximum dan rounding. |
| A-CALC-002 | Formula | KK demo sementara: 1% sebulan × financing × 12/365 × hari. | Finance/Shariah luluskan day-count, accrual, rounding dan payment waterfall. |
| A-CALC-003 | Formula | Fi/caj demo sementara: 2.5% × NM × hari/234. | Finance/Shariah luluskan denominator, calendar basis dan early redemption treatment. |
| A-CALC-004 | Formula | Royalty 7.20% dan advertising 1.40% daripada KK sebagai fixture. | Finance/Tax luluskan basis, timing, journal dan e-Invoice treatment. |
| A-CALC-005 | Formula | Minimum 15 hari dan 6+4 bulan digunakan sebagai provisional labels sahaja. | Product/Shariah/Legal luluskan minimum, extension, grace dan maturity rules. |
| A-PWN-001 | Lifecycle | State machine demo: Draft → Active → Overdue → Auction Ready → Auctioned; Redeemed/Void/Blocked sebagai branch. | Ops/Legal/Shariah luluskan setiap event, precondition, actor dan side effect. |
| A-PAY-001 | Payment | Payment demo menghasilkan simulated receipt dan settlement event; tiada actual capture. | Finance/Ops luluskan channels, waterfall, refund, reversal dan reconciliation. |
| A-CASH-001 | Teller | Drawer, business date dan day-end ialah configurable fixtures; offline transaction dimatikan. | Finance/Ops/IT luluskan drawer model, cut-off, offline conflict dan BCP. |
| A-LED-001 | Ledger | Sistem menghasilkan neutral event-to-journal payload; tiada claim bahawa ia GL atau subledger. | CFO/Tax luluskan COA, journal matrix, source of truth dan posting policy. |
| A-VLT-001 | Vault | Semua movement memerlukan actor, reason, location dan timestamp; release disabled. | Vault/Risk luluskan location hierarchy, dual control, stocktake dan release SOP. |
| A-AUC-001 | Auction | Eligibility, bid, sold/unsold, surplus/shortfall ialah simulator; auto-settlement disabled. | Legal/Finance/Shariah luluskan trigger, notices, waterfall, WTD dan collection. |
| A-DOC-001 | Documents | SAG, receipt, notice dan auction letters ialah templates berwatermark, versioned. | Legal/Shariah/Brand luluskan wording, signature, evidence, retention dan numbering. |
| A-NOT-001 | Notifications | SMS/e-mail/WhatsApp ialah delivery simulator dengan sent/failed/retry states. | Ops/Legal luluskan content, consent, channel, provider dan evidence. |
| A-INT-001 | Integrations | Harga emas, payment, IRIS, SMS dan accounting menggunakan ports/adapters + mock payload. | Procurement/IT sahkan contract, SDK/API, DPA, SLA, sandbox dan credentials. |
| A-REP-001 | Reporting | Dashboard dan PDF/Excel report menggunakan provisional KPI dictionary. | Business/Finance luluskan metric, reconciliation, layout dan export access. |
| A-NFR-001 | NFR | Demo target: functional correctness, auditability, accessibility working target dan basic observability. | CTO/Security/BCP luluskan volume, latency, uptime, RTO/RPO, hosting dan DR. |
| A-TEST-001 | Testing | Golden fixtures dan synthetic scenarios digunakan untuk regression; expected results provisional. | Domain owners tandatangan golden dataset dan acceptance tests. |
| A-MIG-001 | Migration | Tiada legacy migration; hanya seed/demo fixtures. | Data Owner/Finance luluskan source inventory, mapping, reconciliation dan cutover. |
| A-REL-001 | Release | Demo deploy ke environment bukan produksi dengan feature flags dan kill switch. | Release/Security luluskan pipeline, approvals, rollback, monitoring dan pilot exit. |

## 5. Provisional state machine

```text
CUSTOMER_DRAFT
  -> CUSTOMER_VERIFIED
  -> PLEDGE_DRAFT
  -> PLEDGE_APPROVAL
  -> PLEDGED_ACTIVE
  -> OVERDUE
  -> AUCTION_READY
  -> AUCTION_SIMULATED
  -> SETTLEMENT_SIMULATED

PLEDGED_ACTIVE -> INSTALLMENT_SIMULATED -> PLEDGED_ACTIVE
PLEDGED_ACTIVE -> REDEMPTION_SIMULATED -> REDEEMED
Any non-terminal state -> BLOCKED / VOID_SIMULATED
```

All money, custody and legal side effects in this state machine are simulation events only.

## 6. Demo fixtures minimum

- 2 franchisors/operating contexts, 3 franchisees and 6 branches.
- 6 roles with permitted and denied actions.
- 20 customers, including repeat customer, heir, blocked and deceased scenarios.
- 30 marhun items across purity/weight/value boundaries.
- Golden cases for normal, boundary, early redemption, overdue, auction and shortfall.
- 3 provider responses per adapter: success, timeout/retry and rejected/unknown.
- 2 teller shifts, opening float, cash-in, cash-out, variance and day-end simulation.
- 2 auction lots: sold with surplus and unsold/shortfall.

## 7. Replacement workflow after contract

1. Import the signed discovery/finalization document.
2. Match each new decision to assumption IDs and requirement IDs.
3. Run impact analysis across schema, API, calculation, journal, UI, documents, tests and permissions.
4. Replace provisional fixtures with approved values and golden examples.
5. Re-run regression tests and update the traceability matrix.
6. Move status from `ASSUMED—NOT APPROVED` to `DILULUSKAN`, `DIUBAH`, `N/A` or `EXCEPTION`.
7. Recalculate build-readiness and open only the gates supported by evidence.

