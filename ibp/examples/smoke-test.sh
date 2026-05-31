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

demand=$(curl -sS "$BASE_URL/api/v1/ibp/demand-plans") || fail "could not fetch demand plans"
assert_contains "$demand" '"count":1' "expected demand plan count to be 1"
assert_contains "$demand" '"id":"DP-100"' "expected seeded demand plan DP-100"

response=$(curl -sS "$BASE_URL/api/v1/ibp/response-plans") || fail "could not fetch response plans"
assert_contains "$response" '"count":1' "expected response plan count to be 1"
assert_contains "$response" '"id":"RP-10"' "expected seeded response plan RP-10"

echo "SMOKE TEST PASSED"
