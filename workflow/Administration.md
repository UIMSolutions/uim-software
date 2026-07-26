# Administration Guide

## Service Operations

1. Build the service:

```bash
cd workflow
dub build
```

1. Run the service:

```bash
dub run
```

1. Validate with tests:

```bash
dub test
```

## Runtime Configuration

- `WORKFLOW_HOST`: bind host, default `0.0.0.0`
- `WORKFLOW_PORT`: bind port, default `8148`
- `WORKFLOW_STORAGE`: repository adapter mode, `memory` (default) or `file`
- `WORKFLOW_STORAGE_PATH`: directory used by file-backed adapters, default `.data/workflow`

Example:

```bash
WORKFLOW_HOST=0.0.0.0 WORKFLOW_PORT=8148 WORKFLOW_STORAGE=file WORKFLOW_STORAGE_PATH=.data/workflow dub run
```

## Health Checks

- Liveness: `GET /health`
- API health: `GET /api/v1/health`
- OpenAPI: `GET /api/v1/openapi.yaml`

## Multi-tenant Governance

The platform uses `X-Tenant-Id` on write operations.

Recommended policy:

1. Enforce non-empty tenant IDs in API gateway.
2. Use scoped service accounts for integration clients.
3. Log tenant, actor, and endpoint for every change operation.

## Backup and Persistence

Current implementation uses in-memory repositories intended for reference and testing. For production:

1. Replace memory adapters with persistent adapters (SQL/NoSQL).
2. Add migration/versioning for schema evolution.
3. Enable immutable audit trail for decisions and escalations.

## Security Recommendations

1. Front all endpoints with OAuth2/OpenID Connect.
2. Apply authorization by role:
   - Starter
   - Approver
   - Administrator
3. Redact sensitive context values in logs.
4. Enable HTTPS termination at ingress.
