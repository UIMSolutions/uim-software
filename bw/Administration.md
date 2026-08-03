# Administration Guide

## Service Operations

- Start service: `dub run`
- Run tests: `dub test`

## Runtime Settings

- `BW_HOST`: bind host
- `BW_PORT`: bind port
- `BW_WEB_ROOT`: static web folder
- `BW_REPOSITORY`: `memory`, `postgres`, or `mongo`
- `BW_POSTGRES_URL`: PostgreSQL URL
- `BW_MONGO_URL`: MongoDB URL
- `BW_MONGO_DATABASE`: Mongo database name
- `BW_QUERY_RUNTIME_URL`: remote runtime endpoint for query execution
- `BW_QUERY_RUNTIME_BEARER_TOKEN`: bearer token for runtime endpoint
- `BW_QUERY_RUNTIME_TIMEOUT_SECONDS`: request timeout in seconds

## Security Middleware

- Read and write APIs require `Authorization: Bearer <token>`.
- Write APIs enforce role checks using `X-BW-Roles`.
- Accepted write roles: `bw.admin`, `bw.write`, or `<objectType>.write`.

## Multi-Tenant Usage

Send `X-Tenant-Id` to scope objects per tenant domain.

## Persistence Adapters

- `memory`: in-memory repository
- `postgres`: real `psql`-driven repository with automatic schema bootstrap
- `mongo`: real `mongosh`-driven repository with automatic index bootstrap

If database CLI tooling or endpoints are unavailable, adapters fall back to in-memory behavior to keep the service operational.

## Query Runtime Integration

- If `BW_QUERY_RUNTIME_URL` is configured, query execution calls that endpoint using `curl` and returns remote JSON payloads.
- If not configured, the simulated runtime is used as deterministic fallback.

## Seed Data Operations

- PostgreSQL catalog seed:
	- `psql -d "$BW_POSTGRES_URL" -f bw/examples/sql/010_seed_bw_catalog.sql`
- MongoDB catalog seed:
	- `mongosh "$BW_MONGO_URL/$BW_MONGO_DATABASE" --file bw/examples/mongo/010_seed_bw_catalog.js`

Scripts are idempotent and can be re-run safely.

## CI Pipeline

- Workflow file: [uim-software/.github/workflows/bw-ci.yml](.github/workflows/bw-ci.yml)
- Trigger: pushes and pull requests affecting the BW package
- Stages: `dub test` and HTTP endpoint integration test script

## Operational Recommendations

1. Put the service behind an API gateway for authentication and throttling.
2. Mirror audit entries into SIEM for compliance.
3. Add tenant-level quota controls for model growth.
4. Integrate query execution endpoint with real BW runtime and resource governance.
