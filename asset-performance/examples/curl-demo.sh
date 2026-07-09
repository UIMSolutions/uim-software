#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8105}"
TENANT_ID="${TENANT_ID:-demo-tenant}"

hdr=(-H "Content-Type: application/json" -H "X-Tenant-Id: ${TENANT_ID}")

echo "== Seed demo dataset =="
curl -sS -X POST "${BASE_URL}/api/v1/asset-performance/demo/seed" "${hdr[@]}" | jq .

echo "== Equipment endpoints =="
curl -sS "${BASE_URL}/api/v1/asset-performance/equipment" "${hdr[@]}" | jq .
curl -sS "${BASE_URL}/api/v1/asset-performance/equipment/eq-pump-1001" "${hdr[@]}" | jq .
curl -sS -X POST "${BASE_URL}/api/v1/asset-performance/equipment" "${hdr[@]}" -d '{"id":"eq-pump-2001","modelId":"mdl-pump-001","locationId":"loc-plant-a-unit-1","serialNumber":"SN-CP-2001","name":"Feed Pump P-2001","description":"Secondary feed pump","manufacturer":"UIM Industrial","operatorId":"ops-team-a","criticality":"Medium","maintenanceStrategy":"Condition-based","createdBy":"curl-demo"}' | jq .
curl -sS -X PUT "${BASE_URL}/api/v1/asset-performance/equipment/eq-pump-2001" "${hdr[@]}" -d '{"name":"Feed Pump P-2001A","description":"Secondary feed pump updated","maintenanceStrategy":"Risk-based","firmwareVersion":"3.3.0","modifiedBy":"curl-demo"}' | jq .
curl -sS -X DELETE "${BASE_URL}/api/v1/asset-performance/equipment/eq-pump-2001" "${hdr[@]}" | jq .

echo "== Model endpoints =="
curl -sS "${BASE_URL}/api/v1/asset-performance/models" "${hdr[@]}" | jq .
curl -sS "${BASE_URL}/api/v1/asset-performance/models/mdl-pump-001" "${hdr[@]}" | jq .
curl -sS -X POST "${BASE_URL}/api/v1/asset-performance/models" "${hdr[@]}" -d '{"id":"mdl-compressor-001","name":"Compressor Class","description":"Compressor template","manufacturer":"UIM Industrial","version":"1.0","modelNumber":"COMP-01","templateId":"tmpl-comp","isoStandard":"ISO 14224","isPublished":true,"createdBy":"curl-demo"}' | jq .
curl -sS -X PUT "${BASE_URL}/api/v1/asset-performance/models/mdl-compressor-001" "${hdr[@]}" -d '{"name":"Compressor Class v2","description":"Updated compressor template","version":"1.1","modifiedBy":"curl-demo"}' | jq .
curl -sS -X DELETE "${BASE_URL}/api/v1/asset-performance/models/mdl-compressor-001" "${hdr[@]}" | jq .

echo "== Location endpoints =="
curl -sS "${BASE_URL}/api/v1/asset-performance/locations" "${hdr[@]}" | jq .
curl -sS "${BASE_URL}/api/v1/asset-performance/locations/loc-plant-a-unit-1" "${hdr[@]}" | jq .
curl -sS -X POST "${BASE_URL}/api/v1/asset-performance/locations" "${hdr[@]}" -d '{"id":"loc-plant-a-unit-2","name":"Plant A - Unit 2","description":"Secondary unit","address":"Industrial Zone 8","building":"A","floor":"1","room":"Compressor Hall","createdBy":"curl-demo"}' | jq .
curl -sS -X PUT "${BASE_URL}/api/v1/asset-performance/locations/loc-plant-a-unit-2" "${hdr[@]}" -d '{"name":"Plant A - Unit 2 Updated","description":"Secondary unit updated","address":"Industrial Zone 8A","modifiedBy":"curl-demo"}' | jq .
curl -sS -X DELETE "${BASE_URL}/api/v1/asset-performance/locations/loc-plant-a-unit-2" "${hdr[@]}" | jq .

echo "== Failure Mode endpoints =="
curl -sS "${BASE_URL}/api/v1/asset-performance/failure-modes" "${hdr[@]}" | jq .
curl -sS "${BASE_URL}/api/v1/asset-performance/failure-modes/fm-seal-leak" "${hdr[@]}" | jq .
curl -sS -X POST "${BASE_URL}/api/v1/asset-performance/failure-modes" "${hdr[@]}" -d '{"id":"fm-bearing-wear","modelId":"mdl-pump-001","equipmentId":"eq-pump-1001","name":"Bearing Wear","description":"Bearing wear trend","cause":"Insufficient lubrication","effect":"Increased vibration","detection":"Vibration threshold","mitigation":"Lubrication optimization","riskPriorityNumber":"140","occurrenceProbability":"5","detectability":"6","createdBy":"curl-demo"}' | jq .
curl -sS -X PUT "${BASE_URL}/api/v1/asset-performance/failure-modes/fm-bearing-wear" "${hdr[@]}" -d '{"name":"Bearing Wear Updated","description":"Updated description","mitigation":"Planned bearing replacement","modifiedBy":"curl-demo"}' | jq .
curl -sS -X DELETE "${BASE_URL}/api/v1/asset-performance/failure-modes/fm-bearing-wear" "${hdr[@]}" | jq .

echo "== Assessment endpoints =="
curl -sS "${BASE_URL}/api/v1/asset-performance/assessments" "${hdr[@]}" | jq .
curl -sS "${BASE_URL}/api/v1/asset-performance/assessments/asm-risk-1001" "${hdr[@]}" | jq .
curl -sS -X POST "${BASE_URL}/api/v1/asset-performance/assessments" "${hdr[@]}" -d '{"id":"asm-fmea-2001","equipmentId":"eq-pump-1001","modelId":"mdl-pump-001","locationId":"loc-plant-a-unit-1","name":"Pump FMEA Snapshot","description":"Initial FMEA snapshot","templateId":"tmpl-fmea-01","score":"75","riskLevel":"Medium","likelihood":"Medium","consequence":"High","assessedBy":"rel.eng","approvedBy":"maint.mgr","assessmentDate":"2026-07-09","nextReviewDate":"2026-10-09","createdBy":"curl-demo"}' | jq .
curl -sS -X PUT "${BASE_URL}/api/v1/asset-performance/assessments/asm-fmea-2001" "${hdr[@]}" -d '{"name":"Pump FMEA Snapshot Updated","description":"Updated FMEA snapshot","score":"78","riskLevel":"High","modifiedBy":"curl-demo"}' | jq .
curl -sS -X DELETE "${BASE_URL}/api/v1/asset-performance/assessments/asm-fmea-2001" "${hdr[@]}" | jq .

echo "== Instruction endpoints =="
curl -sS "${BASE_URL}/api/v1/asset-performance/instructions" "${hdr[@]}" | jq .
curl -sS "${BASE_URL}/api/v1/asset-performance/instructions/ins-maint-1001" "${hdr[@]}" | jq .
curl -sS -X POST "${BASE_URL}/api/v1/asset-performance/instructions" "${hdr[@]}" -d '{"id":"ins-lube-2001","modelId":"mdl-pump-001","equipmentId":"eq-pump-1001","name":"Pump Lubrication","description":"Monthly lubrication","instructionType":"maintenance","priority":"medium","version":"1.0","steps":"Inspect level and refill","safetyNotes":"Wear gloves","requiredTools":"Grease gun","estimatedDuration":"20m","publishedBy":"maint.mgr","effectiveDate":"2026-07-10","createdBy":"curl-demo"}' | jq .
curl -sS -X PUT "${BASE_URL}/api/v1/asset-performance/instructions/ins-lube-2001" "${hdr[@]}" -d '{"name":"Pump Lubrication Updated","description":"Monthly lubrication updated","version":"1.1","modifiedBy":"curl-demo"}' | jq .
curl -sS -X DELETE "${BASE_URL}/api/v1/asset-performance/instructions/ins-lube-2001" "${hdr[@]}" | jq .

echo "== Function endpoints =="
curl -sS "${BASE_URL}/api/v1/asset-performance/functions" "${hdr[@]}" | jq .
curl -sS "${BASE_URL}/api/v1/asset-performance/functions/fn-feed-transfer" "${hdr[@]}" | jq .
curl -sS -X POST "${BASE_URL}/api/v1/asset-performance/functions" "${hdr[@]}" -d '{"id":"fn-cooling-circulation","equipmentId":"eq-pump-1001","modelId":"mdl-pump-001","locationId":"loc-plant-a-unit-1","name":"Cooling Circulation","description":"Support cooling loop","status":"operational","operatingContext":"24x7","performanceStandard":"Flow >= 120 m3/h","failureDefinition":"Flow < 100 m3/h","redundancy":"N+1","createdBy":"curl-demo"}' | jq .
curl -sS -X PUT "${BASE_URL}/api/v1/asset-performance/functions/fn-cooling-circulation" "${hdr[@]}" -d '{"name":"Cooling Circulation Updated","description":"Updated context","performanceStandard":"Flow >= 130 m3/h","modifiedBy":"curl-demo"}' | jq .
curl -sS -X DELETE "${BASE_URL}/api/v1/asset-performance/functions/fn-cooling-circulation" "${hdr[@]}" | jq .

echo "== Indicator endpoints =="
curl -sS "${BASE_URL}/api/v1/asset-performance/indicators" "${hdr[@]}" | jq .
curl -sS "${BASE_URL}/api/v1/asset-performance/indicators/ind-vibration-1001" "${hdr[@]}" | jq .
curl -sS -X POST "${BASE_URL}/api/v1/asset-performance/indicators" "${hdr[@]}" -d '{"id":"ind-temp-2001","equipmentId":"eq-pump-1001","modelId":"mdl-pump-001","name":"Bearing Temperature","description":"Bearing temperature trend","indicatorType":"temperature","status":"normal","value":"62","unit":"C","thresholdWarning":"75","thresholdCritical":"85","measuredAt":"2026-07-09T10:30:00Z","createdBy":"curl-demo"}' | jq .
curl -sS -X DELETE "${BASE_URL}/api/v1/asset-performance/indicators/ind-temp-2001" "${hdr[@]}" | jq .

echo "== Health endpoint =="
curl -sS "${BASE_URL}/health" | jq .

echo "Completed curl flow for all endpoints."
