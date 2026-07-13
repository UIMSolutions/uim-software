# SAP Business Network Freight Collaboration Service

<!-- markdownlint-disable MD040 MD060 MD047 -->

A vibe.d microservice in D that models core freight collaboration workflows inspired by SAP Business Network Freight Collaboration.

Reference documentation:

- [https://help.sap.com/docs/business-network-freight-collaboration?locale=en-US](https://help.sap.com/docs/business-network-freight-collaboration?locale=en-US)

The implementation combines clean architecture and hexagonal architecture with explicit domain ports and adapter boundaries.

## Scope

This service provides:

- Freight order management
- Tender lifecycle management
- Milestone visibility updates
- Outbound tender sync integration stub

## Architecture

source/
  app.d
  uim/platform/freight_collaboration/
    domain/
      entities/
      integration/
      repositories/
      services/
      types.d
    application/
      dto.d
      usecases/manage/
      usecases/integration/
    infrastructure/
      config.d
      container.d
      persistence/memory/
      integrations/sap_bn_fc/
    presentation/
      http/
        controllers/
        json_utils.d

## API Surface

| Method | Endpoint | Purpose |
|---|---|---|
| GET/POST/PUT/DELETE | /api/v1/freight-collaboration/freight-orders | Freight order management |
| GET/POST/PUT/DELETE | /api/v1/freight-collaboration/tenders | Tender management |
| GET/POST/PUT/DELETE | /api/v1/freight-collaboration/milestones | Milestone updates |
| POST | /api/v1/freight-collaboration/integrations/tender-sync/:tenderId | Trigger tender sync stub |
| GET | /health | Service health |
| GET | /api/v1/health | Service health |

All write operations are tenant-scoped via X-Tenant-Id.

## Response Conventions

- List response: { "count": number, "resources": [ ... ] }
- Create or update response: { "id": "..." }
- Integration response: { "id": "...", "externalId": "...", "message": "..." }
- Error response: { "error": "...", "status": number }

## Quickstart

curl -sS -X POST http://localhost:8140/api/v1/freight-collaboration/freight-orders \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: T1" \
  -d '{"id":"FO-100","orderNumber":"45000023","shipperId":"SHIP-01","carrierId":"CAR-09","transportMode":"road","originLocation":"Berlin","destinationLocation":"Hamburg","plannedPickup":"2026-07-15T08:00:00Z","plannedDelivery":"2026-07-16T16:00:00Z","createdBy":"planner-1"}'

curl -sS -X POST http://localhost:8140/api/v1/freight-collaboration/tenders \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: T1" \
  -d '{"id":"TEN-100","freightOrderId":"FO-100","tenderNumber":"TND-2026-1","offeredRate":"1200.00","currency":"EUR","responseBy":"2026-07-14T12:00:00Z","createdBy":"planner-1"}'

curl -sS -X POST http://localhost:8140/api/v1/freight-collaboration/integrations/tender-sync/TEN-100

## Configuration

| Variable | Default | Purpose |
|---|---|---|
| FREIGHT_COLLAB_HOST | 0.0.0.0 | HTTP bind address |
| FREIGHT_COLLAB_PORT | 8140 | HTTP listen port |

## Build and Run

dub build
dub run
dub test
