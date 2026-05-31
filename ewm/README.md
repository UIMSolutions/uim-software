# Extended Warehouse Management Service

<!-- markdownlint-disable MD040 MD060 MD047 -->

A vibe.d microservice in D that implements an SAP Extended Warehouse Management inspired backend using a combination of clean architecture and hexagonal architecture.

The service models warehouse execution and inventory control capabilities aligned with SAP EWM process areas, including warehouse master operations, bin-level organization, task orchestration, delivery processing, handling units, and stock visibility.

## Scope

This solution is designed as an EWM-like warehouse operations core for:

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
  uim/platform/ewm/
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
      integrations/sap_ewm/   # outbound adapter stubs
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
| GET/POST/PUT/DELETE | /api/v1/ewm/warehouses | Warehouse master records |
| GET/POST/PUT/DELETE | /api/v1/ewm/storage-bins | Storage bin structures |
| GET/POST/PUT/DELETE | /api/v1/ewm/warehouse-tasks | Warehouse task operations |
| GET/POST/PUT/DELETE | /api/v1/ewm/inbound-deliveries | Inbound delivery records |
| GET/POST/PUT/DELETE | /api/v1/ewm/outbound-deliveries | Outbound delivery records |
| GET/POST/PUT/DELETE | /api/v1/ewm/handling-units | Handling unit records |
| GET/POST/PUT/DELETE | /api/v1/ewm/resource-queues | Resource and queue assignments |
| GET/POST/PUT/DELETE | /api/v1/ewm/stock-items | Stock item views |
| POST | /api/v1/ewm/integrations/warehouse-master-sync/:warehouseId | Trigger warehouse sync stub |
| POST | /api/v1/ewm/integrations/stock-sync/:stockId | Trigger stock sync stub |
| GET | /health | Service health |
| GET | /api/v1/health | Service health |

All write operations are tenant-scoped via X-Tenant-Id.

## Configuration

| Variable | Default | Purpose |
|---|---|---|
| EWM_HOST | 0.0.0.0 | HTTP bind address |
| EWM_PORT | 8132 | HTTP listen port |

## Container and Kubernetes

- Container build files: Containerfile and Dockerfile in the EWM root
- Kubernetes manifests: k8s/configmap.yaml, k8s/deployment.yaml, k8s/service.yaml

```bash
docker build -t uim-platform/ewm -f Dockerfile .
kubectl apply -f k8s/
```

## Build and Run

```bash
dub build
dub run
dub test
```

## SAP Reference

Based on SAP Help Portal documentation for SAP Extended Warehouse Management:

[https://help.sap.com/docs/SAP_EXTENDED_WAREHOUSE_MANAGEMENT?locale=en-US](https://help.sap.com/docs/SAP_EXTENDED_WAREHOUSE_MANAGEMENT?locale=en-US)
