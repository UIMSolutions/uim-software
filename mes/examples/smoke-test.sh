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

echo "Running MES smoke test against $BASE_URL for tenant $TENANT"

health_code=$(curl -sS -o /dev/null -w "%{http_code}" "$BASE_URL/health") || fail "health endpoint unreachable"
if [[ "$health_code" != "200" ]]; then
  fail "health endpoint returned HTTP $health_code"
fi

BASE_URL="$BASE_URL" TENANT="$TENANT" bash "$(dirname "$0")/seed-data.sh"

orders=$(curl -sS "$BASE_URL/api/v1/mes/production-orders") || fail "could not fetch production orders"
assert_contains "$orders" '"count":1' "expected production order count to be 1"
assert_contains "$orders" '"id":"PO-100"' "expected seeded production order PO-100"

assignments=$(curl -sS "$BASE_URL/api/v1/mes/work-center-assignments") || fail "could not fetch work center assignments"
assert_contains "$assignments" '"count":1' "expected assignment count to be 1"
assert_contains "$assignments" '"id":"WCA-10"' "expected seeded assignment WCA-10"

echo "SMOKE TEST PASSED"
