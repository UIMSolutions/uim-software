# Enterprise Portfolio and Project Management Service

<!-- markdownlint-disable MD040 MD060 MD047 -->

A vibe.d microservice in D that models enterprise portfolio and project management capabilities inspired by SAP S/4HANA Enterprise Portfolio and Project Management.

The service uses a combination of clean architecture and hexagonal architecture to keep domain logic independent from transport and persistence concerns.

## Scope

The solution focuses on the core planning and execution areas typically needed in enterprise portfolio and project management:

- Portfolio planning and prioritization
- Initiative intake and governance
- Program orchestration
- Project execution and status tracking
- Demand capture and qualification
- Resource request and staffing visibility

## Architecture

```text
source/
  uim/platform/ppm/
    domain/           # Entities, repository ports, domain validation
    application/      # DTOs and use-case orchestration
    infrastructure/   # Configuration, composition root, memory adapters
    presentation/     # HTTP controllers and JSON serialization
```

### Clean Architecture mapping

- Domain: business entities and rules
- Application: use cases that coordinate domain behavior
- Infrastructure: adapter wiring and runtime composition
- Presentation: REST endpoints and request or response mapping

### Hexagonal Architecture mapping

- Inbound ports: use-case classes called by HTTP adapters
- Outbound ports: repository interfaces in domain layer
- Adapters: vibe.d controllers and in-memory repositories

## Initial API Surface

| Method | Path | Description |
|--------|------|-------------|
| GET | / | Service root |
| GET | /health | Local health check |
| GET | /api/v1/health | Platform health check |
| GET | /api/v1/ppm/portfolios | List portfolios |
| POST | /api/v1/ppm/portfolios | Create portfolio |
| GET | /api/v1/ppm/initiatives | List initiatives |
| POST | /api/v1/ppm/initiatives | Create initiative |
| GET | /api/v1/ppm/programs | List programs |
| POST | /api/v1/ppm/programs | Create program |
| GET | /api/v1/ppm/projects | List projects |
| POST | /api/v1/ppm/projects | Create project |
| GET | /api/v1/ppm/demands | List demands |
| POST | /api/v1/ppm/demands | Create demand |
| GET | /api/v1/ppm/resource-requests | List resource requests |
| POST | /api/v1/ppm/resource-requests | Create resource request |

All write operations are tenant-scoped through X-Tenant-Id.

## Configuration

| Environment Variable | Default | Description |
|----------------------|---------|-------------|
| PPM_HOST | 0.0.0.0 | HTTP bind address |
| PPM_PORT | 8141 | HTTP port |
| PPM_PERSISTENCE_ENGINE | memory | Persistence adapter mode: memory or postgres |
| PPM_POSTGRES_URL | postgres://ppm:ppm@localhost:5432/ppm | PostgreSQL connection string used when persistence mode is postgres |

## Example Scripts

```bash
# Seed demo records
./examples/seed-data.sh

# Run smoke test (expects service running)
./examples/smoke-test.sh
```

For custom endpoint or tenant:

```bash
BASE_URL=http://localhost:8141 TENANT=T1 ./examples/smoke-test.sh
```

## Persistence Adapters

Repository ports remain unchanged while infrastructure selects adapters at runtime.

- memory: in-process repositories (default)
- postgres: SQL repositories executed via psql CLI selected with PPM_PERSISTENCE_ENGINE=postgres

```bash
PPM_PERSISTENCE_ENGINE=postgres \
PPM_POSTGRES_URL=postgres://ppm:ppm@localhost:5432/ppm \
dub run
```

When postgres mode is active, startup executes schema bootstrap statements equivalent to [ppm/examples/sql/001_init_ppm.sql](ppm/examples/sql/001_init_ppm.sql).

Postgres mode requires the psql CLI to be available on PATH.

## Build and Run

```bash
dub build
dub run
dub test
```

## SAP Alignment

This module follows SAP Enterprise Portfolio and Project Management themes from SAP S/4HANA help content, especially portfolio governance, project execution, and enterprise resource coordination.
