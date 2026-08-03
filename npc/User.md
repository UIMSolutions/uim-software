# User Guide

## Accessing the Web Client

1. Start the service with dub run.
2. Open http://localhost:8490/ui.
3. Enter bearer token and NPC roles.
4. Choose object types and run CRUD or planning APIs.

## Example Object Payload

```json
{
  "technicalName": "DP_2026_Q4",
  "businessName": "Demand Plan Q4",
  "planningDomain": "Consensus Demand",
  "sourceSystem": "IBP",
  "lifecycleState": "active",
  "owner": "planner.team",
  "description": "Quarterly demand agreement",
  "metadata": {
    "region": "EMEA",
    "horizon": "13 weeks"
  },
  "createdBy": "planner.a"
}
```

## Planning APIs

- Search plans: GET /api/v1/npc/search/plans?q=plan
- Capacities by resource: GET /api/v1/npc/capacities/by-resource/<resourceId>
- Allocations by demand: GET /api/v1/npc/allocations/by-demand/<demandId>
- Simulation run: POST /api/v1/npc/simulations
- API catalog: GET /api/v1/npc/api-catalog

## Authorization

- Include Authorization: Bearer <token> for all API calls.
- Include X-NPC-Roles for write operations.
