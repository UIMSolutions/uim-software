# NAFv4 Mapping

## Motivation

Provide a modular cloud-native Production Planning service aligned with S/4HANA PP concepts.

## Capability View

- Master data: materials, plants, work centers, routings, BOMs, production versions.
- Planning data: demand programs, MRP areas, MRP runs.
- Execution data: planned orders, production orders, operations, confirmations, capacity requirements.

## Architecture Principles

- Clean Architecture for business policy isolation.
- Hexagonal Architecture for adapter replaceability.
- API-first service contract over REST.

## Logical Building Blocks

- Inbound adapters: vibe.d HTTP controllers and web UI.
- Application layer: object management and MRP orchestration use cases.
- Domain layer: business object model and validation.
- Outbound adapters: in-memory repository with pluggable persistence port.

## Deployment Considerations

- Package into a container image for cloud deployment.
- Add persistent storage adapter for production.
- Integrate identity and role-based authorization at API boundary.
