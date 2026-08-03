# NAFv4 Mapping

## Motivation

Provide a modular Business Warehouse capability in Business Data Cloud style with object-centric APIs and explicit architecture boundaries.

## Architecture Principles

- Clean Architecture for policy and rule isolation.
- Hexagonal Architecture for adapter portability.
- API-first integration for analytics and planning workflows.

## Capability View

- Metadata layer: info areas, info objects, characteristics, key figures, hierarchies.
- Data provisioning: data sources, transformations, DTPs, data flows.
- Modeling layer: ADSOs, composite providers, cubes, multi providers.
- Consumption layer: queries, workbooks, API definitions.
- Planning layer: planning models, aggregation levels, planning functions, data slices.
- Governance and security: analysis authorizations and audit entries.

## Logical Building Blocks

- Inbound adapters: vibe.d HTTP controllers for CRUD and BW query endpoints.
- Application layer: manage and query use cases.
- Domain layer: object model, validation rules, repository ports.
- Outbound adapters: memory repository, PostgreSQL and Mongo repositories, and query runtime adapters (simulated or remote).

## Security View

- Bearer token required on all APIs.
- Role-based write checks (`bw.admin`, `bw.write`, `<objectType>.write`).
- Audit entries generated on create, update, and delete.

## Deployment Considerations

- Containerize and deploy as a stateless microservice.
- Externalize persistence through repository adapter implementation.
- Integrate enterprise IAM and query governance before production rollout.
