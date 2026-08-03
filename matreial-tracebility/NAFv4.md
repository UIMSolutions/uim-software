# NAFv4 Mapping

## Motivation

Provide a modular material traceability capability similar to SAP Business Network Material Traceability with business-object-centric APIs and replaceable adapters.

## Architecture Principles

- Clean Architecture for policy isolation.
- Hexagonal Architecture for inbound/outbound adapter decoupling.
- API-first integration for supply chain traceability workflows.

## Capability View

- Product identity: materials, lots, batches, serial numbers.
- Supply chain actors: suppliers, manufacturers, plants, warehouses.
- Movement and process tracking: shipment units, transport events, transformation events, consumption events.
- Compliance and quality: inspections, certificates, compliance statements.
- Risk and response: incidents, recall cases, risk assessments.
- Evidence and integration: lineage views, partner mappings, document references, API definitions.

## Logical Building Blocks

- Inbound adapters: vibe.d HTTP controllers and web UI.
- Application layer: command and query use cases.
- Domain layer: entities, validators, and repository interfaces.
- Outbound adapters: memory, PostgreSQL, and Mongo repository implementations.

## Security View

- Bearer token required for all APIs.
- Role-based write checks (mt.admin, mt.write, object-specific write roles).
- Audit entries generated for create, update, and delete events.

## Deployment Considerations

- Deploy as stateless microservice behind API gateway.
- Externalize persistence using repository adapters.
- Integrate event streams and risk engines for production recall workflows.
