# Administration Guide

## Service Operations

- Start service: dub run
- Run tests: dub test

## Runtime Settings

- MT_HOST: bind host
- MT_PORT: bind port
- MT_WEB_ROOT: static web folder
- MT_REPOSITORY: memory, postgres, or mongo
- MT_POSTGRES_URL: PostgreSQL URL
- MT_MONGO_URL: MongoDB URL
- MT_MONGO_DATABASE: MongoDB database name

## Security Middleware

- Read and write APIs require Authorization: Bearer <token>.
- Write APIs enforce role checks from X-MT-Roles.
- Accepted write roles: mt.admin, mt.write, and <objectType>.write.

## Multi-Tenant Usage

Send X-Tenant-Id header for tenant partitioning in traceability workflows.

## Persistence Adapters

Current adapters:

- memory: in-memory repository
- postgres: pluggable adapter shell with memory fallback
- mongo: pluggable adapter shell with memory fallback

For production:

1. Implement durable repository adapters for your target data platform.
2. Keep domain/application layers unchanged.
3. Add migration scripts for lineage and compliance entities.

## Operational Recommendations

1. Apply gateway-level authentication and throttling.
2. Integrate with event ingestion streams for near-real-time traceability.
3. Route recall and incident alerts to SOC and compliance channels.
4. Connect recall simulation endpoint to risk and optimization engines.
