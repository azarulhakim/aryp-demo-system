# ARYP Demo System

Synthetic AR-Rahnu YaPEIM Premier demo system based on the current assumption baseline. The project contains:

- `platform/worker/` — Cloudflare Worker shell and staging/production static UI.
- `supabase/` — database migrations and the authenticated `aryp-api` Edge Function.
- `app/` — local demo server and smoke tests.
- `outputs/` — handoff documents, user manual and selected demo artefacts.

## Demo environments

- Staging: <https://aryp-staging.rsshost.workers.dev>
- Production-named simulation: <https://aryp-production.rsshost.workers.dev>

Both environments are synthetic-only. They must not be used for real customer data, live money movement or production regulatory decisions.

## Demo accounts

The staging login page provides the master franchisor, franchisee, branch and audit demo accounts. The shared synthetic password is shown on the staging login page. Branch accounts are labelled by branch ID and are intended only for client demonstrations.

## Local checks

```text
cd app
npm install
npm test
```

For the Worker package:

```text
cd platform/worker
npm install
npm run check
```

Never commit `.env`, `.dev.vars`, service-role keys, or real customer information.
