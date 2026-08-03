# User Guide

## Accessing the Web Client

1. Start the service with dub run.
2. Open http://localhost:8590/ui.
3. Enter bearer token and MT roles.
4. Choose object types and run CRUD or traceability APIs.

## Example Object Payload

```json
{
  "technicalName": "MAT-2026-001",
  "businessName": "Battery Cell Lot",
  "traceabilityDomain": "Electronics",
  "sourceSystem": "MES",
  "lifecycleState": "active",
  "owner": "quality.team",
  "description": "Critical material for EV modules",
  "metadata": {
    "origin": "Supplier-A",
    "hazardClass": "9"
  },
  "createdBy": "qa.lead"
}
```

## Traceability APIs

- Search events: GET /api/v1/mt/search/events?q=material
- Material lineage: GET /api/v1/mt/lineage/by-material/<materialId>
- Lot compliance: GET /api/v1/mt/compliance/by-lot/<lotId>
- Recall simulation: POST /api/v1/mt/recall-simulations
- API catalog: GET /api/v1/mt/api-catalog

## Authorization

- Include Authorization: Bearer <token> for all API calls.
- Include X-MT-Roles for write operations.
