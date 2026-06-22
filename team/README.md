# UIM TEAM Service

A Teamcenter-like product lifecycle management service built with D and vibe.d using clean and hexagonal architecture. It models core PLM operations for managing parts, product structures (BOM), engineering documents, and engineering change requests.

## Teamcenter-Inspired Scope

Based on SAP Teamcenter by Siemens positioning as a PLM core with integration capabilities, this service focuses on:

- Product data management: part master and revision lifecycle
- Product structure management: BOM and BOM lines
- Document management: CAD and engineering documents linked to parts/changes
- Engineering change management: lifecycle and impact analysis
- API-first architecture suitable for integration with ERP and external PLM workflows

## Features

- Multi-tenant support via `X-Tenant-Id`
- CRUD endpoints for parts, BOMs, documents, and changes
- Change lifecycle policy with controlled state transitions
- Change impact scoring for operational prioritization
- In-memory adapters behind repository ports

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/health` | Service health |
| GET/POST | `/api/v1/team/parts` | List or create parts |
| GET/PUT/DELETE | `/api/v1/team/parts/*` | Read, update, delete part |
| GET/POST | `/api/v1/team/boms` | List or create BOMs |
| GET/PUT/DELETE | `/api/v1/team/boms/*` | Read, update, delete BOM |
| GET/POST | `/api/v1/team/documents` | List or create documents |
| GET/PUT/DELETE | `/api/v1/team/documents/*` | Read, update, delete document |
| GET/POST | `/api/v1/team/changes` | List or create changes |
| GET/PUT/DELETE | `/api/v1/team/changes/*` | Read, update, delete change |
| GET | `/api/v1/team/plm/summary` | Portfolio summary for PLM objects |
| GET | `/api/v1/team/plm/change-impact` | Computed change impact list |

## Architecture

```text
source/
  app.d
  uim/platform/team/
    domain/
      types.d
      entities/
      repositories/
      services/change_policy.d
    application/
      dto.d
      usecases/manage/
        manage_parts.d
        manage_boms.d
        manage_documents.d
        manage_changes.d
        analyze_plm.d
    infrastructure/
      config.d
      container.d
      persistence/memory/
    presentation/
      http/
        json_utils.d
        controllers/
```

## Build and Run

```bash
cd team
dub build
./uim-team-platform-service
```

## Example

Create part:

```bash
curl -X POST http://localhost:8150/api/v1/team/parts \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: demo" \
  -d '{
    "id": "part-1001",
    "number": "P-1001",
    "name": "Hydraulic Pump",
    "revision": "A",
    "lifecycleState": "inWork"
  }'
```

Create change request:

```bash
curl -X POST http://localhost:8150/api/v1/team/changes \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: demo" \
  -d '{
    "id": "chg-42",
    "changeNumber": "ECR-0042",
    "title": "Upgrade seal material",
    "severity": "high",
    "affectedPartIds": ["part-1001"]
  }'
```

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `TEAM_HOST` | `0.0.0.0` | HTTP bind host |
| `TEAM_PORT` | `8150` | HTTP bind port |

## Container and Kubernetes

```bash
docker build -t uim-platform/team:latest .
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```
