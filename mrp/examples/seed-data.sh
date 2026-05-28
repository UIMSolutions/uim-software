#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8119}"
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

echo "Seeding PP-MRP sample data to $BASE_URL for tenant $TENANT"

post "/api/v1/mrp/plants" '{"id":"PLANT-1000","name":"Main Plant","plantCode":"1000","planningScope":"plant","country":"DE","createdBy":"seed"}'

post "/api/v1/mrp/materials" '{"id":"FG-BIKE","plantId":"PLANT-1000","name":"Finished Bike","materialNumber":"FG-BIKE","mrpProcedure":"materialRequirementsPlanning","lotSizingProcedure":"fixedLotSize","procurementType":"inHouse","status":"active","independentDemand":"20","lotSize":"10","minimumLotSize":"0","safetyStock":"0","createdBy":"seed"}'

post "/api/v1/mrp/materials" '{"id":"RM-WHEEL","plantId":"PLANT-1000","name":"Wheel","materialNumber":"RM-WHEEL","mrpProcedure":"materialRequirementsPlanning","lotSizingProcedure":"lotForLot","procurementType":"external","status":"active","independentDemand":"0","lotSize":"0","minimumLotSize":"0","safetyStock":"0","createdBy":"seed"}'

post "/api/v1/mrp/bills-of-material" '{"id":"BOM-1","plantId":"PLANT-1000","name":"Bike BOM","parentMaterialId":"FG-BIKE","componentMaterialId":"RM-WHEEL","componentQuantity":"2","baseQuantity":"1","createdBy":"seed"}'

post "/api/v1/mrp/inventory-positions" '{"id":"INV-FG","plantId":"PLANT-1000","materialId":"FG-BIKE","stockSegment":"unrestricted","onHandQuantity":"0","scheduledReceipts":"0","reservedQuantity":"0","createdBy":"seed"}'

post "/api/v1/mrp/inventory-positions" '{"id":"INV-RM","plantId":"PLANT-1000","materialId":"RM-WHEEL","stockSegment":"unrestricted","onHandQuantity":"5","scheduledReceipts":"0","reservedQuantity":"0","createdBy":"seed"}'

post "/api/v1/mrp/runs" '{"id":"RUN-1","plantId":"PLANT-1000","name":"Daily Run","mode":"regenerative","planningDate":"2026-05-28","horizonDays":"30","executedBy":"planner","executedAt":"2026-05-28T10:00:00Z"}'

echo "Procurement proposals:"
curl -sS "$BASE_URL/api/v1/mrp/procurement-proposals"
echo
