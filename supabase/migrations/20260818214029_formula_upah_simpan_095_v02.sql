-- ARYP formula v0.2: upah simpan based on net market value (NM).
-- Synthetic/provisional only; no production, legal or Shariah approval is implied.

begin;

update public.aryp_formula_versions
set status = 'RETIRED'
where formula_key = 'FINANCING_DEFAULT'
  and status = 'ACTIVE';

insert into public.aryp_formula_versions
  (id, formula_key, version, status, classification, parameters, effective_from)
values
  (
    'FORMULA-UPAH-SIMPAN-NM-095-0.2',
    'FINANCING_DEFAULT',
    'ASSUMED-UPAH-SIMPAN-0.2',
    'ACTIVE',
    'ASSUMED—NOT APPROVED',
    '{
      "calculation_type": "UPAH_SIMPAN",
      "financing_base": "NET_MARKET_VALUE",
      "margin_rate": 0.70,
      "upah_simpan_base": "NET_MARKET_VALUE",
      "upah_simpan_rate_monthly": 0.0095,
      "annualization_months": 12,
      "day_basis": 365,
      "minimum_days": 15,
      "maximum_days": 120,
      "financing_rounding": "RM0.05_FLOOR",
      "upah_simpan_rounding": "RM0.01_FINAL",
      "fee_rate": 0.00,
      "currency": "MYR-SIMULATION"
    }'::jsonb,
    now()
  )
on conflict (id) do update set
  status = excluded.status,
  classification = excluded.classification,
  parameters = excluded.parameters,
  effective_from = excluded.effective_from;

commit;
