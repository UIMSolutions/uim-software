# Manufacturing Execution Service

<!-- markdownlint-disable MD040 MD060 MD047 -->

A vibe.d microservice in D that implements an SAP Manufacturing Execution inspired backend using a combination of clean architecture and hexagonal architecture.

The service models shop-floor execution capabilities aligned with SAP MES process areas, including production order execution, operation dispatching, work center assignment, event collection, quality inspection workflows, and traceability synchronization.

## Scope

This solution is designed as an MES-like execution core for:

- Production order lifecycle management
- Operation dispatch and sequencing
- Work center assignment and execution tracking
- Shop floor event capture and status progression
- In-process and final quality inspection records
- Batch records and electronic manufacturing history
- Operator collaboration and production traceability integration stubs

## Architecture

```text
source/
  app.d
  uim/platform/mes/
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
      integrations/sap_mes/   # outbound adapter stubs
    presentation/
      http/
        controllers/
        json_utils.d
```

### Clean + Hexagonal Mapping

- Domain: entities, business constraints, and abstract ports
- Application: use-case orchestration for CRUD and sync workflows
- Infrastructure: adapters for persistence and external integration
- Presentation: HTTP adapters exposing MES-style REST APIs

## API Surface

| Method | Endpoint | Purpose |
|---|---|---|
| GET/POST/PUT/DELETE | /api/v1/mes/production-orders | Production order records |
| GET/POST/PUT/DELETE | /api/v1/mes/operations | Operation records |
| GET/POST/PUT/DELETE | /api/v1/mes/work-center-assignments | Work center execution assignments |
| GET/POST/PUT/DELETE | /api/v1/mes/shop-floor-events | Shop floor event logs |
| GET/POST/PUT/DELETE | /api/v1/mes/quality-inspections | Quality inspection records |
| GET/POST/PUT/DELETE | /api/v1/mes/batch-records | Batch history records |
| GET/POST/PUT/DELETE | /api/v1/mes/operator-collaborations | Operator collaboration tasks |
| GET/POST/PUT/DELETE | /api/v1/mes/production-traceability | Production traceability structures |
| POST | /api/v1/mes/integrations/order-sync/:orderId | Trigger order synchronization stub |
| POST | /api/v1/mes/integrations/quality-sync/:inspectionId | Trigger quality synchronization stub |
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

### Production Orders

POST /api/v1/mes/production-orders

Example request body:

```json
{
  "id": "PO-100",
  "name": "Pump Assembly Order",
  "description": "Execute pump line order",
  "productNumber": "PO-100",
  "productType": "production",
  "lifecycleStatus": "released",
  "category": "manufacturing",
  "baseUnit": "EA",
  "validFrom": "2026-06-01",
  "validTo": "2026-06-30",
  "createdBy": "operator-1"
}
```

Example response (201):

```json
{
  "id": "PO-100"
}
```

GET /api/v1/mes/production-orders

Example response (200):

```json
{
  "count": 1,
  "resources": [
    {
      "id": "PO-100",
      "tenantId": "T1",
      "name": "Pump Assembly Order",
      "description": "Execute pump line order"
    }
  ]
}
```

### Operations

POST /api/v1/mes/operations

Example request body:

```json
{
  "id": "OP-100",
  "orderId": "PO-100",
  "name": "Assembly Operation 10",
  "description": "Primary assembly step",
  "bomType": "operation",
  "revision": "1",
  "usage": "execution",
  "plant": "LINE-01",
  "baseQuantity": "1",
  "baseUnit": "EA",
  "isActive": "true",
  "createdBy": "operator-1"
}
```

Example response (201):

```json
{
  "id": "OP-100"
}
```

### Work Center Assignments

POST /api/v1/mes/work-center-assignments

Example request body:

```json
{
  "id": "WCA-10",
  "orderId": "PO-100",
  "title": "Assign Work Center WC-01",
  "description": "Route order to WC-01",
  "priority": "high",
  "status": "open",
  "reason": "Initial dispatch",
  "impact": "Medium",
  "requestedBy": "operator-1",
  "assignedTo": "operator-2",
  "createdBy": "operator-1"
}
```

Example response (201):

```json
{
  "id": "WCA-10"
}
```

### Integration Endpoints

POST /api/v1/mes/integrations/order-sync/:orderId

Example response (200):

```json
{
  "id": "PO-100",
  "externalId": "sap-mes-order-PO-100",
  "message": "Stub order sync completed for production order PO-100"
}
```

POST /api/v1/mes/integrations/quality-sync/:inspectionId

Example response (200):

```json
{
  "id": "QI-100",
  "externalId": "sap-mes-quality-QI-100",
  "message": "Stub quality sync completed for inspection QI-100"
}
```

### Curl Quickstart

```bash
curl -sS -X POST http://localhost:8132/api/v1/mes/production-orders \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: T1" \
  -d '{"id":"PO-100","name":"Pump Assembly Order","description":"Execute pump line order","productNumber":"PO-100","productType":"production","lifecycleStatus":"released","category":"manufacturing","baseUnit":"EA","createdBy":"operator-1"}'

curl -sS http://localhost:8132/api/v1/mes/production-orders

curl -sS -X POST http://localhost:8132/api/v1/mes/integrations/order-sync/PO-100
```

## Configuration

| Variable | Default | Purpose |
|---|---|---|
| MES_HOST | 0.0.0.0 | HTTP bind address |
| MES_PORT | 8132 | HTTP listen port |

## Container and Kubernetes

- Container build files: Containerfile and Dockerfile in the MES root
- Kubernetes manifests: k8s/configmap.yaml, k8s/deployment.yaml, k8s/service.yaml

```bash
docker build -t uim-platform/mes -f Dockerfile .
kubectl apply -f k8s/
```

## Build and Run

```bash
dub build
dub run
dub test
```

## SAP Reference

Based on SAP Help Portal documentation for SAP Manufacturing Execution:

[https://help.sap.com/docs/SAP_MANUFACTURING_EXECUTION?locale=en-US](https://help.sap.com/docs/SAP_MANUFACTURING_EXECUTION?locale=en-US)
