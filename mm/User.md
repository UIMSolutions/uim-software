# User Guide

## Overview

The MM service supports a standard procurement and inventory flow:

1. Create master data for materials, plants, storage locations, vendors, and purchasing info records.
2. Create a purchase requisition for a requested material.
3. Convert the requisition into a purchase order.
4. Post a goods receipt for the purchase order.
5. Review updated stock levels.

## Quick Start

1. Open the browser client at `/client`.
2. Create a material and vendor.
3. Create a purchase requisition.
4. Convert it to a purchase order.
5. Post a goods receipt.

## Example

```http
POST /api/v1/mm/purchase-requisitions
X-Tenant-Id: TEN-1
Content-Type: application/json

{
  "id": "PR-1000",
  "materialId": "MAT-1000",
  "plantId": "PLANT-1000",
  "storageLocationId": "SL-1000",
  "quantity": "25",
  "unit": "EA",
  "requiredDate": "2026-08-15",
  "requestedBy": "buyer.1",
  "sourceVendorId": "VEN-1000"
}
```

```http
POST /api/v1/mm/purchase-requisitions/PR-1000/convert
X-Tenant-Id: TEN-1
Content-Type: application/json

{
  "id": "PO-1000",
  "vendorId": "VEN-1000",
  "purchasingOrg": "P100",
  "currency": "EUR",
  "netPrice": "145.50",
  "orderedBy": "buyer.1"
}
```