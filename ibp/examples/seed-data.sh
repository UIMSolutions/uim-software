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

post "/api/v1/ibp/demand-plans" '{"id":"DP-100","name":"Baseline Demand Q3","description":"Consensus demand plan for Q3","productNumber":"DP-100","productType":"demand","lifecycleStatus":"active","category":"planning","baseUnit":"EA","createdBy":"planner"}'

post "/api/v1/ibp/supply-plans" '{"id":"SP-100","demandPlanId":"DP-100","name":"Constrained Supply Q3","description":"Supply balancing scenario","bomType":"supply","revision":"1","usage":"planning","plant":"PLN-01","baseQuantity":"1","baseUnit":"EA","isActive":"true","createdBy":"planner"}'

post "/api/v1/ibp/response-plans" '{"id":"RP-10","demandPlanId":"DP-100","title":"Accelerate supply lane","description":"Response plan for demand spike","priority":"high","status":"open","reason":"Forecast uplift","impact":"Medium","requestedBy":"planner-1","createdBy":"planner"}'

echo "Demand Plans:"
curl -sS "$BASE_URL/api/v1/ibp/demand-plans"
echo

echo "Response Plans:"
curl -sS "$BASE_URL/api/v1/ibp/response-plans"
echo
