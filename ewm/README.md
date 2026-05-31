# Warehouse Management Service

<!-- markdownlint-disable MD040 MD060 MD047 -->

A vibe.d microservice in D that implements an SAP Extended Warehouse Management for SAP S/4HANA inspired backend using a combination of clean architecture and hexagonal architecture.

The service models core engineering control capabilities around CAD-driven product data management, document control, structure governance, engineering change, and synchronization with SAP S/4HANA business objects.

## Scope

This solution is designed as an EWM-like engineering integration core for:

- CAD document metadata and version control
- Material and engineering object master synchronization
- Engineering BOM and assembly structure governance
- Engineering change request tracking
- Engineering workspace collaboration
- Document info record and material master synchronization stubs

## Architecture

```text
source/
  app.d
  uim/platform/ecc/
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
- Application: orchestration use cases for CRUD and sync workflows
- Infrastructure: adapters for persistence and external integration
- Presentation: HTTP adapters exposing ECC-facing REST APIs

## API Surface

| Method | Endpoint | Purpose |
|---|---|---|
| GET/POST/PUT/DELETE | /api/v1/ewm/warehouses | Engineering material records |
| GET/POST/PUT/DELETE | /api/v1/ewm/storage-bins | Engineering BOM structures |
| GET/POST/PUT/DELETE | /api/v1/ewm/warehouse-tasks | Engineering change management |
| GET/POST/PUT/DELETE | /api/v1/ewm/inbound-deliveries | CAD and engineering document metadata |
| GET/POST/PUT/DELETE | /api/v1/ewm/outbound-deliveries | Classification and document attribute metadata |
| GET/POST/PUT/DELETE | /api/v1/ewm/handling-units | CAD item metadata and references |
| GET/POST/PUT/DELETE | /api/v1/ewm/resource-queues | Engineering collaboration workspaces |
| GET/POST/PUT/DELETE | /api/v1/ewm/stock-items | Product assembly hierarchy |
| POST | /api/v1/ewm/integrations/warehouse-master-sync/:warehouseId | Trigger material master sync stub |
| POST | /api/v1/ewm/integrations/stock-sync/:stockId | Trigger document info record sync stub |
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

Based on SAP Help Portal documentation for SAP Extended Warehouse Management for SAP S/4HANA:

[https://help.sap.com/docs/SAP_EXTENDED_WAREHOUSE_MANAGEMENT?locale=en-US](https://help.sap.com/docs/SAP_EXTENDED_WAREHOUSE_MANAGEMENT?locale=en-US)
