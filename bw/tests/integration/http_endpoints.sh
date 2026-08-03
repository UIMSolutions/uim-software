#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
LOG_FILE="${PROJECT_ROOT}/tests/integration/bw-integration.log"
PORT="${BW_IT_PORT:-8390}"
BASE_URL="http://127.0.0.1:${PORT}"
AUTH_HEADER="Authorization: Bearer integration-token"
ROLE_HEADER="X-BW-Roles: bw.admin"
TENANT_HEADER="X-Tenant-Id: it-tenant"

cleanup() {
  if [[ -n "${SERVER_PID:-}" ]]; then
    kill "${SERVER_PID}" >/dev/null 2>&1 || true
    wait "${SERVER_PID}" 2>/dev/null || true
  fi
}
trap cleanup EXIT

cd "${PROJECT_ROOT}"
BW_PORT="${PORT}" BW_REPOSITORY=memory dub run >"${LOG_FILE}" 2>&1 &
SERVER_PID=$!

for _ in $(seq 1 60); do
  if curl -fsS "${BASE_URL}/health" >/dev/null 2>&1; then
    break
  fi
  sleep 0.2
done

curl -fsS "${BASE_URL}/health" >/dev/null

create_response="$(curl -fsS -X POST "${BASE_URL}/api/v1/bw/composite-providers" \
  -H "${AUTH_HEADER}" \
  -H "${ROLE_HEADER}" \
  -H "${TENANT_HEADER}" \
  -H "Content-Type: application/json" \
  -d '{"id":"CP-IT-1","technicalName":"ZCP_IT","businessName":"Integration Provider","createdBy":"integration"}')"

echo "${create_response}" | grep -q '"id"'

get_response="$(curl -fsS "${BASE_URL}/api/v1/bw/composite-providers/CP-IT-1" \
  -H "${AUTH_HEADER}" \
  -H "${ROLE_HEADER}")"

echo "${get_response}" | grep -q '"technicalName":"ZCP_IT"'

list_response="$(curl -fsS "${BASE_URL}/api/v1/bw/composite-providers" \
  -H "${AUTH_HEADER}" \
  -H "${ROLE_HEADER}")"

echo "${list_response}" | grep -q '"count"'

query_response="$(curl -fsS -X POST "${BASE_URL}/api/v1/bw/query-executions" \
  -H "${AUTH_HEADER}" \
  -H "${ROLE_HEADER}" \
  -H "Content-Type: application/json" \
  -d '{"providerId":"CP-IT-1","queryId":"Q-IT-1","language":"EN","variables":{"FISCYEAR":"2026"}}')"

echo "${query_response}" | grep -q '"meta"'

search_response="$(curl -fsS "${BASE_URL}/api/v1/bw/search/models?q=integration" \
  -H "${AUTH_HEADER}" \
  -H "${ROLE_HEADER}")"

echo "${search_response}" | grep -q '"resources"'

catalog_response="$(curl -fsS "${BASE_URL}/api/v1/bw/api-catalog" \
  -H "${AUTH_HEADER}" \
  -H "${ROLE_HEADER}")"

echo "${catalog_response}" | grep -q '"resources"'

echo "BW HTTP integration tests passed"
