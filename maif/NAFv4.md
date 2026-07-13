# NAFv4 Architecture Notes - MAIF Service

## Scope

This document maps a MAIF-inspired service architecture to NAFv4 style views for enterprise mobile integration and orchestration.

## Capability View (CV)

- CV-1 Capabilities:
  - Manage mobile application integration metadata.
  - Configure and maintain integration flows.
  - Track synchronization jobs and outcomes.
  - Trigger outbound publish operations to mobile backend services.
- CV-2 Dependencies:
  - Mobile app definition is a prerequisite for integration flows.
  - Integration flows are prerequisites for sync jobs.

## Operational View (OV)

- OV-1 Operational Concept:
  - Product teams register mobile apps and define integration contracts.
  - Operations teams monitor job execution and lifecycle states.
- OV-5 Activity Model:
  - Register app -> define flow -> schedule/trigger sync -> monitor status -> publish app integration profile.
- OV-6 Event Trace:
  - Publishing requires a valid app and invokes outbound gateway orchestration.

## Service-Oriented View (SOV)

- SOV-1 Service Contracts:
  - REST APIs under `/api/v1/maif`.
- SOV-2 Service Realization:
  - Inbound adapters: HTTP controllers.
  - Core application services: use-case classes.
  - Outbound adapters: in-memory repositories and mobile backend publish gateway.

## Logical View (LV)

- Main entities:
  - MobileApp
  - IntegrationFlow
  - SyncJob
- Architecture partitioning:
  - Domain core with explicit ports.
  - Application orchestration layer.
  - Infrastructure adapter layer.

## Security and Governance

- Tenant context expected from `X-Tenant-Id` header.
- Input validation enforces minimal integrity on app, flow, and sync-job lifecycle commands.
- Adapter boundary isolates publish operations from HTTP exposure.

## Deployment Guidance

- Current adapters are in-memory and suitable for development and architecture validation.
- Production profile should replace adapters with durable persistence, secure secret handling, and resilient outbound connectivity.
