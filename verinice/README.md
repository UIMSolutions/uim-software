# Verinice IT-Grundschutz Service

<!-- markdownlint-disable MD040 MD060 MD047 -->

A vibe.d microservice in D that models core IT-Grundschutz workflows inspired by Sernet verinice and the domain documentation at:

- https://docs.eu.verinice.cloud/en/domain-it-gs/
- https://github.com/sernet/verinice

This implementation uses a combination of clean architecture and hexagonal architecture and is intentionally structured as a standalone platform service module.

## Scope

The service provides:

- Asset catalog management for scope definition
- Safeguard planning and implementation tracking
- Assessment management for risk and status evaluation
- Integration stub for external IT-Grundschutz catalog synchronization

## Architecture

```text
source/
  app.d
  uim/platform/verinice/
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
      integrations/verinice_cloud/   # outbound adapter stubs
    presentation/
      http/
        controllers/
        json_utils.d
```

### Clean + Hexagonal Mapping

- Domain: entities, validation rules, and abstract ports
- Application: use-case orchestration and command results
- Infrastructure: in-memory persistence and external sync stubs
- Presentation: HTTP adapters exposing REST endpoints

## API Surface

| Method | Endpoint | Purpose |
|---|---|---|
| GET/POST/PUT/DELETE | /api/v1/verinice/assets | Asset management |
| GET/POST/PUT/DELETE | /api/v1/verinice/safeguards | Safeguard management |
| GET/POST/PUT/DELETE | /api/v1/verinice/assessments | Assessment management |
| POST | /api/v1/verinice/integrations/gs-catalog-sync/:safeguardId | Trigger safeguard catalog sync stub |
| GET | /health | Service health |
| GET | /api/v1/health | Service health |

All write operations are tenant-scoped via `X-Tenant-Id`.

## Common Payload Conventions

- List response: `{ "count": number, "resources": [ ... ] }`
- Create/update response: `{ "id": "..." }`
- Integration response: `{ "id": "...", "externalId": "...", "message": "..." }`
- Error response: `{ "error": "...", "status": number }`

## Example Requests

Create asset:

```bash
curl -sS -X POST http://localhost:8139/api/v1/verinice/assets \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: T1" \
  -d '{"id":"A-100","name":"ERP Core","description":"Business critical ERP","assetType":"application","confidentiality":"high","integrity":"high","availability":"high","owner":"ciso-team","createdBy":"architect-1"}'
```

Create safeguard:

```bash
curl -sS -X POST http://localhost:8139/api/v1/verinice/safeguards \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: T1" \
  -d '{"id":"S-100","assetId":"A-100","code":"ORP.4.A1","title":"Patch Management","description":"Establish patch process","implementationStatus":"planned","maturityLevel":"initial","owner":"ops-team","createdBy":"architect-1"}'
```

Trigger integration stub:

```bash
curl -sS -X POST http://localhost:8139/api/v1/verinice/integrations/gs-catalog-sync/S-100
```

## Configuration

| Variable | Default | Purpose |
|---|---|---|
| VERINICE_HOST | 0.0.0.0 | HTTP bind address |
| VERINICE_PORT | 8139 | HTTP listen port |

## Build and Run

```bash
dub build
dub run
dub test
```

## Notes

- This service is inspired by verinice concepts and terminology, but it is not a copy of the upstream project.
- The integration adapter is a stub and can be replaced with a real verinice API adapter in infrastructure.
