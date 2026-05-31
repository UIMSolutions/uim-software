# Integrated Product Development Service

<!-- markdownlint-disable MD040 MD060 MD047 -->

A vibe.d microservice in D that implements an SAP Integrated Product Development inspired domain model using clean architecture and hexagonal architecture.

The service follows the SAP Help positioning of Integrated Product Development as a cloud solution that digitally orchestrates product development from design to operate to reduce time to market, improve R&D ROI, and enable reliable product launches.

## Why This Service

This service provides an extensible backend foundation for key SAP IPD process areas, with initial support for:

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
  uim/platform/epd/
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
      integrations/sap_ipd/
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
| GET/POST/PUT/DELETE | /api/v1/epd/products | Engineering product data |
| GET/POST/PUT/DELETE | /api/v1/epd/boms | Enterprise product structure |
| GET/POST/PUT/DELETE | /api/v1/epd/change-requests | Configuration and change management |
| GET/POST/PUT/DELETE | /api/v1/epd/documents | Engineering documentation |
| GET/POST/PUT/DELETE | /api/v1/epd/specifications | Specification management |
| GET/POST/PUT/DELETE | /api/v1/epd/recipes | Formulation support |
| GET/POST/PUT/DELETE | /api/v1/epd/collaborations | Collaboration |
| GET/POST/PUT/DELETE | /api/v1/epd/product-structures | Product hierarchy |
| POST | /api/v1/epd/integrations/product-handover/:productId | Product handover stub |
| POST | /api/v1/epd/integrations/specification-sync/:specificationId | Specification sync stub |

All state-changing requests are tenant-scoped via X-Tenant-Id.

## Configuration

| Variable | Default | Purpose |
|---|---|---|
| EPD_HOST | 0.0.0.0 | Bind host |
| EPD_PORT | 8132 | HTTP port |

## Container and Kubernetes

- Container build files: Containerfile and Dockerfile in the EPD root
- Kubernetes manifests: k8s/configmap.yaml, k8s/deployment.yaml, k8s/service.yaml

Example commands:

```bash
docker build -t uim-platform/epd -f Dockerfile .
kubectl apply -f k8s/
```

## Build and Run

```bash
dub build
dub run
dub test
```

## SAP IPD Alignment Notes

Aligned to SAP Integrated Product Development descriptions and integration topic areas published on SAP Help:

- Collaboration
- Configuration Management
- Engineering
- Enterprise Product Structure
- Product Handover
- Specification Management
- Visualization and integration readiness

Reference: [SAP Help Portal - SAP Integrated Product Development](https://help.sap.com/docs/PLM_EPD?locale=en-US)
