#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8131}"
TENANT="${TENANT:-T1}"

post() {
  local path="$1"
  local data="$2"
  curl -sS -X POST "$BASE_URL$path" \
    -H "Content-Type: application/json" \
    -H "X-Tenant-Id: $TENANT" \
    -d "$data"
  echo
}

echo "Seeding PLM sample data to $BASE_URL for tenant $TENANT"

post "/api/v1/plm/products" '{"id":"P-100","name":"Autonomous Drone","description":"Recon drone platform","productNumber":"DRN-100","productType":"finished","lifecycleStatus":"draft","category":"Defense","baseUnit":"EA","createdBy":"seed"}'

post "/api/v1/plm/boms" '{"id":"BOM-100","productId":"P-100","name":"Drone Main BOM","description":"Primary engineering BOM","bomType":"engineering","revision":"A","usage":"production","plant":"PLANT-01","baseQuantity":"1","baseUnit":"EA","isActive":"true","createdBy":"seed"}'

post "/api/v1/plm/change-requests" '{"id":"CR-10","productId":"P-100","title":"Increase battery capacity","description":"Raise endurance to 90 minutes","priority":"high","status":"submitted","reason":"Operational requirement","impact":"Medium","requestedBy":"eng-1","createdBy":"seed"}'

echo "Products:"
curl -sS "$BASE_URL/api/v1/plm/products"
echo

echo "Change Requests:"
curl -sS "$BASE_URL/api/v1/plm/change-requests"
echo
