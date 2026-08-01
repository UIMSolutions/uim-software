# NAFv4 Mapping

## Motivation

Provide a modular ECM capability with business-object centric APIs and clear separation of concerns.

## Architecture Principles

- Clean Architecture for policy isolation.
- Hexagonal Architecture for adapter replacement.
- API-first interaction via REST endpoints.

## Capability View

- Content structure: repositories, workspaces, folders.
- Content assets: documents, versions, metadata categories.
- Governance: records, retention policies, audit entries.
- Access model: users, groups, permissions.
- Process model: workflows.

## Logical Building Blocks

- Inbound adapters: vibe.d HTTP controllers.
- Application layer: use cases for command and query operations.
- Domain layer: business object model and validation.
- Outbound adapters: memory, PostgreSQL, and Mongo repository implementations.

## Security View

- Middleware-style auth guard validates bearer token for read/write access.
- Role checks (`ecm.admin`, `ecm.write`, and object-specific write role) protect state changes.
- Audit entries are generated for create/update/delete operations.

## Deployment Considerations

- Containerize the service for cloud deployment.
- Use managed datastore adapters in production.
- Integrate IAM for user/group/permission controls.
