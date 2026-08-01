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
- `ECM_REPOSITORY`: choose `memory`, `postgres`, or `mongo`.
- `ECM_POSTGRES_URL`: PostgreSQL connection URL.
- `ECM_MONGO_URL`: MongoDB connection URL.
- `ECM_MONGO_DATABASE`: Mongo database name.

## Security Middleware

- All read and write APIs require `Authorization: Bearer <token>`.
- Write APIs enforce role-based access from `X-ECM-Roles`.
- Accepted write roles: `ecm.admin`, `ecm.write`, or `<objectType>.write`.

## Multi-Tenant Usage

Send `X-Tenant-Id` header for tenant partitioning logic in business flows.

## Data Persistence

Current adapter supports:

- `memory`: in-memory persistence
- `postgres`: PostgreSQL persistence via `psql`
- `mongo`: MongoDB persistence via `mongosh`

For production:

1. Implement `EcmRepository` in a database-backed adapter.
2. Wire the adapter in the infrastructure container.
3. Keep domain/application layers unchanged.

## Migrations

- PostgreSQL migration script: `examples/sql/001_init_ecm.sql`
- Mongo migration script: `examples/mongo/001_init_ecm.js`

Automatic bootstrap runs at service start for `postgres` and `mongo` adapters.

## API Governance Recommendations

1. Enforce authentication and authorization in an API gateway.
2. Add rate limiting per tenant.
3. Keep audit-entries enabled for all state changes.
4. Add immutable retention controls for records and retention-policies.
