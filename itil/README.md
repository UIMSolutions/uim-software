# ITIL 5 Platform Service

A D-language microservice implementing ITIL 5 (IT Infrastructure Library) service management practices, built with vibe.d using a combination of Clean Architecture and Hexagonal (Ports & Adapters) Architecture.

## Overview

This service provides a RESTful HTTP API for managing the core ITIL 5 practices across an enterprise IT organization. It supports multi-tenancy and covers all major ITIL 5 practice domains: Service Management, Incident Management, Problem Management, Change Enablement, Configuration Management, Knowledge Management, Release Management, Event Management, Continual Improvement, and IT Asset Management.

## ITIL 5 Practices Implemented

| Practice | Entity | Endpoint |
|---|---|---|
| Service Catalogue Management | ITService | `/api/v1/itil/services` |
| Service Request Management | ServiceRequest | `/api/v1/itil/service-requests` |
| Incident Management | Incident | `/api/v1/itil/incidents` |
| Problem Management | Problem | `/api/v1/itil/problems` |
| Change Enablement | ChangeRecord | `/api/v1/itil/changes` |
| Configuration Management (CMDB) | ConfigurationItem | `/api/v1/itil/configuration-items` |
| Service Level Management | ServiceLevelAgreement | `/api/v1/itil/slas` |
| Knowledge Management | KnowledgeArticle | `/api/v1/itil/knowledge` |
| Release Management | ReleaseRecord | `/api/v1/itil/releases` |
| Event Management / Monitoring | MonitoringEvent | `/api/v1/itil/events` |
| Continual Improvement | ImprovementItem | `/api/v1/itil/improvements` |
| IT Asset Management | ITAsset | `/api/v1/itil/assets` |

## Architecture

The service uses a layered architecture combining Clean Architecture principles with the Hexagonal (Ports & Adapters) pattern:

```
source/
  app.d                        # Entry point: wires container, starts HTTP server
  uim/platform/itil/
    domain/                    # Core business logic (no external dependencies)
      types.d                  # ID aliases + all domain enums
      entities/                # 12 domain structs
      repositories/            # 12 repository interfaces (ports)
      services/
        itil_validator.d       # Domain-level validation rules
    application/               # Use case orchestration
      dto.d                    # 12 data transfer objects (all string fields)
      usecases/manage/         # 12 use case classes
    infrastructure/            # Adapters (driven side)
      config.d                 # AppConfig + loadConfig() from env
      persistence/memory/      # 12 in-memory repository implementations
      container.d              # Dependency injection container
    presentation/              # Adapters (driving side)
      http/
        json_utils.d           # 12 entity-to-Json serialization functions
        controllers/           # 12 HTTP controllers + HealthController
```

## API Reference

All endpoints follow REST conventions. Base path: `/api/v1/itil`

### Health Check

```
GET  /api/v1/health
```

### IT Services
```
GET    /api/v1/itil/services
POST   /api/v1/itil/services
GET    /api/v1/itil/services/:id
PUT    /api/v1/itil/services/:id
DELETE /api/v1/itil/services/:id
```

### Service Requests
```
GET    /api/v1/itil/service-requests
POST   /api/v1/itil/service-requests
GET    /api/v1/itil/service-requests/:id
PUT    /api/v1/itil/service-requests/:id
DELETE /api/v1/itil/service-requests/:id
```

### Incidents
```
GET    /api/v1/itil/incidents
POST   /api/v1/itil/incidents
GET    /api/v1/itil/incidents/:id
PUT    /api/v1/itil/incidents/:id
DELETE /api/v1/itil/incidents/:id
```

### Problems
```
GET    /api/v1/itil/problems
POST   /api/v1/itil/problems
GET    /api/v1/itil/problems/:id
PUT    /api/v1/itil/problems/:id
DELETE /api/v1/itil/problems/:id
```

### Changes
```
GET    /api/v1/itil/changes
POST   /api/v1/itil/changes
GET    /api/v1/itil/changes/:id
PUT    /api/v1/itil/changes/:id
DELETE /api/v1/itil/changes/:id
```

### Configuration Items (CMDB)
```
GET    /api/v1/itil/configuration-items
POST   /api/v1/itil/configuration-items
GET    /api/v1/itil/configuration-items/:id
PUT    /api/v1/itil/configuration-items/:id
DELETE /api/v1/itil/configuration-items/:id
```

### SLAs
```
GET    /api/v1/itil/slas
POST   /api/v1/itil/slas
GET    /api/v1/itil/slas/:id
PUT    /api/v1/itil/slas/:id
DELETE /api/v1/itil/slas/:id
```

### Knowledge Articles
```
GET    /api/v1/itil/knowledge
POST   /api/v1/itil/knowledge
GET    /api/v1/itil/knowledge/:id
PUT    /api/v1/itil/knowledge/:id
DELETE /api/v1/itil/knowledge/:id
```

### Releases
```
GET    /api/v1/itil/releases
POST   /api/v1/itil/releases
GET    /api/v1/itil/releases/:id
PUT    /api/v1/itil/releases/:id
DELETE /api/v1/itil/releases/:id
```

### Monitoring Events
```
GET    /api/v1/itil/events
POST   /api/v1/itil/events
GET    /api/v1/itil/events/:id
PUT    /api/v1/itil/events/:id
DELETE /api/v1/itil/events/:id
```

### Improvements
```
GET    /api/v1/itil/improvements
POST   /api/v1/itil/improvements
GET    /api/v1/itil/improvements/:id
PUT    /api/v1/itil/improvements/:id
DELETE /api/v1/itil/improvements/:id
```

### IT Assets
```
GET    /api/v1/itil/assets
POST   /api/v1/itil/assets
GET    /api/v1/itil/assets/:id
PUT    /api/v1/itil/assets/:id
DELETE /api/v1/itil/assets/:id
```

## Configuration

The service is configured via environment variables:

| Variable | Default | Description |
|---|---|---|
| `ITIL_HOST` | `0.0.0.0` | Bind address |
| `ITIL_PORT` | `8140` | HTTP port |

## Building

### Local Build

```bash
cd itil
dub build
./uim-itil-platform-service
```

### Docker Build

```bash
docker build -t uim-itil-platform-service:latest .
docker run -p 8140:8140 uim-itil-platform-service:latest
```

### Podman / Containerfile Build

```bash
podman build -f Containerfile -t uim-itil-platform-service:latest .
podman run -p 8140:8140 uim-itil-platform-service:latest
```

## Kubernetes Deployment

```bash
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

The service will be available within the cluster at:

```
http://itil-service.uim-platform.svc.cluster.local:8140
```

## Domain Enums

| Enum | Values |
|---|---|
| `RecordStatus` | open, inProgress, pending, resolved, closed, cancelled |
| `Priority` | critical, high, medium, low |
| `IncidentCategory` | hardware, software, network, security, performance, access, other |
| `ProblemStatus` | identified, inAnalysis, rootCauseFound, knownError, resolved, closed |
| `ChangeType` | standard, normal, emergency |
| `ChangeStatus` | draft, requested, authorized, scheduled, implemented, reviewComplete, closed, cancelled |
| `ChangeRisk` | low, medium, high, veryHigh |
| `CIType` | hardware, software, service, database, network, virtual_, cloud, documentation |
| `CIStatus` | active, inactive, retired, maintenance, disposed |
| `SLAStatus` | draft, active, expired, breached, closed |
| `KnowledgeStatus` | draft, underReview, approved, retired |
| `ReleaseType` | major, minor, patch, emergency |
| `ReleaseStatus` | planned, building, testing, deployed, failed, cancelled |
| `EventSeverity` | critical, major, minor, warning, informational |
| `EventStatus` | open, acknowledged, resolved, closed |
| `ImprovementStatus` | identified, inProgress, completed, cancelled |
| `AssetStatus` | active, inactive, disposed, lost, stolen |
| `AssetType` | hardware, software, license, consumable, infrastructure |

## License

Apache 2.0 — see LICENSE for details.
