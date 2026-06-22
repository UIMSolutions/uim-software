# Manufacturing Integration and Intelligence Service

<!-- markdownlint-disable MD040 MD060 MD047 -->

A vibe.d microservice in D that implements an SAP Manufacturing Integration and Intelligence inspired backend using a combination of clean architecture and hexagonal architecture.

The service models manufacturing connectivity and intelligence capabilities aligned with SAP MII process areas, including production message ingestion, work center event processing, KPI aggregation, alert notification handling, workflow orchestration, dashboard integration, and enterprise synchronization.

## Scope

This solution is designed as an MII-like integration and intelligence core for:

- Production message ingestion and normalization
- Work center event processing
- Data collection and KPI observation records
- Alert notification and escalation support
- Workflow instance orchestration
- Dashboard widget data exchange
- Integration endpoint governance and synchronization stubs

## Architecture

```text
source/
  app.d
  uim/platform/mii/
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
      integrations/sap_mii/   # outbound adapter stubs
    presentation/
      http/
        controllers/
        json_utils.d
```

### Clean + Hexagonal Mapping

- Domain: entities, business constraints, and abstract ports
- Application: use-case orchestration for CRUD and sync workflows
- Infrastructure: adapters for persistence and external integration
- Presentation: HTTP adapters exposing MII-style REST APIs

## API Surface

| Method | Endpoint | Purpose |
|---|---|---|
| GET/POST/PUT/DELETE | /api/v1/mii/production-messages | Production integration messages |
| GET/POST/PUT/DELETE | /api/v1/mii/work-center-events | Work center event records |
| GET/POST/PUT/DELETE | /api/v1/mii/data-collections | Data collection records |
| GET/POST/PUT/DELETE | /api/v1/mii/kpi-observations | KPI observation records |
| GET/POST/PUT/DELETE | /api/v1/mii/alert-notifications | Alert and notification records |
| GET/POST/PUT/DELETE | /api/v1/mii/workflow-instances | Workflow execution instances |
| GET/POST/PUT/DELETE | /api/v1/mii/dashboard-widgets | Dashboard widget data views |
| GET/POST/PUT/DELETE | /api/v1/mii/integration-endpoints | Integration endpoint definitions |
| POST | /api/v1/mii/integrations/erp-message-sync/:messageId | Trigger ERP message sync stub |
| POST | /api/v1/mii/integrations/analytics-sync/:alertId | Trigger analytics sync stub |
| GET | /health | Service health |
| GET | /api/v1/health | Service health |

All write operations are tenant-scoped via X-Tenant-Id.

## Configuration

| Variable | Default | Purpose |
|---|---|---|
| MII_HOST | 0.0.0.0 | HTTP bind address |
| MII_PORT | 8132 | HTTP listen port |

## Container and Kubernetes

- Container build files: Containerfile and Dockerfile in the MII root
- Kubernetes manifests: k8s/configmap.yaml, k8s/deployment.yaml, k8s/service.yaml

```bash
docker build -t uim-platform/mii -f Dockerfile .
kubectl apply -f k8s/
```

## Build and Run

```bash
dub build
dub run
dub test
```

## SAP Reference

Based on SAP Help Portal documentation for SAP Manufacturing Integration and Intelligence:

[https://help.sap.com/docs/SAP_MANUFACTURING_INTEGRATION_AND_INTELLIGENCE?locale=en-US](https://help.sap.com/docs/SAP_MANUFACTURING_INTEGRATION_AND_INTELLIGENCE?locale=en-US)
