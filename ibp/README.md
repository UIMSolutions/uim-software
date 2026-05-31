# Integrated Business Planning Service

<!-- markdownlint-disable MD040 MD060 MD047 -->

A vibe.d microservice in D that implements an SAP Integrated Business Planning inspired backend using a combination of clean architecture and hexagonal architecture.

The service models warehouse execution and inventory control capabilities aligned with SAP IBP process areas, including warehouse master operations, bin-level organization, task orchestration, delivery processing, handling units, and stock visibility.

## Scope

This solution is designed as an IBP-like warehouse operations core for:

- Warehouse and storage bin management
- Warehouse task orchestration and execution tracking
- Inbound and outbound delivery handling
- Handling unit lifecycle support
- Resource queue coordination
- Stock-item visibility and synchronization stubs

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
- Presentation: HTTP adapters exposing EWM-style REST APIs

## API Surface

| Method | Endpoint | Purpose |
|---|---|---|
| GET/POST/PUT/DELETE | /api/v1/ibp/demand-plans | Warehouse master records |
| GET/POST/PUT/DELETE | /api/v1/ibp/supply-plans | Storage bin structures |
| GET/POST/PUT/DELETE | /api/v1/ibp/response-plans | Warehouse task operations |
| GET/POST/PUT/DELETE | /api/v1/ibp/inventory-plans | Inbound delivery records |
| GET/POST/PUT/DELETE | /api/v1/ibp/scenario-simulations | Outbound delivery records |
| GET/POST/PUT/DELETE | /api/v1/ibp/sop-cycles | Handling unit records |
| GET/POST/PUT/DELETE | /api/v1/ibp/collaboration-workspaces | Resource and queue assignments |
| GET/POST/PUT/DELETE | /api/v1/ibp/planning-areas | Stock item views |
| POST | /api/v1/ibp/integrations/master-data-sync/:demandPlanId | Trigger warehouse sync stub |
| POST | /api/v1/ibp/integrations/analytics-sync/:scenarioId | Trigger stock sync stub |
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

### Warehouses

POST /api/v1/ibp/demand-plans

Example request body:

```json
{
  "id": "WH-100",
  "name": "Central Warehouse",
  "description": "Main distribution warehouse",
  "productNumber": "WH-100",
  "productType": "warehouse",
  "lifecycleStatus": "active",
  "category": "logistics",
  "baseUnit": "EA",
  "validFrom": "2026-01-01",
  "validTo": "2030-12-31",
  "createdBy": "planner-1"
}
```

Example response (201):

```json
{
  "id": "WH-100"
}
```

GET /api/v1/ibp/demand-plans

Example response (200):

```json
{
  "count": 1,
  "resources": [
    {
      "id": "WH-100",
      "tenantId": "T1",
      "name": "Central Warehouse",
      "description": "Main distribution warehouse"
    }
  ]
}
```

### Storage Bins

POST /api/v1/ibp/supply-plans

Example request body:

```json
{
  "id": "BIN-100",
  "demandPlanId": "WH-100",
  "name": "Aisle 01 Bin 01",
  "description": "Primary putaway bin",
  "bomType": "storage",
  "revision": "1",
  "usage": "putaway",
  "plant": "DC-01",
  "baseQuantity": "1",
  "baseUnit": "EA",
  "isActive": "true",
  "createdBy": "planner-1"
}
```

Example response (201):

```json
{
  "id": "BIN-100"
}
```

### Warehouse Tasks

POST /api/v1/ibp/response-plans

Example request body:

```json
{
  "id": "WT-10",
  "demandPlanId": "WH-100",
  "title": "Putaway pallet",
  "description": "Move inbound pallet to BIN-100",
  "priority": "high",
  "status": "open",
  "reason": "Inbound receipt",
  "impact": "Medium",
  "requestedBy": "planner-1",
  "assignedTo": "operator-7",
  "createdBy": "planner-1"
}
```

Example response (201):

```json
{
  "id": "WT-10"
}
```

### Integration Endpoints

POST /api/v1/ibp/integrations/master-data-sync/:demandPlanId

Example response (200):

```json
{
  "id": "WH-100",
  "externalId": "sap-ibp-master-WH-100",
  "message": "Stub master data sync completed for demand plan WH-100"
}
```

POST /api/v1/ibp/integrations/analytics-sync/:scenarioId

Example response (200):

```json
{
  "id": "ST-100",
  "externalId": "sap-ibp-analytics-ST-100",
  "message": "Stub analytics sync completed for scenario ST-100"
}
```

### Curl Quickstart

```bash
curl -sS -X POST http://localhost:8132/api/v1/ibp/demand-plans \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: T1" \
  -d '{"id":"WH-100","name":"Central Warehouse","description":"Main distribution warehouse","productNumber":"WH-100","productType":"warehouse","lifecycleStatus":"active","category":"logistics","baseUnit":"EA","createdBy":"planner-1"}'

curl -sS http://localhost:8132/api/v1/ibp/demand-plans

curl -sS -X POST http://localhost:8132/api/v1/ibp/integrations/master-data-sync/WH-100
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
