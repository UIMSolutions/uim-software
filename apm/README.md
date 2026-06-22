# UIM APM Service

Application Portfolio Assessment microservice built with D and vibe.d using clean architecture and hexagonal architecture patterns. The implementation is inspired by SAP LeanIX APM guidance and focuses on the initial assessment workflow: create inventory transparency, assess business/technical fit, and derive portfolio recommendations.

## Scope

The service supports three practical steps aligned to the SAP LeanIX APM guidance:

1. Add data: manage application portfolio entries.
2. Collect and maintain data: capture fit/value assessment snapshots.
3. Assess portfolio: expose summary and matrix endpoints for decision support.

## Core Capabilities

- Multi-tenant handling with `X-Tenant-Id`.
- CRUD APIs for applications and assessments.
- Domain scoring policy for functional fit, technical fit, business value, and data quality.
- Recommendation generation: `invest`, `tolerate`, `migrate`, `eliminate`.
- Portfolio summary and matrix views to support report-like analysis.
- In-memory persistence adapters (replaceable with DB adapters).

## API Endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/` | Root service info |
| GET | `/health` | Health |
| GET | `/api/v1/health` | Health |
| GET/POST | `/api/v1/apm/applications` | List/create application portfolio items |
| GET/PUT/DELETE | `/api/v1/apm/applications/*` | Read/update/delete application |
| GET/POST | `/api/v1/apm/assessments` | List/create assessments |
| GET/PUT/DELETE | `/api/v1/apm/assessments/*` | Read/update/delete assessment |
| GET | `/api/v1/apm/portfolio/summary` | Aggregate KPI summary |
| GET | `/api/v1/apm/portfolio/matrix` | Matrix points for capability/org analysis |

## Data Model Highlights

### Application Portfolio Item

- Identity and tenant fields
- Business capability and organization mapping
- Lifecycle phase
- Business criticality
- Cost and ownership metadata

### Application Assessment

- Links to application item
- Functional fit, technical fit, business value, data quality
- Computed overall score
- Recommendation derived from policy
- Review and risk notes

## Architecture

```text
source/
  app.d
  uim/platform/apm/
    domain/
      types.d
      entities/
      repositories/
      services/assessment_policy.d
    application/
      dto.d
      usecases/manage/
        manage_portfolio_items.d
        manage_assessments.d
        analyze_portfolio.d
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
cd apm
dub build
./uim-apm-platform-service
```

## Example Requests

Create application:

```bash
curl -X POST http://localhost:8140/api/v1/apm/applications \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: demo" \
  -d '{
    "id": "app-1",
    "name": "Customer Portal",
    "businessCapability": "Customer Service",
    "organization": "Sales",
    "lifecyclePhase": "maintain",
    "businessCriticality": "high",
    "annualCostUsd": "250000"
  }'
```

Create assessment:

```bash
curl -X POST http://localhost:8140/api/v1/apm/assessments \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: demo" \
  -d '{
    "id": "assessment-1",
    "applicationId": "app-1",
    "assessmentDate": "2026-06-22",
    "assessor": "enterprise.architect",
    "functionalFit": "good",
    "technicalFit": "moderate",
    "businessValue": "good",
    "dataQuality": "moderate"
  }'
```

Get summary:

```bash
curl -H "X-Tenant-Id: demo" http://localhost:8140/api/v1/apm/portfolio/summary
```

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `APM_HOST` | `0.0.0.0` | HTTP bind host |
| `APM_PORT` | `8140` | HTTP bind port |

## Container

```bash
docker build -t uim-platform/apm:latest .
docker run -p 8140:8140 uim-platform/apm:latest
```

## Kubernetes

```bash
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```
