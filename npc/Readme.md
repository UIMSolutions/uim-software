# Planning Collaboration Service

This package provides a software service similar to SAP Business Network Planning Collaboration, implemented with vibe.d and D.

The design combines:

- Clean Architecture (domain and application rules are independent from transport and storage)
- Hexagonal Architecture (ports and adapters for HTTP and repository boundaries)

## Included Business Objects

- organizations
- suppliers
- customers
- products
- locations
- resources
- capacities
- demand-plans
- supply-plans
- constrained-plans
- scenarios
- assumptions
- milestones
- exceptions
- alerts
- commitments
- allocations
- collaboration-threads
- comments
- attachments
- workflows
- approvals
- kpi-definitions
- kpi-values
- api-definitions
- audit-entries

## API Overview

Base path: /api/v1/npc

- GET|POST /api/v1/npc/<objectType>
- GET|PUT|DELETE /api/v1/npc/<objectType>/:id
- GET /api/v1/npc/search/plans?q=<query>
- GET /api/v1/npc/capacities/by-resource/:resourceId
- GET /api/v1/npc/allocations/by-demand/:demandId
- POST /api/v1/npc/simulations
- GET /api/v1/npc/api-catalog

Health and UI:

- GET /
- GET /health
- GET /api/v1/health
- GET /ui

## Run

```bash
cd npc
dub run
```

Environment variables:

- NPC_HOST default 0.0.0.0
- NPC_PORT default 8490
- NPC_WEB_ROOT default web
- NPC_REPOSITORY one of memory, postgres, mongo
- NPC_POSTGRES_URL default postgresql://localhost:5432/npc
- NPC_MONGO_URL default mongodb://localhost:27017
- NPC_MONGO_DATABASE default npc

## Security Headers

Read APIs require Authorization: Bearer <token>.

Write APIs additionally require one role in X-NPC-Roles:

- npc.admin
- npc.write
- <objectType>.write

## Test

```bash
cd npc
dub test
```
