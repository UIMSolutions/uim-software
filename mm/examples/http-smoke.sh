#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://127.0.0.1:8150}"
TENANT_ID="${TENANT_ID:-TEN-SMOKE}"

request() {
  local method="$1"
  local path="$2"
  local body="${3:-}"

  if [[ -n "$body" ]]; then
    curl --silent --show-error --fail \
      -X "$method" \
      -H "Content-Type: application/json" \
      -H "X-Tenant-Id: $TENANT_ID" \
      --data "$body" \
      "$BASE_URL$path"
  else
    curl --silent --show-error --fail \
      -X "$method" \
      -H "X-Tenant-Id: $TENANT_ID" \
      "$BASE_URL$path"
  fi
}

echo "Seeding master data"
request POST /api/v1/mm/materials '{"id":"MAT-SMOKE","materialNumber":"MAT-SMOKE","description":"Smoke Material","baseUnit":"EA","materialType":"rawMaterial","createdBy":"smoke"}' >/dev/null
request POST /api/v1/mm/plants '{"id":"PLANT-SMOKE","plantCode":"1000","name":"Smoke Plant","companyCode":"1000","country":"DE","purchasingOrg":"P100","createdBy":"smoke"}' >/dev/null
request POST /api/v1/mm/storage-locations '{"id":"SL-SMOKE","plantId":"PLANT-SMOKE","storageLocationCode":"0001","name":"Main","description":"Main stock","createdBy":"smoke"}' >/dev/null
request POST /api/v1/mm/vendors '{"id":"VEN-SMOKE","vendorNumber":"700001","name":"Smoke Vendor","purchasingOrg":"P100","currency":"EUR","paymentTerms":"0001","incoterms":"DAP","createdBy":"smoke"}' >/dev/null
request POST /api/v1/mm/purchasing-info-records '{"id":"PIR-SMOKE","materialId":"MAT-SMOKE","vendorId":"VEN-SMOKE","plantId":"PLANT-SMOKE","purchasingOrg":"P100","orderUnit":"EA","netPrice":"99.95","currency":"EUR","leadTimeDays":"3","minimumOrderQuantity":"1","createdBy":"smoke"}' >/dev/null

echo "Creating requisition"
request POST /api/v1/mm/purchase-requisitions '{"id":"PR-SMOKE","materialId":"MAT-SMOKE","plantId":"PLANT-SMOKE","storageLocationId":"SL-SMOKE","quantity":"7","unit":"EA","requiredDate":"2026-08-02","requestedBy":"smoke","sourceVendorId":"VEN-SMOKE"}' | grep -q 'PR-SMOKE'

echo "Converting requisition"
request POST /api/v1/mm/purchase-requisition-conversions/PR-SMOKE '{"id":"PO-SMOKE","vendorId":"VEN-SMOKE","purchasingOrg":"P100","currency":"EUR","netPrice":"99.95","orderedBy":"smoke"}' | grep -q 'PO-SMOKE'

echo "Posting goods receipt"
request POST /api/v1/mm/goods-receipts '{"id":"GR-SMOKE","purchaseOrderId":"PO-SMOKE","plantId":"PLANT-SMOKE","storageLocationId":"SL-SMOKE","materialId":"MAT-SMOKE","movementType":"goodsReceipt","quantity":"7","postedBy":"smoke","postingDate":"2026-08-01"}' | grep -q 'GR-SMOKE'

echo "Verifying stock"
request GET /api/v1/mm/stock-items | grep -q '"unrestrictedUseQty":"7"'

echo "Verifying client"
curl --silent --show-error --fail "$BASE_URL/client" | grep -q 'Material Management Console'

echo "MM HTTP smoke test passed"