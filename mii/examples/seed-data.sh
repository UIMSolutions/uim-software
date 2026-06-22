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

echo "Seeding MII sample data to $BASE_URL for tenant $TENANT"

post "/api/v1/mii/production-messages" '{"id":"MSG-100","name":"Line-1 Production Message","description":"Normalized payload from PLC gateway","productNumber":"MSG-100","productType":"message","lifecycleStatus":"received","category":"integration","baseUnit":"EA","createdBy":"integrator"}'

post "/api/v1/mii/work-center-events" '{"id":"EVT-100","messageId":"MSG-100","name":"Work Center Event Start","description":"Machine cycle start event","bomType":"event","revision":"1","usage":"capture","plant":"WC-01","baseQuantity":"1","baseUnit":"EA","isActive":"true","createdBy":"integrator"}'

post "/api/v1/mii/data-collections" '{"id":"COL-10","messageId":"MSG-100","title":"Temperature Collection","description":"Collect thermal sensor values","priority":"high","status":"open","reason":"KPI feed","impact":"Medium","requestedBy":"integrator-1","createdBy":"integrator"}'

echo "Production Messages:"
curl -sS "$BASE_URL/api/v1/mii/production-messages"
echo

echo "Data Collections:"
curl -sS "$BASE_URL/api/v1/mii/data-collections"
echo
