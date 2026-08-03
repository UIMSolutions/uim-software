# Production Planning (PP) Service

This package provides a service similar to SAP S/4HANA Production Planning (PP), implemented in D and vibe.d.

## Architecture

- Clean Architecture: business rules in domain and use-case layers.
- Hexagonal Architecture: HTTP and persistence adapters behind ports.

## PP Business Objects

- materials
- plants
- work-centers
- production-versions
- bills-of-material
- routings
- mrp-areas
- demand-programs
- planned-orders
- production-orders
- order-operations
- confirmations
- capacity-requirements
- mrp-runs

## APIs

Base path: `/api/v1/pp`

- `GET|POST /<objectType>`
- `GET|PUT|DELETE /<objectType>/:id`
- `POST /mrp-runs/execute`
- `GET /planned-orders/by-material/:materialId`

Health and UI:

- `GET /`
- `GET /health`
- `GET /api/v1/health`
- `GET /ui`

## Run

```bash
cd pp
dub run
```

Environment variables:

- `PP_HOST` default `0.0.0.0`
- `PP_PORT` default `8191`
- `PP_WEB_ROOT` default `web`

## Test

```bash
cd pp
dub test
```
