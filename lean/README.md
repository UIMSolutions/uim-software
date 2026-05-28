# UIM LEAN Platform Service

An Enterprise Architecture Management (EAM) microservice built with D (dlang) and vibe.d, inspired by SAP LeanIX. It implements clean + hexagonal architecture and exposes a RESTful API for managing the full LeanIX fact sheet meta model.

## Features

- **12 Fact Sheet Types** across all four EA layers (Strategy, Business, Application, Technical)
- Multi-tenant support via `X-Tenant-Id` request header
- Full CRUD REST API for every fact sheet type
- In-memory repository adapters (drop-in replaceable with persistent backends)
- Health endpoint for liveness/readiness probes
- Containerised with Alpine 3.20 + LDC2; ready for Kubernetes deployment

## LeanIX Meta Model Layers

| Layer | Fact Sheet Types |
|-------|-----------------|
| Strategy & Transformation | Objective, Platform (LeanPlatform), Initiative |
| Business Architecture | Organization, BusinessCapability, BusinessContext |
| Application & Data Architecture | DataObject, Application (LeanApplication), Interface (AppInterface) |
| Technical Architecture | Provider, ITComponent, TechCategory |

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/health` | Service health |
| GET/POST | `/api/v1/lean/objectives` | List / create objectives |
| GET/PUT/DELETE | `/api/v1/lean/objectives/*` | Get / update / delete objective |
| GET/POST | `/api/v1/lean/platforms` | List / create platforms |
| GET/PUT/DELETE | `/api/v1/lean/platforms/*` | Get / update / delete platform |
| GET/POST | `/api/v1/lean/initiatives` | List / create initiatives |
| GET/PUT/DELETE | `/api/v1/lean/initiatives/*` | Get / update / delete initiative |
| GET/POST | `/api/v1/lean/organizations` | List / create organizations |
| GET/PUT/DELETE | `/api/v1/lean/organizations/*` | Get / update / delete organization |
| GET/POST | `/api/v1/lean/business-capabilities` | List / create business capabilities |
| GET/PUT/DELETE | `/api/v1/lean/business-capabilities/*` | Get / update / delete capability |
| GET/POST | `/api/v1/lean/business-contexts` | List / create business contexts |
| GET/PUT/DELETE | `/api/v1/lean/business-contexts/*` | Get / update / delete context |
| GET/POST | `/api/v1/lean/data-objects` | List / create data objects |
| GET/PUT/DELETE | `/api/v1/lean/data-objects/*` | Get / update / delete data object |
| GET/POST | `/api/v1/lean/applications` | List / create applications |
| GET/PUT/DELETE | `/api/v1/lean/applications/*` | Get / update / delete application |
| GET/POST | `/api/v1/lean/interfaces` | List / create interfaces |
| GET/PUT/DELETE | `/api/v1/lean/interfaces/*` | Get / update / delete interface |
| GET/POST | `/api/v1/lean/providers` | List / create providers |
| GET/PUT/DELETE | `/api/v1/lean/providers/*` | Get / update / delete provider |
| GET/POST | `/api/v1/lean/it-components` | List / create IT components |
| GET/PUT/DELETE | `/api/v1/lean/it-components/*` | Get / update / delete IT component |
| GET/POST | `/api/v1/lean/tech-categories` | List / create tech categories |
| GET/PUT/DELETE | `/api/v1/lean/tech-categories/*` | Get / update / delete tech category |

## Configuration

| Environment Variable | Default | Description |
|---------------------|---------|-------------|
| `LEAN_HOST` | `0.0.0.0` | Bind address |
| `LEAN_PORT` | `8130` | HTTP port |

## Architecture

```
source/
  app.d                               # Entry point, wires container → router
  uim/platform/lean/
    domain/                           # Enterprise domain model (pure D)
      types.d                         # ID aliases + enums
      entities/                       # 12 fact sheet structs
      repositories/                   # Repository interfaces (ports)
      services/lean_validator.d       # Domain validation
    application/                      # Use cases (orchestration)
      dto.d                           # 12 Data Transfer Objects
      usecases/manage/                # 12 ManageXxxUseCase classes
    infrastructure/                   # Adapters
      config.d                        # AppConfig + loadConfig()
      persistence/memory/             # 12 in-memory repositories
      container.d                     # Dependency injection container
    presentation/                     # HTTP adapters
      http/
        json_utils.d                  # Entity-to-JSON serialisers
        controllers/                  # 12 SAPController subclasses
```

## Build

```bash
# Development
cd lean
dub build

# Run
./bin/uim-lean-platform-service

# Tests
dub test
```

## Container

```bash
docker build -t uim-lean-platform-service .
docker run -p 8130:8130 uim-lean-platform-service
```

## Kubernetes

```bash
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```
