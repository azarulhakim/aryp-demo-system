-- Synthetic document and heir fixtures for assumption-based demo only.
update public.aryp_demo_seed
set payload = payload || jsonb_build_object(
  'documents', jsonb_build_array(
    jsonb_build_object('id', 'DOC-001', 'type', 'SAG', 'pledge_id', 'PLG-001', 'version', 'ASSUMED-SAG-0.1', 'state', 'DRAFT_SIMULATED', 'classification', 'CONFIDENTIAL_SYNTHETIC', 'signature_mode', 'CHECKBOX_SIMULATED', 'watermark', 'DEMO—NOT PRODUCTION'),
    jsonb_build_object('id', 'DOC-002', 'type', 'PRIVACY_CONSENT', 'customer_id', 'CUS-001', 'version', 'ASSUMED-PRIVACY-0.1', 'state', 'RECORDED_SIMULATED', 'classification', 'CONFIDENTIAL_SYNTHETIC', 'signature_mode', 'CHECKBOX_SIMULATED', 'watermark', 'DEMO—NOT PRODUCTION'),
    jsonb_build_object('id', 'DOC-003', 'type', 'AUCTION_NOTICE', 'pledge_id', 'PLG-003', 'version', 'ASSUMED-AUCTION-NOTICE-0.1', 'state', 'DRAFT_SIMULATED', 'classification', 'CONFIDENTIAL_SYNTHETIC', 'signature_mode', 'PENDING_CLIENT', 'watermark', 'DEMO—NOT PRODUCTION')
  )
)
where dataset_id = 'ARYP-DEMO-SEED-001';
