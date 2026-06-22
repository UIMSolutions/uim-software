#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8141}"
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

echo "Seeding PPM sample data to $BASE_URL for tenant $TENANT"

post "/api/v1/ppm/portfolios" '{"id":"PF-100","name":"Digital Transformation 2026","description":"Strategic cloud and process modernization","strategicTheme":"Operational Excellence","status":"planning","planningHorizon":"FY2026","owner":"PMO","budgetAmount":"2500000","currency":"EUR","createdBy":"seed"}'

post "/api/v1/ppm/initiatives" '{"id":"IN-200","portfolioId":"PF-100","title":"Factory Platform Upgrade","description":"Upgrade core manufacturing platforms","category":"Transformation","priority":"high","status":"new","sponsor":"CTO","expectedBenefits":"Reduced downtime and faster releases","createdBy":"seed"}'

post "/api/v1/ppm/programs" '{"id":"PRG-300","portfolioId":"PF-100","name":"Manufacturing Program","objective":"Deliver standardized smart-factory capabilities","status":"draft","manager":"program.lead","startDate":"2026-01-01","endDate":"2026-12-31","createdBy":"seed"}'

post "/api/v1/ppm/projects" '{"id":"PJ-400","programId":"PRG-300","name":"MES Rollout Wave 1","description":"Deploy MES stack to pilot plant","projectType":"deployment","status":"planned","startDate":"2026-03-01","endDate":"2026-08-31","projectManager":"project.lead","budgetAmount":"780000","currency":"EUR","createdBy":"seed"}'

post "/api/v1/ppm/demands" '{"id":"DM-500","portfolioId":"PF-100","title":"Quality Dashboard Enhancement","description":"Real-time dashboard for plant QA KPIs","source":"business","businessValue":"Reduce quality incidents","priority":"medium","status":"submitted","requestedBy":"qa.manager","createdBy":"seed"}'

post "/api/v1/ppm/resource-requests" '{"id":"RR-600","projectId":"PJ-400","role":"MES Consultant","quantity":"2","allocationPercent":"100","startDate":"2026-03-15","endDate":"2026-07-31","status":"requested","requestedBy":"project.lead","createdBy":"seed"}'

echo "Portfolios:"
curl -sS "$BASE_URL/api/v1/ppm/portfolios"
echo

echo "Projects:"
curl -sS "$BASE_URL/api/v1/ppm/projects"
echo
