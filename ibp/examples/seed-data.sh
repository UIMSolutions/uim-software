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

echo "Seeding IBP sample data to $BASE_URL for tenant $TENANT"

post "/api/v1/ibp/demand-plans" '{"id":"WH-100","name":"Central Warehouse","description":"Main distribution warehouse","productNumber":"WH-100","productType":"warehouse","lifecycleStatus":"active","category":"logistics","baseUnit":"EA","createdBy":"seed"}'

post "/api/v1/ibp/supply-plans" '{"id":"BIN-100","demandPlanId":"WH-100","name":"Aisle 01 Bin 01","description":"Primary putaway bin","bomType":"storage","revision":"1","usage":"putaway","plant":"DC-01","baseQuantity":"1","baseUnit":"EA","isActive":"true","createdBy":"seed"}'

post "/api/v1/ibp/response-plans" '{"id":"WT-10","demandPlanId":"WH-100","title":"Putaway pallet","description":"Move inbound pallet to BIN-100","priority":"high","status":"open","reason":"Inbound receipt","impact":"Medium","requestedBy":"planner-1","createdBy":"seed"}'

echo "Warehouses:"
curl -sS "$BASE_URL/api/v1/ibp/demand-plans"
echo

echo "Warehouse Tasks:"
curl -sS "$BASE_URL/api/v1/ibp/response-plans"
echo
