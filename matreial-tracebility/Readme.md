# Material Traceability Service

This package provides a software service similar to SAP Business Network Material Traceability, implemented with vibe.d and D.

It combines:

- Clean Architecture: domain and application rules are isolated from delivery and persistence.
- Hexagonal Architecture: inbound HTTP ports and outbound repository adapters are separated by interfaces.

## Included Business Objects

- materials
- material-lots
- batches
- serial-numbers
- suppliers
- manufacturers
- plants
- warehouses
- shipment-units
- transport-events
- transformation-events
- consumption-events
- quality-inspections
- certificates
- compliance-statements
- recall-cases
- incidents
- chain-of-custody-links
- lineage-views
- risk-assessments
- partner-mappings
- document-references
- api-definitions
- audit-entries

## API Overview

Base path: /api/v1/mt

- GET|POST /api/v1/mt/<objectType>
- GET|PUT|DELETE /api/v1/mt/<objectType>/:id
- GET /api/v1/mt/search/events?q=<query>
- GET /api/v1/mt/lineage/by-material/:materialId
- GET /api/v1/mt/compliance/by-lot/:lotId
- POST /api/v1/mt/recall-simulations
- GET /api/v1/mt/api-catalog

Health and UI:

- GET /
- GET /health
- GET /api/v1/health
- GET /ui

## Run

```bash
cd matreial-tracebility
dub run
```

Environment variables:

- MT_HOST default 0.0.0.0
- MT_PORT default 8590
- MT_WEB_ROOT default web
- MT_REPOSITORY one of memory, postgres, mongo
- MT_POSTGRES_URL default postgresql://localhost:5432/material_traceability
- MT_MONGO_URL default mongodb://localhost:27017
- MT_MONGO_DATABASE default material_traceability

## Security Headers

Read APIs require Authorization: Bearer <token>.

Write APIs also require one role in X-MT-Roles:

- mt.admin
- mt.write
- <objectType>.write

## Test

```bash
cd matreial-tracebility
dub test
```
