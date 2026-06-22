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

echo "Running MII smoke test against $BASE_URL for tenant $TENANT"

health_code=$(curl -sS -o /dev/null -w "%{http_code}" "$BASE_URL/health") || fail "health endpoint unreachable"
if [[ "$health_code" != "200" ]]; then
  fail "health endpoint returned HTTP $health_code"
fi

BASE_URL="$BASE_URL" TENANT="$TENANT" bash "$(dirname "$0")/seed-data.sh"

messages=$(curl -sS "$BASE_URL/api/v1/mii/production-messages") || fail "could not fetch production messages"
assert_contains "$messages" '"count":1' "expected production message count to be 1"
assert_contains "$messages" '"id":"MSG-100"' "expected seeded production message MSG-100"

collections=$(curl -sS "$BASE_URL/api/v1/mii/data-collections") || fail "could not fetch data collections"
assert_contains "$collections" '"count":1' "expected data collection count to be 1"
assert_contains "$collections" '"id":"COL-10"' "expected seeded data collection COL-10"

echo "SMOKE TEST PASSED"
