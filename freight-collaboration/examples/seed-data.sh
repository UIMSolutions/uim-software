#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8140}"
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

echo "Seeding Freight Collaboration sample data to $BASE_URL for tenant $TENANT"

post "/api/v1/freight-collaboration/freight-orders" '{"id":"FO-100","orderNumber":"45000023","shipperId":"SHIP-01","carrierId":"CAR-09","transportMode":"road","originLocation":"Berlin","destinationLocation":"Hamburg","plannedPickup":"2026-07-15T08:00:00Z","plannedDelivery":"2026-07-16T16:00:00Z","createdBy":"seed"}'

post "/api/v1/freight-collaboration/tenders" '{"id":"TEN-100","freightOrderId":"FO-100","tenderNumber":"TND-2026-1","offeredRate":"1200.00","currency":"EUR","responseBy":"2026-07-14T12:00:00Z","createdBy":"seed"}'

post "/api/v1/freight-collaboration/milestones" '{"id":"MS-100","freightOrderId":"FO-100","milestoneType":"departed-origin","eventTime":"2026-07-15T09:00:00Z","location":"Berlin","statusComment":"Truck departed shipper site","reportedBy":"carrier-ops","createdBy":"seed"}'

echo "Freight Orders:"
curl -sS "$BASE_URL/api/v1/freight-collaboration/freight-orders"
echo

echo "Tenders:"
curl -sS "$BASE_URL/api/v1/freight-collaboration/tenders"
echo

echo "Milestones:"
curl -sS "$BASE_URL/api/v1/freight-collaboration/milestones"
echo
