#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8119}"
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

assert_jq() {
  local json="$1"
  local query="$2"
  local message="$3"
  if ! printf '%s' "$json" | jq -e "$query" >/dev/null; then
    fail "$message"
  fi
}

echo "Running MRP smoke test against $BASE_URL for tenant $TENANT"

health_code=$(curl -sS -o /dev/null -w "%{http_code}" "$BASE_URL/health") || fail "health endpoint unreachable"
if [[ "$health_code" != "200" ]]; then
  fail "health endpoint returned HTTP $health_code"
fi

echo "Health check passed"

BASE_URL="$BASE_URL" TENANT="$TENANT" bash "$(dirname "$0")/seed-data.sh"

proposals=$(curl -sS "$BASE_URL/api/v1/mrp/procurement-proposals") || fail "could not fetch procurement proposals"

echo "Validating generated procurement proposals"
if command -v jq >/dev/null 2>&1; then
  echo "jq detected: using strict JSON assertions"
  assert_jq "$proposals" '.count == 2' "expected exactly 2 procurement proposals"
  assert_jq "$proposals" '.resources | length == 2' "resources array should contain exactly 2 proposals"
  assert_jq "$proposals" '.resources | any(.materialId == "FG-BIKE" and .proposalType == "plannedOrder" and (.quantity | tonumber) == 20)' "FG-BIKE proposal mismatch (expected plannedOrder with quantity 20)"
  assert_jq "$proposals" '.resources | any(.materialId == "RM-WHEEL" and .proposalType == "purchaseRequisition" and (.quantity | tonumber) == 35)' "RM-WHEEL proposal mismatch (expected purchaseRequisition with quantity 35)"
else
  echo "jq not found: using fallback string assertions"
  assert_contains "$proposals" '"count":2' "expected exactly 2 procurement proposals"
  assert_contains "$proposals" '"materialId":"FG-BIKE"' "missing proposal for FG-BIKE"
  assert_contains "$proposals" '"proposalType":"plannedOrder"' "FG-BIKE proposal should be plannedOrder"
  assert_contains "$proposals" '"quantity":"20"' "FG-BIKE proposal quantity should include lot sizing result 20"
  assert_contains "$proposals" '"materialId":"RM-WHEEL"' "missing proposal for RM-WHEEL"
  assert_contains "$proposals" '"proposalType":"purchaseRequisition"' "RM-WHEEL proposal should be purchaseRequisition"
  assert_contains "$proposals" '"quantity":"35"' "RM-WHEEL proposal quantity should include BOM explosion shortage 35"
fi

echo "SMOKE TEST PASSED"
