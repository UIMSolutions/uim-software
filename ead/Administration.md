# Administration Guide

## Runtime Configuration

Environment variables:

- EAD_HOST (default: 0.0.0.0)
- EAD_PORT (default: 8275)
- EAD_WEB_ROOT (default: web)
- EAD_REPOSITORY (memory|postgres|mongo)
- EAD_POSTGRES_URL
- EAD_MONGO_URL
- EAD_MONGO_DATABASE
- EAD_DIAGRAM_RUNTIME_URL
- EAD_DIAGRAM_RUNTIME_BEARER_TOKEN
- EAD_DIAGRAM_RUNTIME_TIMEOUT_SECONDS
- EAD_SEED_ENABLED (default: true)
- EAD_OPENAPI_EXPORT_PATH (default: docs/openapi.json)

## Security Headers

- Authorization: Bearer <token> is required for all read/write API requests.
- X-EAD-Roles controls write access.
- Write roles accepted:
  - ead.admin
  - ead.write
  - <objectType>.write

## Deployment

Run as a standalone process:

```bash
dub run --config=defaultRun
```

Recommended deployment pattern:

- Reverse proxy with TLS termination.
- Inject OAuth/JWT access token to Authorization header.
- Add role claims mapping to X-EAD-Roles.

## Startup Behavior

- If the selected repository contains no application-components, the service seeds canonical sample enterprise architecture objects.
- OpenAPI specification is exported on startup and also available via /api/v1/ead/openapi.json.
- Set EAD_SEED_ENABLED=false to disable startup seeding in production.
