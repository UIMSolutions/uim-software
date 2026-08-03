# Supply Chain Network Service

This module provides a D/vibe.d implementation of a supply-chain collaboration service inspired by SAP Business Network for Supply Chain.

## Architecture

- Domain: partner, order, shipment, ship notice, invoice, and alert entities.
- Application: use-case service for exposing network data.
- Infrastructure: in-memory repository backed by a hexagonal port.
- Presentation: HTTP controllers and a lightweight web client.

## Run

```bash
dub --root bn-supply-chain run --config=defaultRun
```

## Test

```bash
dub --root bn-supply-chain test
```
