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
- Outbound tender sync via real SAP BN HTTP adapter or local stub fallback

## Architecture

```text
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
```

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

```bash
curl -sS -X POST "http://localhost:8140/api/v1/freight-collaboration/freight-orders" \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: T1" \
  -d '{"id":"FO-100","orderNumber":"45000023","shipperId":"SHIP-01","carrierId":"CAR-09","transportMode":"road","originLocation":"Berlin","destinationLocation":"Hamburg","plannedPickup":"2026-07-15T08:00:00Z","plannedDelivery":"2026-07-16T16:00:00Z","createdBy":"planner-1"}'

curl -sS -X POST "http://localhost:8140/api/v1/freight-collaboration/tenders" \
  -H "Content-Type: application/json" \
  -H "X-Tenant-Id: T1" \
  -d '{"id":"TEN-100","freightOrderId":"FO-100","tenderNumber":"TND-2026-1","offeredRate":"1200.00","currency":"EUR","responseBy":"2026-07-14T12:00:00Z","createdBy":"planner-1"}'

curl -sS -X POST "http://localhost:8140/api/v1/freight-collaboration/integrations/tender-sync/TEN-100"
```

## Configuration

| Variable | Default | Purpose |
|---|---|---|
| FREIGHT_COLLAB_HOST | 0.0.0.0 | HTTP bind address |
| FREIGHT_COLLAB_PORT | 8140 | HTTP listen port |
| FREIGHT_COLLAB_USE_STUB_INTEGRATION | true | Toggle stub vs real SAP BN integration adapter |
| FREIGHT_COLLAB_SAP_BN_BASE_URL | empty | SAP BN base URL for tender sync API |
| FREIGHT_COLLAB_SAP_BN_TENDER_SYNC_PATH | /api/v1/freight-collaboration/tenders/sync | Relative path for tender sync endpoint |
| FREIGHT_COLLAB_SAP_BN_API_TOKEN | empty | Bearer token for SAP BN API authorization |

## Build and Run

```bash
dub build
dub run
dub test
```

## Deployment

- Container build definitions are available in `Containerfile` and `Dockerfile`.
- Kubernetes manifests are available in `k8s/configmap.yaml`, `k8s/deployment.yaml`, and `k8s/service.yaml`.
- Local API seed and smoke tests are available in `examples/seed-data.sh` and `examples/smoke-test.sh`.

Build and deploy example:

```bash
docker build -t uim-platform/freight-collaboration -f Dockerfile .
kubectl apply -f k8s/
```

## Tests

- Use-case unit tests: `source/uim/platform/freight_collaboration/application/usecases/manage/freight_collaboration_feature_tests.d`
- Controller route contract tests: `source/uim/platform/freight_collaboration/presentation/http/controllers/contracts_tests.d`
