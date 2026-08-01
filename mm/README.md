# SAP S/4HANA Material Management (MM) Service

This package implements a Material Management service using D and vibe.d with a combined Clean Architecture and Hexagonal Architecture approach.

## Scope

The service covers the main operational objects needed for an SAP MM-style reference service:

- Materials
- Plants
- Storage Locations
- Vendors
- Purchasing Info Records
- Purchase Requisitions
- Purchase Orders
- Goods Receipts
- Stock Items

## Architecture

- Domain: business objects, repository ports, validation rules
- Application: DTOs and orchestration use cases
- Infrastructure: in-memory adapters, configuration, dependency container
- Presentation: REST controllers and a lightweight web client

## API Summary

- `GET|POST|PUT|DELETE /api/v1/mm/materials`
- `GET|POST|PUT|DELETE /api/v1/mm/plants`
- `GET|POST|PUT|DELETE /api/v1/mm/storage-locations`
- `GET|POST|PUT|DELETE /api/v1/mm/vendors`
- `GET|POST|PUT|DELETE /api/v1/mm/purchasing-info-records`
- `GET|POST|PUT|DELETE /api/v1/mm/purchase-requisitions`
- `POST /api/v1/mm/purchase-requisitions/:id/convert`
- `GET|POST|PUT|DELETE /api/v1/mm/purchase-orders`
- `GET|POST|PUT|DELETE /api/v1/mm/stock-items`
- `GET|POST|DELETE /api/v1/mm/goods-receipts`
- `GET /api/v1/health`
- `GET /client`

## Run

```bash
cd mm
dub run
```

## Test

```bash
cd mm
dub test
```