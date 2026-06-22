#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8141}"
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

echo "Running PPM smoke test against $BASE_URL for tenant $TENANT"

health_code=$(curl -sS -o /dev/null -w "%{http_code}" "$BASE_URL/health") || fail "health endpoint unreachable"
if [[ "$health_code" != "200" ]]; then
  fail "health endpoint returned HTTP $health_code"
fi

BASE_URL="$BASE_URL" TENANT="$TENANT" bash "$(dirname "$0")/seed-data.sh"

portfolios=$(curl -sS "$BASE_URL/api/v1/ppm/portfolios") || fail "could not fetch portfolios"
assert_contains "$portfolios" '"count":1' "expected portfolio count to be 1"
assert_contains "$portfolios" '"id":"PF-100"' "expected seeded portfolio PF-100"

projects=$(curl -sS "$BASE_URL/api/v1/ppm/projects") || fail "could not fetch projects"
assert_contains "$projects" '"count":1' "expected project count to be 1"
assert_contains "$projects" '"id":"PJ-400"' "expected seeded project PJ-400"

requests=$(curl -sS "$BASE_URL/api/v1/ppm/resource-requests") || fail "could not fetch resource requests"
assert_contains "$requests" '"count":1' "expected resource request count to be 1"
assert_contains "$requests" '"id":"RR-600"' "expected seeded resource request RR-600"

echo "SMOKE TEST PASSED"
