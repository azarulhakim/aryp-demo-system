import { INLINE_ASSETS } from "./static-assets.js";

const JSON_HEADERS = { "content-type": "application/json; charset=utf-8", "cache-control": "no-store" };

function json(body, status = 200, extra = {}) {
  return new Response(JSON.stringify(body), { status, headers: { ...JSON_HEADERS, ...extra } });
}

function securityHeaders(headers) {
  headers.set("x-content-type-options", "nosniff");
  headers.set("referrer-policy", "no-referrer");
  headers.set("permissions-policy", "camera=(), microphone=(), geolocation=()");
  headers.set("content-security-policy", "default-src 'self'; script-src 'self' 'unsafe-inline' https://unpkg.com; style-src 'self' 'unsafe-inline'; img-src 'self' data: blob:; font-src 'self' data: https://unpkg.com; connect-src 'self' https://*.supabase.co; frame-src 'self'; object-src 'none'; base-uri 'self'; form-action 'self'; frame-ancestors 'self'");
  return headers;
}

function secured(response) {
  return new Response(response.body, { status: response.status, statusText: response.statusText, headers: securityHeaders(new Headers(response.headers)) });
}

function ready(env) {
  return env.SUPABASE_URL && env.SUPABASE_PUBLISHABLE_KEY && !env.SUPABASE_PUBLISHABLE_KEY.startsWith("SET_WITH_");
}

function proxyHeaders(request) {
  return new Headers({ authorization: request.headers.get("authorization") || "", "content-type": "application/json", "x-correlation-id": request.headers.get("x-correlation-id") || `COR-${crypto.randomUUID()}` });
}

function decodeInlineAsset(value) {
  const binary = atob(value);
  const bytes = new Uint8Array(binary.length);
  for (let index = 0; index < binary.length; index += 1) bytes[index] = binary.charCodeAt(index);
  return bytes;
}

function inlineAssetResponse(pathname) {
  const asset = INLINE_ASSETS[pathname] || (pathname === "/" ? INLINE_ASSETS["/index.html"] : null);
  if (!asset) return null;
  return secured(new Response(decodeInlineAsset(asset.body), { headers: { "content-type": asset.contentType, "cache-control": "no-store" } }));
}

async function handle(request, env) {
  const url = new URL(request.url);
  if (url.pathname === "/config.js") {
    const body = `globalThis.__ARYP_CONFIG__=${JSON.stringify({ supabaseUrl: env.SUPABASE_URL || "", supabasePublishableKey: env.SUPABASE_PUBLISHABLE_KEY || "" })};`;
    return secured(new Response(body, { headers: { "content-type": "application/javascript; charset=utf-8", "cache-control": "no-store" } }));
  }
  if (url.pathname === "/api/health" && request.method === "GET") return secured(json({ ok: true, service: "aryp-staging-worker", environment: env.ENVIRONMENT || "unknown", dataset: "ARYP-DEMO-SEED-001", status: "SYNTHETIC_ONLY" }));
  if (url.pathname.startsWith("/api/") && !ready(env)) return secured(json({ error: "staging_not_configured" }, 503));
  if (url.pathname.startsWith("/api/")) {
    const endpoint = url.pathname.slice("/api".length) || "/";
    if (!request.headers.get("authorization")) return secured(json({ error: "authentication_required" }, 401));
    const target = `${env.SUPABASE_URL}/functions/v1/aryp-api${endpoint}${url.search}`;
    const response = await fetch(target, { method: request.method, headers: proxyHeaders(request), body: request.method === "GET" || request.method === "HEAD" ? undefined : request.body });
    return secured(response);
  }
  const inlineResponse = inlineAssetResponse(url.pathname);
  if (inlineResponse) return inlineResponse;
  if (!env.ASSETS) return secured(new Response("Not found", { status: 404 }));
  return secured(await env.ASSETS.fetch(request));
}

export default { fetch: handle };
