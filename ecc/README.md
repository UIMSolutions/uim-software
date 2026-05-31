# Engineering Control Center Service

<!-- markdownlint-disable MD040 MD060 MD047 -->

A vibe.d microservice in D that implements an SAP Engineering Control Center inspired domain model using clean architecture and hexagonal architecture.

The service follows the SAP Help positioning of Engineering Control Center as a cloud solution that digitally orchestrates product development from design to operate to reduce time to market, improve R&D ROI, and enable reliable product launches.

## Why This Service

This service provides an extensible backend foundation for key SAP ECC process areas, with initial support for:

- Engineering product master and lifecycle states
- Enterprise product structure and BOM governance
- Engineering change tracking and impact visibility
- Specification and recipe or formulation data
- Collaboration tasks across engineering functions
- Product data handover readiness to downstream systems

## Architecture Style

The implementation combines clean architecture and hexagonal architecture:

- Domain: Entities, types, business validation rules, repository ports
- Application: Use cases and DTO mapping
- Infrastructure: Configuration and dependency wiring
- Presentation: HTTP adapters with vibe.d controllers

Ports and adapters:

- Primary adapters: HTTP REST controllers
- Secondary adapters: In-memory repositories (replaceable by DB adapters)
- Core ports: Repository interfaces and use-case APIs

## Source Layout

```text
source/
  app.d
  uim/platform/ecc/
    domain/
      entities/
      integration/
      repositories/
      services/
      types.d
    application/
      dto.d
      usecases/integration/
      usecases/manage/
    infrastructure/
      config.d
      container.d
      integrations/sap_ecc/
      persistence/memory/
    presentation/
      http/
        controllers/
        json_utils.d
```

## Initial API Surface

| Method | Endpoint | Capability Area |
|---|---|---|
| GET | / | Service status |
| GET | /health | Health check |
| GET | /api/v1/health | Platform health check |
| GET/POST/PUT/DELETE | /api/v1/ecc/materials | Engineering product data |
| GET/POST/PUT/DELETE | /api/v1/ecc/boms | Enterprise product structure |
| GET/POST/PUT/DELETE | /api/v1/ecc/change-requests | Configuration and change management |
| GET/POST/PUT/DELETE | /api/v1/ecc/documents | Engineering documentation |
| GET/POST/PUT/DELETE | /api/v1/ecc/document-attributes | Specification management |
| GET/POST/PUT/DELETE | /api/v1/ecc/cad-items | Formulation support |
| GET/POST/PUT/DELETE | /api/v1/ecc/workspaces | Collaboration |
| GET/POST/PUT/DELETE | /api/v1/ecc/assembly-structures | Product hierarchy |
| POST | /api/v1/ecc/integrations/material-master-sync/:productId | Product handover stub |
| POST | /api/v1/ecc/integrations/document-info-record-sync/:specificationId | Specification sync stub |

All state-changing requests are tenant-scoped via X-Tenant-Id.

## Configuration

| Variable | Default | Purpose |
|---|---|---|
| ECC_HOST | 0.0.0.0 | Bind host |
| ECC_PORT | 8132 | HTTP port |

## Container and Kubernetes

- Container build files: Containerfile and Dockerfile in the EPD root
- Kubernetes manifests: k8s/configmap.yaml, k8s/deployment.yaml, k8s/service.yaml

Example commands:

```bash
docker build -t uim-platform/ecc -f Dockerfile .
kubectl apply -f k8s/
```

## Build and Run

```bash
dub build
dub run
dub test
```

## SAP ECC Alignment Notes

Aligned to SAP Engineering Control Center descriptions and integration topic areas published on SAP Help:

- Collaboration
- Configuration Management
- Engineering
- Enterprise Product Structure
- Product Handover
- Specification Management
- Visualization and integration readiness

Reference: [SAP Help Portal - SAP Engineering Control Center](https://help.sap.com/docs/SAP_ENGINEERING_CONTROL_CENTER_S4HANA?locale=en-US)
