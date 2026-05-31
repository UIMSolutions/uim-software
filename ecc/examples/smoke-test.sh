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

echo "Running EPD smoke test against $BASE_URL for tenant $TENANT"

health_code=$(curl -sS -o /dev/null -w "%{http_code}" "$BASE_URL/health") || fail "health endpoint unreachable"
if [[ "$health_code" != "200" ]]; then
  fail "health endpoint returned HTTP $health_code"
fi

BASE_URL="$BASE_URL" TENANT="$TENANT" bash "$(dirname "$0")/seed-data.sh"

products=$(curl -sS "$BASE_URL/api/v1/ecc/materials") || fail "could not fetch products"
assert_contains "$products" '"count":1' "expected product count to be 1"
assert_contains "$products" '"id":"P-100"' "expected seeded product P-100"

changes=$(curl -sS "$BASE_URL/api/v1/ecc/change-requests") || fail "could not fetch change requests"
assert_contains "$changes" '"count":1' "expected change request count to be 1"
assert_contains "$changes" '"id":"CR-10"' "expected seeded change request CR-10"

echo "SMOKE TEST PASSED"
