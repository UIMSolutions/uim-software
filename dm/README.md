# SAP Digital Manufacturing Service

A D/vibe.d microservice implementing SAP Digital Manufacturing inspired capabilities using clean architecture and hexagonal architecture.

## SAP Reference

Design baseline follows SAP Help Portal documentation for SAP Digital Manufacturing:

https://help.sap.com/docs/sap-digital-manufacturing?locale=en-US

## Business Objects

- ProductionOrder
- OperationActivity
- WorkCenter
- Resource
- Material
- ShopFloorControl
- WorkInstruction
- QualityInspection
- Nonconformance
- GenealogyRecord

## Architecture

```text
source/
  app.d
  uim/platform/dm/
    domain/
      entities/
      repositories/
      services/
      types.d
    application/
      dto.d
      usecases/manage/
    infrastructure/
      config.d
      container.d
      persistence/memory/
    presentation/
      http/
        controllers/
        json_utils.d
```

### Layer Mapping

- Domain: manufacturing business objects, repository ports, domain validation
- Application: use-case orchestration and DTO contracts
- Infrastructure: in-memory adapters, runtime configuration, dependency container
- Presentation: REST HTTP controllers and JSON transformations

## API Endpoints

| Method | Endpoint |
|---|---|
| GET/POST/PUT/DELETE | /api/v1/dm/production-orders |
| GET/POST/PUT/DELETE | /api/v1/dm/operation-activities |
| GET/POST/PUT/DELETE | /api/v1/dm/work-centers |
| GET/POST/PUT/DELETE | /api/v1/dm/resources |
| GET/POST/PUT/DELETE | /api/v1/dm/materials |
| GET/POST/PUT/DELETE | /api/v1/dm/shop-floor-controls |
| GET/POST/PUT/DELETE | /api/v1/dm/work-instructions |
| GET/POST/PUT/DELETE | /api/v1/dm/quality-inspections |
| GET/POST/PUT/DELETE | /api/v1/dm/nonconformances |
| GET/POST/PUT/DELETE | /api/v1/dm/genealogy-records |
| GET | /health |
| GET | /api/v1/health |

Write calls use tenant scope from X-Tenant-Id header.

## Configuration

| Variable | Default | Description |
|---|---|---|
| DM_HOST | 0.0.0.0 | HTTP bind address |
| DM_PORT | 8138 | HTTP listen port |

## Build and Run

```bash
dub build
dub run
dub test
```
