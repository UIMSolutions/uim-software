# Integrated Business Planning Service

<!-- markdownlint-disable MD040 MD060 MD047 -->

A vibe.d microservice in D that implements an SAP Integrated Business Planning inspired backend using a combination of clean architecture and hexagonal architecture.

The service models planning capabilities aligned with SAP IBP process areas, including demand planning, supply planning, response and supply orchestration, inventory planning, scenario simulation, and collaboration-oriented planning synchronization.

## Scope

This solution is designed as an IBP-like planning core for:

- Demand plan management
- Supply plan and balancing management
- Response plan orchestration
- Inventory planning and target stock projection
- Scenario simulation and what-if evaluation
- S&OP cycle support and collaborative planning workspaces
- Planning area governance and integration synchronization stubs

## Architecture

```text
source/
  app.d
  uim/platform/ibp/
    domain/
      entities/
      integration/      # outbound integration ports
      repositories/     # persistence ports
      services/         # validation rules
      types.d
    application/
      dto.d
      usecases/manage/
      usecases/integration/
    infrastructure/
      config.d
      container.d
      persistence/memory/
      integrations/sap_ibp/   # outbound adapter stubs
    presentation/
      http/
        controllers/
        json_utils.d
```

### Clean + Hexagonal Mapping

- Domain: entities, business constraints, and abstract ports
- Application: use-case orchestration for CRUD and sync workflows
- Infrastructure: adapters for persistence and external integration
- Presentation: HTTP adapters exposing IBP-style REST APIs

## API Surface

| Method | Endpoint | Purpose |
|---|---|---|
| GET/POST/PUT/DELETE | /api/v1/ibp/demand-plans | Demand planning records |
| GET/POST/PUT/DELETE | /api/v1/ibp/supply-plans | Supply planning records |
| GET/POST/PUT/DELETE | /api/v1/ibp/response-plans | Response and supply records |
| GET/POST/PUT/DELETE | /api/v1/ibp/inventory-plans | Inventory planning records |
| GET/POST/PUT/DELETE | /api/v1/ibp/scenario-simulations | What-if planning scenarios |
| GET/POST/PUT/DELETE | /api/v1/ibp/sop-cycles | Sales and operations planning cycles |
| GET/POST/PUT/DELETE | /api/v1/ibp/collaboration-workspaces | Collaborative planning workspaces |
| GET/POST/PUT/DELETE | /api/v1/ibp/planning-areas | Planning area and model assignments |
| POST | /api/v1/ibp/integrations/master-data-sync/:demandPlanId | Trigger planning master data sync stub |
| POST | /api/v1/ibp/integrations/analytics-sync/:scenarioId | Trigger scenario analytics sync stub |
| GET | /health | Service health |
| GET | /api/v1/health | Service health |

All write operations are tenant-scoped via X-Tenant-Id.

## Endpoint Details and Examples

### Common Headers

- Content-Type: application/json
- X-Tenant-Id: tenant identifier required for all write operations

### Response Conventions

- List responses: { "count": number, "resources": [ ... ] }
- Create or update responses: { "id": "..." }
- Integration responses: { "id": "...", "externalId": "...", "message": "..." }
- Error responses: { "error": "..." }

### Demand Plans

POST /api/v1/ibp/demand-plans

Example request body:

```json
{
  "id": "DP-100",
  "name": "Baseline Demand Q3",
  "description": "Consensus demand plan for Q3",
  "productNumber": "DP-100",
  "productType": "demand",
  "lifecycleStatus": "active",
  "category": "planning",
  "baseUnit": "EA",
  "validFrom": "2026-07-01",
  "validTo": "2026-09-30",
  "createdBy": "planner-1"
}
```

Example response (201):

```json
{
  "id": "DP-100"
}
```

GET /api/v1/ibp/demand-plans

Example response (200):

```json
{
  "count": 1,
  "resources": [
    {
      "id": "DP-100",
      "tenantId": "T1",
      "name": "Baseline Demand Q3",
      "description": "Consensus demand plan for Q3"
    }
  ]
}
```

### Supply Plans

POST /api/v1/ibp/supply-plans

Example request body:

```json
{
  "id": "SP-100",
  "demandPlanId": "DP-100",
  "name": "Constrained Supply Q3",
  "description": "Supply balancing scenario",
  "bomType": "supply",
  "revision": "1",
  "usage": "planning",
  "plant": "PLN-01",
  "baseQuantity": "1",
  "baseUnit": "EA",
  "isActive": "true",
  "createdBy": "planner-1"
}
```

Example response (201):

```json
{
  "id": "SP-100"
}
```

### Response Plans

POST /api/v1/ibp/response-plans

Example request body:

```json
{
  "id": "RP-10",
  "demandPlanId": "DP-100",
  "title": "Accelerate supply lane",
  "description": "Response plan for demand spike",
  "priority": "high",
  "status": "open",
  "reason": "Forecast uplift",
  "impact": "medium",
  "requestedBy": "planner-1",
  "assignedTo": "planner-2",
  "createdBy": "planner-1"
}
```

Example response (201):

```json
{
  "id": "RP-10"
}
```

### Inventory Plans

POST /api/v1/ibp/inventory-plans

Example request body:

```json
{
  "id": "IP-100",
  "demandPlanId": "DP-100",
  "name": "Inventory Policy Q3",
  "description": "Target stock policy for critical SKUs",
  "documentType": "inventory-policy",
  "status": "active",
  "documentNumber": "INV-PLN-100",
  "fileName": "inventory-policy-q3.xlsx",
  "mimeType": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  "language": "en",
  "author": "planner-1",
  "approvedBy": "manager-1",
  "createdBy": "planner-1"
}
```

Example response (201):

```json
{
  "id": "IP-100"
}
```

### Scenario Simulations

POST /api/v1/ibp/scenario-simulations

Example request body:

```json
{
  "id": "SCN-100",
  "demandPlanId": "DP-100",
  "name": "High Demand Stress Test",
  "description": "Simulate +15% demand shift",
  "specificationType": "what-if",
  "status": "draft",
  "specificationNumber": "SCN-100",
  "property": "demand_uplift",
  "targetValue": "15",
  "unit": "percent",
  "lowerLimit": "5",
  "upperLimit": "20",
  "testMethod": "scenario-run",
  "complianceStandard": "internal-planning",
  "createdBy": "planner-1"
}
```

Example response (201):

```json
{
  "id": "SCN-100"
}
```

### S&OP Cycles

POST /api/v1/ibp/sop-cycles

Example request body:

```json
{
  "id": "SOP-100",
  "demandPlanId": "DP-100",
  "name": "Monthly S&OP July",
  "description": "July integrated planning cycle",
  "recipeType": "monthly-cycle",
  "status": "open",
  "recipeNumber": "SOP-2026-07",
  "yieldValue": "98",
  "yieldUnit": "percent",
  "batchSize": "1",
  "batchUnit": "cycle",
  "shelfLife": "30",
  "storageConditions": "cloud",
  "ingredients": "demand,supply,inventory",
  "instructions": "review-balance-approve",
  "createdBy": "planner-1"
}
```

Example response (201):

```json
{
  "id": "SOP-100"
}
```

### Collaboration Workspaces

POST /api/v1/ibp/collaboration-workspaces

Example request body:

```json
{
  "id": "CW-100",
  "demandPlanId": "DP-100",
  "title": "Q3 Reconciliation Workspace",
  "description": "Cross-functional planning collaboration",
  "collaborationType": "planning-review",
  "status": "open",
  "assignedTo": "planner-2",
  "participants": "planner-1,supply-1,finance-1",
  "dueDate": "2026-07-15",
  "resolvedDate": "",
  "resolution": "",
  "relatedDocumentId": "IP-100",
  "relatedChangeRequestId": "RP-10",
  "createdBy": "planner-1"
}
```

Example response (201):

```json
{
  "id": "CW-100"
}
```

### Planning Areas

POST /api/v1/ibp/planning-areas

Example request body:

```json
{
  "id": "PA-100",
  "demandPlanId": "DP-100",
  "name": "Global Demand-Supply Area",
  "description": "Primary planning area for global network",
  "nodeType": "planning-area",
  "parentNodeId": "ROOT",
  "childNodeIds": "REGION-EU,REGION-US",
  "quantity": "2",
  "mandatory": "true",
  "status": "active",
  "createdBy": "planner-1"
}
```

Example response (201):

```json
{
  "id": "PA-100"
}
```

### Integration Endpoints

POST /api/v1/ibp/integrations/master-data-sync/:demandPlanId

Example response (200):

```json
{
  "id": "DP-100",
  "externalId": "sap-ibp-master-DP-100",
  "message": "Stub master data sync completed for demand plan DP-100"
}
```

POST /api/v1/ibp/integrations/analytics-sync/:scenarioId

Example response (200):

```json
{
  "id": "SCN-100",
  "externalId": "sap-ibp-analytics-SCN-100",
  "message": "Stub analytics sync completed for scenario SCN-100"
}
```

### Curl Quickstart

```bash
curl -sS -X POST http://localhost:8132/api/v1/ibp/demand-plans \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: T1" \
  -d '{"id":"DP-100","name":"Baseline Demand Q3","description":"Consensus demand plan for Q3","productNumber":"DP-100","productType":"demand","lifecycleStatus":"active","category":"planning","baseUnit":"EA","createdBy":"planner-1"}'

curl -sS http://localhost:8132/api/v1/ibp/demand-plans

curl -sS -X POST http://localhost:8132/api/v1/ibp/integrations/master-data-sync/DP-100
```

## Configuration

| Variable | Default | Purpose |
|---|---|---|
| IBP_HOST | 0.0.0.0 | HTTP bind address |
| IBP_PORT | 8132 | HTTP listen port |

## Container and Kubernetes

- Container build files: Containerfile and Dockerfile in the IBP root
- Kubernetes manifests: k8s/configmap.yaml, k8s/deployment.yaml, k8s/service.yaml

```bash
docker build -t uim-platform/ibp -f Dockerfile .
kubectl apply -f k8s/
```

## Build and Run

```bash
dub build
dub run
dub test
```

## SAP Reference

Based on SAP Help Portal documentation for SAP Integrated Business Planning:

[https://help.sap.com/docs/SAP_INTEGRATED_BUSINESS_PLANNING?locale=en-US](https://help.sap.com/docs/SAP_INTEGRATED_BUSINESS_PLANNING?locale=en-US)
