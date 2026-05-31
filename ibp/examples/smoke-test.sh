#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8132}"
TENANT="${TENANT:-T1}"

fail() {
  echo "SMOKE TEST FAILED: $1" >&2
  exit 1
}

assert_contains() {
  local haystack="$1"
  local needle="$2"
  local message="$3"
  if [[ "$haystack" != *"$needle"* ]]; then
    fail "$message"
  fi
}

echo "Running IBP smoke test against $BASE_URL for tenant $TENANT"

health_code=$(curl -sS -o /dev/null -w "%{http_code}" "$BASE_URL/health") || fail "health endpoint unreachable"
if [[ "$health_code" != "200" ]]; then
  fail "health endpoint returned HTTP $health_code"
fi

BASE_URL="$BASE_URL" TENANT="$TENANT" bash "$(dirname "$0")/seed-data.sh"

warehouses=$(curl -sS "$BASE_URL/api/v1/ibp/demand-plans") || fail "could not fetch warehouses"
assert_contains "$warehouses" '"count":1' "expected warehouse count to be 1"
assert_contains "$warehouses" '"id":"WH-100"' "expected seeded warehouse WH-100"

tasks=$(curl -sS "$BASE_URL/api/v1/ibp/response-plans") || fail "could not fetch warehouse tasks"
assert_contains "$tasks" '"count":1' "expected warehouse task count to be 1"
assert_contains "$tasks" '"id":"WT-10"' "expected seeded warehouse task WT-10"

echo "SMOKE TEST PASSED"
