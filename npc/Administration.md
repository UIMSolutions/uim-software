# Administration Guide

## Service Operations

- Start service: dub run
- Run tests: dub test

## Runtime Settings

- NPC_HOST: bind host
- NPC_PORT: bind port
- NPC_WEB_ROOT: static web folder
- NPC_REPOSITORY: memory, postgres, or mongo
- NPC_POSTGRES_URL: PostgreSQL URL
- NPC_MONGO_URL: MongoDB URL
- NPC_MONGO_DATABASE: Mongo database name

## Security Middleware

- Read and write APIs require Authorization: Bearer <token>.
- Write APIs enforce role checks from X-NPC-Roles.
- Accepted write roles: npc.admin, npc.write, and <objectType>.write.

## Multi-Tenant Usage

Send X-Tenant-Id header to scope collaboration data by tenant.

## Persistence Adapters

Current adapters:

- memory: in-memory repository
- postgres: pluggable adapter shell with memory fallback
- mongo: pluggable adapter shell with memory fallback

For production:

1. Implement durable repository adapters for your database platform.
2. Keep domain/application layers unchanged.
3. Add migration scripts for planning object structures.

## Operational Recommendations

1. Enforce authentication and authorization at an API gateway.
2. Apply tenant-level quotas for scenarios and simulation runs.
3. Export alert and exception feeds to central monitoring.
4. Integrate simulation endpoint with enterprise optimization engines.
