# Administration Guide

## Service Operations

- Start service:
  - `dub run`
- Run tests:
  - `dub test`

## Runtime Settings

- `ECM_HOST`: bind host.
- `ECM_PORT`: bind port.
- `ECM_WEB_ROOT`: static web UI folder.

## Multi-Tenant Usage

Send `X-Tenant-Id` header for tenant partitioning logic in business flows.

## Data Persistence

Current adapter uses in-memory storage for all business objects.

For production:

1. Implement `EcmRepository` in a database-backed adapter.
2. Wire the adapter in the infrastructure container.
3. Keep domain/application layers unchanged.

## API Governance Recommendations

1. Enforce authentication and authorization in an API gateway.
2. Add rate limiting per tenant.
3. Keep audit-entries enabled for all state changes.
4. Add immutable retention controls for records and retention-policies.
