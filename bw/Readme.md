# Business Warehouse Service

This package delivers a software service similar to SAP Business Warehouse in Business Data Cloud, implemented with vibe.d and D.

The design combines:

- Clean Architecture (domain/application policy isolation)
- Hexagonal Architecture (inbound HTTP ports and outbound repository adapters)

## Included Business Objects

- info-areas
- info-objects
- characteristics
- key-figures
- hierarchies
- data-sources
- transformations
- data-transfer-processes
- adsos
- open-hub-destinations
- composite-providers
- cubes
- multi-providers
- queries
- workbooks
- process-chains
- analysis-authorizations
- planning-models
- aggregation-levels
- planning-functions
- data-slices
- data-flows
- api-definitions
- audit-entries

## API Overview

Base path: `/api/v1/bw`

- `GET|POST /api/v1/bw/<objectType>`
- `GET|PUT|DELETE /api/v1/bw/<objectType>/:id`
- `GET /api/v1/bw/search/models?q=<query>`
- `GET /api/v1/bw/data-flows/by-source/:sourceId`
- `GET /api/v1/bw/queries/by-provider/:providerId`
- `POST /api/v1/bw/query-executions`
- `GET /api/v1/bw/api-catalog`

Health and UI:

- `GET /`
- `GET /health`
- `GET /api/v1/health`
- `GET /ui`

## Run

```bash
cd bw
dub run
```

Environment variables:

- `BW_HOST` default `0.0.0.0`
- `BW_PORT` default `8290`
- `BW_WEB_ROOT` default `web`
- `BW_REPOSITORY` one of `memory`, `postgres`, `mongo`
- `BW_POSTGRES_URL` default `postgresql://localhost:5432/bw`
- `BW_MONGO_URL` default `mongodb://localhost:27017`
- `BW_MONGO_DATABASE` default `bw`
- `BW_QUERY_RUNTIME_URL` optional remote query runtime endpoint
- `BW_QUERY_RUNTIME_BEARER_TOKEN` optional token for remote runtime call
- `BW_QUERY_RUNTIME_TIMEOUT_SECONDS` default `15`

## Security Headers

Read APIs require `Authorization: Bearer <token>`.

Write APIs additionally require one role in `X-BW-Roles`:

- `bw.admin`
- `bw.write`
- `<objectType>.write` (example: `queries.write`)

## Test

```bash
cd bw
dub test
```

Integration test:

```bash
cd bw
bash tests/integration/http_endpoints.sh
```

## Seed Catalog Data

- PostgreSQL seed script: [bw/examples/sql/010_seed_bw_catalog.sql](bw/examples/sql/010_seed_bw_catalog.sql)
- MongoDB seed script: [bw/examples/mongo/010_seed_bw_catalog.js](bw/examples/mongo/010_seed_bw_catalog.js)
- Usage reference: [bw/examples/README.md](bw/examples/README.md)

## CI

Automated unit and integration test workflow:

- [uim-software/.github/workflows/bw-ci.yml](.github/workflows/bw-ci.yml)
