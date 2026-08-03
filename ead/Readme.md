# EAD Cloud Service

This module provides an Enterprise Architecture Designer style cloud service implemented in Dlang and vibe.d.

## Scope

- Architecture repository for enterprise business objects across business, application, data, and technology layers.
- Generic CRUD API per architecture object type.
- Query APIs for search, dependency analysis, impact analysis, viewpoints, and diagram rendering.
- Clean and Hexagonal architecture with explicit domain, application, infrastructure, and presentation layers.
- Startup seeding of canonical enterprise architecture sample objects.
- OpenAPI 3 export and runtime endpoint for API discovery.
- Real Postgres and Mongo persistence adapters with automatic schema/index setup.

## Build and Run

```bash
cd ead
dub run --config=defaultRun
```

Server defaults:

- Host: 0.0.0.0
- Port: 8275
- UI: /ui

On startup the service seeds default objects when the repository is empty and exports OpenAPI spec to docs/openapi.json.
Set EAD_SEED_ENABLED=false to disable startup seeding.

## Test

```bash
cd ead
dub test --config=defaultTest
```

## Object Types

The solution includes these object categories:

- business-capabilities
- value-streams
- business-processes
- process-steps
- business-services
- organization-units
- roles
- information-objects
- data-objects
- application-components
- application-services
- interfaces
- api-definitions
- integration-flows
- technology-components
- technology-services
- systems
- landscapes
- standards
- principles
- viewpoints
- diagrams
- dependencies
- roadmaps
- work-packages
- projects
- risks
- controls
- audit-entries

## OpenAPI

- Runtime endpoint: /api/v1/ead/openapi.json
- Exported file: docs/openapi.json
- Includes component schemas for health, EAD objects, collections, command results, diagram rendering payloads, and error responses.

Override export path with EAD_OPENAPI_EXPORT_PATH.
