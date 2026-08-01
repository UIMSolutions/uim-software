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

- `GET|POST /api/v1/ecm/repositories`
- `GET|POST /api/v1/ecm/workspaces`
- `GET|POST /api/v1/ecm/folders`
- `GET|POST /api/v1/ecm/documents`
- `GET|POST /api/v1/ecm/document-versions`
- `GET|POST /api/v1/ecm/metadata-categories`
- `GET|POST /api/v1/ecm/users`
- `GET|POST /api/v1/ecm/groups`
- `GET|POST /api/v1/ecm/permissions`
- `GET|POST /api/v1/ecm/records`
- `GET|POST /api/v1/ecm/retention-policies`
- `GET|POST /api/v1/ecm/workflows`
- `GET|POST /api/v1/ecm/audit-entries`
- `GET|PUT|DELETE /api/v1/ecm/<objectType>/:id`
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
- `ECM_REPOSITORY` one of `memory`, `postgres`, `mongo`
- `ECM_POSTGRES_URL` default `postgresql://localhost:5432/ecm`
- `ECM_MONGO_URL` default `mongodb://localhost:27017`
- `ECM_MONGO_DATABASE` default `ecm`

## Security Headers

Read and write APIs require `Authorization: Bearer <token>`.

Write APIs also require one role in `X-ECM-Roles`:

- `ecm.admin`
- `ecm.write`
- `<objectType>.write` (for example `documents.write`)

## Test

```bash
cd ecm
dub test
```
