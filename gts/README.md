# SAP Global Trade Services Service

A D/vibe.d microservice implementing SAP Global Trade Services (GTS) inspired capabilities with a blend of clean architecture and hexagonal architecture.

## SAP Reference

Design baseline follows SAP Help for SAP Global Trade Services edition for SAP HANA:

https://help.sap.com/docs/SAP_GLOBAL_TRADE_SERVICES_EDITION_HANA?locale=en-US

## Business Objects

- BusinessPartner
- ProductClassification
- CustomsDeclaration
- TradeLicense
- PreferenceAgreement
- SanctionedPartyCase
- EmbargoControlCase
- IntrastatDeclaration

## Architecture

```text
source/
  app.d
  uim/platform/gts/
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

- Domain: entities, types, repository ports, validation rules
- Application: DTOs and orchestration use cases
- Infrastructure: in-memory repository adapters, runtime config, container wiring
- Presentation: HTTP adapters exposing REST APIs

## API Endpoints

| Method | Endpoint |
|---|---|
| GET/POST/PUT/DELETE | /api/v1/gts/business-partners |
| GET/POST/PUT/DELETE | /api/v1/gts/product-classifications |
| GET/POST/PUT/DELETE | /api/v1/gts/customs-declarations |
| GET/POST/PUT/DELETE | /api/v1/gts/trade-licenses |
| GET/POST/PUT/DELETE | /api/v1/gts/preference-agreements |
| GET/POST/PUT/DELETE | /api/v1/gts/sanctioned-party-cases |
| GET/POST/PUT/DELETE | /api/v1/gts/embargo-control-cases |
| GET/POST/PUT/DELETE | /api/v1/gts/intrastat-declarations |
| GET | /health |
| GET | /api/v1/health |

Write calls use tenant context from header X-Tenant-Id.

## Configuration

| Variable | Default | Description |
|---|---|---|
| GTS_HOST | 0.0.0.0 | HTTP bind address |
| GTS_PORT | 8136 | HTTP listen port |

## Build And Run

```bash
dub build
dub run
dub test
```
