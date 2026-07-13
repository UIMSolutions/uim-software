#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8140}"
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

echo "Running Freight Collaboration smoke test against $BASE_URL for tenant $TENANT"

health_code=$(curl -sS -o /dev/null -w "%{http_code}" "$BASE_URL/health") || fail "health endpoint unreachable"
if [[ "$health_code" != "200" ]]; then
  fail "health endpoint returned HTTP $health_code"
fi

BASE_URL="$BASE_URL" TENANT="$TENANT" bash "$(dirname "$0")/seed-data.sh"

orders=$(curl -sS "$BASE_URL/api/v1/freight-collaboration/freight-orders") || fail "could not fetch freight orders"
assert_contains "$orders" '"count":1' "expected freight order count to be 1"
assert_contains "$orders" '"id":"FO-100"' "expected seeded freight order FO-100"

tenders=$(curl -sS "$BASE_URL/api/v1/freight-collaboration/tenders") || fail "could not fetch tenders"
assert_contains "$tenders" '"count":1' "expected tender count to be 1"
assert_contains "$tenders" '"id":"TEN-100"' "expected seeded tender TEN-100"

echo "SMOKE TEST PASSED"
