# User Guide

## Open UI

1. Start the service.
2. Navigate to `http://localhost:8390/ui`.
3. Enter a Bearer token and roles (for example `rpm.admin,rpm.write`).

## Typical Workflow

1. Create master data using CRUD endpoints:
   - Packaging materials
   - Packaging pools
   - Locations
   - Partners
2. Register operations from the UI or API:
   - check-out
   - check-in
   - transfer
   - clean
   - repair
   - inspect
3. Review outcomes:
   - search models
   - trace asset
   - pool balances
   - KPI snapshot

## API Example

Create a packaging material:

```bash
curl -X POST http://localhost:8390/api/v1/rpm/packaging-materials \
  -H "Authorization: Bearer demo-token" \
  -H "X-RPM-Roles: rpm.admin" \
  -H "Content-Type: application/json" \
  -d '{
    "technicalName":"PALLET-120x80",
    "businessName":"Euro Pallet",
    "quantity":"1000",
    "createdBy":"user1",
    "modifiedBy":"user1"
  }'
```
