# Content Server Service

This package provides a content-server style service inspired by SAP Content Server using vibe.d and D.

## Architectural Style

The service combines:

- Clean Architecture: domain and application rules are independent of web and storage concerns.
- Hexagonal Architecture: HTTP controllers and storage/integration adapters connect through explicit ports.

## Domain Scope

- Content repository management.
- Folder hierarchy management.
- Document metadata management.
- Document version tracking.
- Outbound document push integration.

## API Endpoints

Base path: `/api/v1/content`

- `GET /repositories`
- `POST /repositories`
- `GET /repositories/:id`
- `PUT /repositories/:id`
- `DELETE /repositories/:id`
- `GET /folders`
- `POST /folders`
- `GET /folders/:id`
- `PUT /folders/:id`
- `DELETE /folders/:id`
- `GET /documents`
- `POST /documents`
- `GET /documents/:id`
- `PUT /documents/:id`
- `DELETE /documents/:id`
- `GET /documents/:id/versions`
- `POST /documents/:id/versions`
- `GET /document-versions/:id`
- `DELETE /document-versions/:id`
- `POST /integrations/push-document/:documentId`

Additional endpoints:

- `GET /`
- `GET /health`
- `GET /api/v1/health`

## Run Locally

```bash
cd content
dub run
```

Optional environment variables:

- `CONTENT_HOST` default `0.0.0.0`
- `CONTENT_PORT` default `8188`

## Example Payloads

Create repository:

```json
{
  "name": "Main Content Repository",
  "storageType": "filesystem",
  "basePath": "/var/lib/content"
}
```

Create document:

```json
{
  "repositoryId": "REP-...",
  "folderId": "FLD-...",
  "title": "Service Contract",
  "documentNumber": "DOC-10001",
  "objectType": "pdf",
  "mimeType": "application/pdf",
  "fileName": "contract.pdf"
}
```

Create version:

```json
{
  "versionLabel": "1.1",
  "fileName": "contract-v1-1.pdf",
  "mimeType": "application/pdf"
}
```
