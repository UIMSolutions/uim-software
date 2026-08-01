# User Guide

## Accessing the Web Client

1. Start the service (`dub run`).
2. Open `http://localhost:8190/ui`.
3. Select an object type.
4. Create and browse objects.

## Object Creation Payload

Example for documents:

```json
{
  "name": "Contract-2026-001",
  "title": "Service Contract",
  "status": "active",
  "parentId": "FOLDER-001",
  "owner": "legal.team",
  "description": "Master service agreement",
  "metadata": {
    "classification": "confidential",
    "department": "legal"
  },
  "createdBy": "user.a"
}
```

## Search

Use document search endpoint:

`GET /api/v1/ecm/search/documents?q=contract`

## Explicit Object Endpoints

Each business object has dedicated endpoints under `/api/v1/ecm/<objectType>`, for example:

- `/api/v1/ecm/repositories`
- `/api/v1/ecm/folders`
- `/api/v1/ecm/documents`
- `/api/v1/ecm/workflows`

For object details use `/api/v1/ecm/<objectType>/<id>`.

## Authorization

- Include `Authorization: Bearer <token>` for all API calls.
- Include `X-ECM-Roles` for write operations.

## Document Versioning

When a document is created, version `1.0` is automatically seeded.
Use:

`GET /api/v1/ecm/document-versions/by-document/<documentId>`
