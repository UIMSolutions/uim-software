# Administration Guide

## Build And Run

```bash
cd mm
dub build
dub run
```

## Validate

```bash
cd mm
dub test
```

## Runtime Configuration

- `MM_HOST`: bind host, default `0.0.0.0`
- `MM_PORT`: bind port, default `8150`
- `MM_STORAGE`: `memory` or `file`, default `memory`
- `MM_STORAGE_PATH`: file repository directory, default `.data/mm`

## Operational Notes

- The current implementation uses in-memory adapters intended for reference, testing, and local demonstrations.
- Procurement and inventory repositories can be switched to JSON file persistence through `MM_STORAGE=file`.
- Write operations accept `X-Tenant-Id` and persist it on created business objects.
- Goods receipts update stock and purchase order receipt progress inside the same application boundary.

## Smoke Test

```bash
MM_STORAGE=file MM_STORAGE_PATH=.data/mm dub run
./examples/http-smoke.sh
```

## Recommended Production Hardening

1. Replace memory adapters with persistent repository adapters.
2. Add authentication and authorization in front of all write endpoints.
3. Persist an immutable audit trail for purchase and inventory movements.
4. Externalize master data synchronization with ERP or supplier systems.
