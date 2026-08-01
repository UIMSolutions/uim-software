# Enterprise Content Management Service

This package provides a software service similar to OpenText ECM, implemented with vibe.d and D.

It combines:

- Clean Architecture: domain and application rules are isolated from delivery and persistence.
- Hexagonal Architecture: inbound HTTP ports and outbound repository adapters are separated by interfaces.

## Included Business Objects

- repositories
- workspaces
- folders
- documents
- document-versions
- metadata-categories
- users
- groups
- permissions
- records
- retention-policies
- workflows
- audit-entries

## API Overview

Base path: `/api/v1/ecm`

- `GET /api/v1/ecm/:objectType`
- `POST /api/v1/ecm/:objectType`
- `GET /api/v1/ecm/:objectType/:id`
- `PUT /api/v1/ecm/:objectType/:id`
- `DELETE /api/v1/ecm/:objectType/:id`
- `GET /api/v1/ecm/search/documents?q=<query>`
- `GET /api/v1/ecm/document-versions/by-document/:documentId`

Health and UI:

- `GET /`
- `GET /health`
- `GET /api/v1/health`
- `GET /ui`

## Run

```bash
cd ecm
dub run
```

Environment variables:

- `ECM_HOST` default `0.0.0.0`
- `ECM_PORT` default `8190`
- `ECM_WEB_ROOT` default `web`

## Test

```bash
cd ecm
dub test
```
