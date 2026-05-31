#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8132}"
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

echo "Seeding MES sample data to $BASE_URL for tenant $TENANT"

post "/api/v1/mes/production-orders" '{"id":"PO-100","name":"Pump Assembly Order","description":"Execute pump line order","productNumber":"PO-100","productType":"production","lifecycleStatus":"released","category":"manufacturing","baseUnit":"EA","createdBy":"operator"}'

post "/api/v1/mes/operations" '{"id":"OP-100","orderId":"PO-100","name":"Assembly Operation 10","description":"Primary assembly step","bomType":"operation","revision":"1","usage":"execution","plant":"LINE-01","baseQuantity":"1","baseUnit":"EA","isActive":"true","createdBy":"operator"}'

post "/api/v1/mes/work-center-assignments" '{"id":"WCA-10","orderId":"PO-100","title":"Assign Work Center WC-01","description":"Route order to WC-01","priority":"high","status":"open","reason":"Initial dispatch","impact":"Medium","requestedBy":"operator-1","createdBy":"operator"}'

echo "Production Orders:"
curl -sS "$BASE_URL/api/v1/mes/production-orders"
echo

echo "Work Center Assignments:"
curl -sS "$BASE_URL/api/v1/mes/work-center-assignments"
echo
