# Returnable Packaging Management (RPM)

This package provides a D/vibe.d implementation of a Returnable Packaging Management solution inspired by SAP RPM concepts, using a combined Clean Architecture and Hexagonal Architecture style.

## Scope

The service includes:

- Core business objects for packaging assets, pools, partners, locations, shipments, returns, quality, repairs, cleaning, inventory, telemetry, alerts, and invoicing.
- Generic CRUD APIs per business object type.
- Operational APIs for check-in/out, transfer, cleaning, repair, and inspection flows.
- Query APIs for search, pool balances, asset traceability, and KPI summaries.
- In-memory adapter and simulated analytics runtime.
- Unit tests inside domain, application, and infrastructure modules.
- A simple web client at `GET /ui`.

## Architecture

- Domain layer: entities, repository ports, validation service.
- Application layer: DTOs, use cases, runtime ports.
- Infrastructure layer: configuration, dependency container, memory persistence, simulated analytics adapter.
- Presentation layer: HTTP controllers and JSON mapping.

This split keeps business rules independent from delivery details and adapters.

## Business Objects

The following object types are available under `/api/v1/rpm/<objectType>`:

- `packaging-materials`
- `packaging-pools`
- `packaging-owners`
- `partners`
- `locations`
- `depots`
- `lanes`
- `shipment-orders`
- `shipment-items`
- `return-orders`
- `return-items`
- `rental-contracts`
- `quality-inspections`
- `cleaning-orders`
- `repair-orders`
- `transfer-orders`
- `inventory-snapshots`
- `cycle-counts`
- `serial-assets`
- `telemetry-events`
- `alerts`
- `invoices`
- `api-definitions`
- `audit-entries`

## Key APIs

### Health and UI

- `GET /`
- `GET /health`
- `GET /api/v1/health`
- `GET /ui`

### CRUD

- `GET /api/v1/rpm/<objectType>`
- `GET /api/v1/rpm/<objectType>/<id>`
- `POST /api/v1/rpm/<objectType>`
- `PUT /api/v1/rpm/<objectType>/<id>`
- `DELETE /api/v1/rpm/<objectType>/<id>`

### Operations and Analytics

- `POST /api/v1/rpm/operations`
- `GET /api/v1/rpm/search/models?q=<term>`
- `GET /api/v1/rpm/trace/<assetId>`
- `GET /api/v1/rpm/pool-balances/<poolId>`
- `GET /api/v1/rpm/kpis?from=YYYY-MM-DD&to=YYYY-MM-DD`

## Security Headers

All APIs require:

- `Authorization: Bearer <token>`

Write operations additionally require one of:

- `X-RPM-Roles: rpm.admin`
- `X-RPM-Roles: rpm.write`
- `X-RPM-Roles: <objectType>.write`

## Local Run

```bash
cd rpm
dub run
```

Environment variables:

- `RPM_HOST` (default `0.0.0.0`)
- `RPM_PORT` (default `8390`)
- `RPM_WEB_ROOT` (default `web`)
- `RPM_REPOSITORY` (default `memory`)

## Tests

```bash
cd rpm
dub test
```

## Notes

This solution is implementation-ready for extension with persistent adapters (PostgreSQL, MongoDB, SAP integrations) while preserving use case and domain boundaries.
