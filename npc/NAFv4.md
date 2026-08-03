# NAFv4 Mapping

## Motivation

Provide a modular planning collaboration capability similar to SAP Business Network Planning Collaboration with object-driven APIs and replaceable adapters.

## Architecture Principles

- Clean Architecture to isolate domain and application policy logic.
- Hexagonal Architecture for inbound and outbound adapter boundaries.
- API-first interactions for planning and collaboration flows.

## Capability View

- Master data: organizations, suppliers, customers, products, locations, resources.
- Planning data: capacities, demand plans, supply plans, constrained plans.
- Collaboration: scenarios, assumptions, commitments, collaboration threads, comments, attachments.
- Governance: milestones, exceptions, alerts, workflows, approvals, audit entries.
- Performance: KPI definitions and KPI values.

## Logical Building Blocks

- Inbound adapters: vibe.d HTTP controllers and web client.
- Application layer: command and query use cases.
- Domain layer: business object model, validators, repository interfaces.
- Outbound adapters: memory, PostgreSQL, and Mongo repository implementations.

## Security View

- Bearer token required for all APIs.
- Role-based write checks (npc.admin, npc.write, object-specific write roles).
- Audit entries generated on create, update, and delete events.

## Deployment Considerations

- Deploy as stateless service behind API gateway.
- Externalize persistence using repository adapters.
- Integrate planning optimization engines for simulation endpoint in production.
