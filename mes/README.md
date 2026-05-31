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
