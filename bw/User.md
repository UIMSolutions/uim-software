# User Guide

## Accessing the Web Client

1. Start the service (`dub run`).
2. Open `http://localhost:8290/ui`.
3. Enter bearer token and roles.
4. Select a BW object type and execute operations.

## Example Object Payload

```json
{
  "technicalName": "ZQ_MARGIN",
  "businessName": "Margin by Segment",
  "semanticLayer": "BW Query",
  "sourceSystem": "S4H",
  "lifecycleState": "active",
  "parentId": "CP-1234",
  "owner": "controlling.team",
  "description": "Margin analysis by segment",
  "metadata": {
    "subjectArea": "finance",
    "refresh": "hourly"
  },
  "createdBy": "planner.a"
}
```

## Searching Models

`GET /api/v1/bw/search/models?q=margin`

## Data Flow and Query APIs

- List data flows by source object:
  - `GET /api/v1/bw/data-flows/by-source/<sourceId>`
- List queries by provider:
  - `GET /api/v1/bw/queries/by-provider/<providerId>`
- Execute simulated query runtime:
  - `POST /api/v1/bw/query-executions`

To execute against a remote BW runtime, administrators can configure `BW_QUERY_RUNTIME_URL`.

## Authorization

- Always include `Authorization: Bearer <token>`.
- Include `X-BW-Roles` for write operations.

## API Catalog

Use `GET /api/v1/bw/api-catalog` to list API definition business objects managed in the service.
