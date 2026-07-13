# MAIF - Mobile Application Integration Framework Service

This package provides a MAIF-inspired service for managing mobile app integration assets and synchronization workflows.

## Architectural Approach

The implementation combines:

- Clean Architecture: domain and application layers are independent of transport and persistence.
- Hexagonal Architecture: inbound HTTP adapters and outbound integration/persistence adapters connect through explicit ports.

## Functional Scope

- Mobile app registration and lifecycle management.
- Integration flow management between mobile apps and backend systems.
- Synchronization job orchestration metadata.
- External publish integration via outbound gateway stub.

## API Endpoints

Base path: `/api/v1/maif`

- `GET /mobile-apps`
- `POST /mobile-apps`
- `GET /mobile-apps/:id`
- `PUT /mobile-apps/:id`
- `DELETE /mobile-apps/:id`
- `GET /integration-flows`
- `POST /integration-flows`
- `GET /integration-flows/:id`
- `PUT /integration-flows/:id`
- `DELETE /integration-flows/:id`
- `GET /sync-jobs`
- `POST /sync-jobs`
- `GET /sync-jobs/:id`
- `PUT /sync-jobs/:id`
- `DELETE /sync-jobs/:id`
- `POST /integrations/publish-mobile-app/:appId`

Additional endpoints:

- `GET /`
- `GET /health`
- `GET /api/v1/health`

## Run

```bash
cd maif
dub run
```

Optional environment variables:

- `MAIF_HOST` (default `0.0.0.0`)
- `MAIF_PORT` (default `8176`)

## Example Request Payloads

Create mobile app:

```json
{
  "name": "FieldService Mobile",
  "platform": "android",
  "versionTag": "2.8.0",
  "owner": "mobile-team",
  "backendSystem": "sap-s4hana"
}
```

Create integration flow:

```json
{
  "appId": "APP-1720799999",
  "name": "WorkOrder Sync",
  "sourceSystem": "mobile-client",
  "targetSystem": "sap-s4hana",
  "protocol": "odata"
}
```

Create sync job:

```json
{
  "flowId": "FLOW-1720799999",
  "triggerType": "scheduled",
  "status": "queued"
}
```
