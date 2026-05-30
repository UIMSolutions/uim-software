# Defense & Security Service

<!-- markdownlint-disable MD040 MD060 -->

A vibe.d microservice in D that models a cloud-native Defense & Security capability set inspired by SAP S/4HANA Defense & Security. The service follows a combination of clean architecture and hexagonal architecture so the domain stays independent from HTTP, persistence, and deployment concerns.

The solution is shaped around the SAP Defense & Security mission described in the SAP Help Portal: planning and executing operations and exercises from the domestic base, relocating and redeploying contingents, triggering downstream business processes such as purchase orders, maintenance, and budgeting, and supporting disconnected operations in communication-challenged environments.

## Scope

- Operational planning for missions, exercises, and contingents
- Relocation and redeployment orchestration
- Readiness tracking for personnel, material, and equipment
- Downstream process initiation for procurement, maintenance, and budgeting
- Support for disconnected or degraded connectivity scenarios
- Maintenance task follow-up for units, equipment, and work centers
- Budget trigger orchestration for mission-driven spending events
- Offline sync records for deferred reconciliation after disconnected operations
- Integration points for organisational structure, materials management, maintenance, flight operations, accounting, document management, and time zone handling

## Architecture

```
source/
  uim/platform/defemse/
    domain/           # Entities, repository interfaces, domain services
    application/      # DTOs and use cases
    infrastructure/   # Configuration and composition root
    presentation/     # HTTP adapters
```

### Clean Architecture

- **Domain** keeps the mission entities and business rules independent of vibe.d and storage.
- **Application** coordinates use cases such as mission planning, readiness updates, and downstream process triggers.
- **Infrastructure** provides configuration, dependency wiring, and adapter implementations.
- **Presentation** exposes HTTP endpoints and translates request/response payloads.

### Hexagonal Architecture

- **Ports** are the use cases and repository interfaces that define the service contract.
- **Adapters** are the HTTP controllers, in-memory repositories, and future external system connectors.

## Planned Capability Areas

- Operational planning
- Exercise management
- Contingent relocation and redeployment
- Personnel and equipment readiness
- Logistics and maintenance follow-up
- Budget and procurement trigger flows
- Disconnected operations support

## Initial HTTP Surface

| Method | Path | Description |
|--------|------|-------------|
| GET | `/` | Service status message |
| GET | `/health` | Health check |
| GET | `/api/v1/defemse/missions` | List mission plans |
| POST | `/api/v1/defemse/missions` | Create a mission plan |
| GET | `/api/v1/defemse/exercises` | List exercises |
| POST | `/api/v1/defemse/exercises` | Create an exercise |
| GET | `/api/v1/defemse/contingents` | List contingents |
| POST | `/api/v1/defemse/contingents` | Register a contingent |
| GET | `/api/v1/defemse/readiness` | Readiness overview |
| GET | `/api/v1/defemse/redeployment-orders` | List redeployment orders |
| GET | `/api/v1/defemse/maintenance-tasks` | List maintenance tasks |
| GET | `/api/v1/defemse/budget-triggers` | List budget triggers |
| GET | `/api/v1/defemse/offline-sync-records` | List offline sync records |
| GET | `/api/v1/health` | Global health check |

All state-changing endpoints should use `X-Tenant-Id` for tenant isolation, matching the conventions used by the other services in this repository.

## Configuration

| Environment Variable | Default | Description |
|----------------------|---------|-------------|
| `DEFEMSE_HOST` | `0.0.0.0` | HTTP bind address |
| `DEFEMSE_PORT` | `8130` | HTTP listen port |

## Build and Run

```bash
# Build
dub build

# Run
dub run

# Test
dub test
```

## Design Notes

This implementation is intentionally structured as a foundation. The first iteration focuses on the mission core, connectivity-safe orchestration, and clear boundaries between the business domain and the HTTP adapter layer. That keeps the service ready for later adapters such as database persistence, SAP integration, message-driven synchronisation, and offline sync queues.

## Reference

Based on the SAP Help Portal description for SAP S/4HANA Defense & Security.
