# Material Requirements Planning Service (PP-MRP)

A microservice implementing a solution similar to SAP Material Requirements Planning (PP-MRP) in SAP S/4HANA On-Premise, built with D (dlang) and vibe.d using a combination of clean and hexagonal architecture.

Reference description: [SAP S/4HANA On-Premise - Material Requirements Planning (PP-MRP)](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/fe39e10a9a864a8f8dc9537704f0fa13/a084b853dcfcb44ce10000000a174cb4.html?locale=en-US)

## SAP PP-MRP Alignment

This service mirrors the core PP-MRP goals and process patterns from SAP documentation:

- Guarantee material availability in the required quantity and time
- Monitor stock, receipts, and reservations
- Automatically create procurement proposals for shortages
- Balance service level and inventory/capital lockup
- Support plant-level planning with extensibility toward MRP area planning
- Integrate material master, BOM structures, and demand-driven planning

## Features

- **Material Master for Planning**
- **Plant Planning Context**
- **Bill of Material Explosion Support**
- **Inventory Position Monitoring**
- **Automatic MRP Planning Run**
- **Procurement Proposal Generation**

### Procurement proposals produced by run

- Planned orders (in-house and mixed procurement)
- Purchase requisitions (external procurement)
- Exception messages attached to proposals

## Architecture

```
source/
  uim/platform/mrp/
    domain/           # Entities, types, repository interfaces, domain validators
    application/      # DTOs and MRP-focused use cases
    infrastructure/   # Configuration, DI container, in-memory persistence adapters
    presentation/     # HTTP controllers and JSON serializers
```

### Layers

| Layer | Responsibility |
|-------|---------------|
| **Domain** | `Material`, `Plant`, `BillOfMaterial`, `InventoryPosition`, `MrpRun`, `ProcurementProposal` and repository ports |
| **Application** | CRUD use cases plus `ManageMrpRunsUseCase` that executes net requirement logic and creates proposals |
| **Infrastructure** | In-memory adapter implementations, environment-driven config, dependency wiring |
| **Presentation** | REST endpoints with JSON payloads and tenant-aware request handling |

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/mrp/materials` | List materials |
| POST | `/api/v1/mrp/materials` | Create material |
| GET | `/api/v1/mrp/materials/:id` | Get material |
| PUT | `/api/v1/mrp/materials/:id` | Update material |
| DELETE | `/api/v1/mrp/materials/:id` | Delete material |
| GET | `/api/v1/mrp/plants` | List plants |
| POST | `/api/v1/mrp/plants` | Create plant |
| GET | `/api/v1/mrp/plants/:id` | Get plant |
| PUT | `/api/v1/mrp/plants/:id` | Update plant |
| DELETE | `/api/v1/mrp/plants/:id` | Delete plant |
| GET | `/api/v1/mrp/bills-of-material` | List BOM entries |
| POST | `/api/v1/mrp/bills-of-material` | Create BOM entry |
| GET | `/api/v1/mrp/bills-of-material/:id` | Get BOM entry |
| PUT | `/api/v1/mrp/bills-of-material/:id` | Update BOM entry |
| DELETE | `/api/v1/mrp/bills-of-material/:id` | Delete BOM entry |
| GET | `/api/v1/mrp/inventory-positions` | List inventory positions |
| POST | `/api/v1/mrp/inventory-positions` | Create inventory position |
| GET | `/api/v1/mrp/inventory-positions/:id` | Get inventory position |
| PUT | `/api/v1/mrp/inventory-positions/:id` | Update inventory position |
| DELETE | `/api/v1/mrp/inventory-positions/:id` | Delete inventory position |
| GET | `/api/v1/mrp/runs` | List MRP runs |
| POST | `/api/v1/mrp/runs` | Execute MRP run |
| GET | `/api/v1/mrp/runs/:id` | Get MRP run |
| PUT | `/api/v1/mrp/runs/:id` | Update MRP run |
| DELETE | `/api/v1/mrp/runs/:id` | Delete MRP run |
| GET | `/api/v1/mrp/procurement-proposals` | List generated proposals |
| POST | `/api/v1/mrp/procurement-proposals` | Create proposal manually |
| GET | `/api/v1/mrp/procurement-proposals/:id` | Get proposal |
| PUT | `/api/v1/mrp/procurement-proposals/:id` | Update proposal |
| DELETE | `/api/v1/mrp/procurement-proposals/:id` | Delete proposal |
| GET | `/health` | Health check |

All POST/PUT requests use `X-Tenant-Id` for tenant isolation.

## Configuration

| Environment Variable | Default | Description |
|---------------------|---------|-------------|
| `MRP_HOST` | `0.0.0.0` | HTTP listen address |
| `MRP_PORT` | `8119` | HTTP listen port |

## Build and Run

```bash
# Build
dub build

# Run
dub run

# Test
dub test
```

## Seed Data and End-to-End Curl Scenario

Run the service:

```bash
dub run
```

In a second terminal, execute the complete sample flow:

```bash
bash examples/seed-data.sh
```

The script creates:

- Plant `PLANT-1000`
- Materials `FG-BIKE` and `RM-WHEEL`
- BOM relation `FG-BIKE` -> `RM-WHEEL`
- Inventory positions
- One MRP run that creates procurement proposals

Equivalent manual curl flow:

```bash
export BASE_URL=http://localhost:8119
export TENANT=T1

curl -sS -X POST "$BASE_URL/api/v1/mrp/plants" \
  -H "Content-Type: application/json" -H "X-Tenant-Id: $TENANT" \
  -d '{"id":"PLANT-1000","name":"Main Plant","plantCode":"1000","planningScope":"plant","country":"DE"}'

curl -sS -X POST "$BASE_URL/api/v1/mrp/materials" \
  -H "Content-Type: application/json" -H "X-Tenant-Id: $TENANT" \
  -d '{"id":"FG-BIKE","plantId":"PLANT-1000","name":"Finished Bike","materialNumber":"FG-BIKE","mrpProcedure":"materialRequirementsPlanning","lotSizingProcedure":"fixedLotSize","procurementType":"inHouse","status":"active","independentDemand":"20","lotSize":"10","safetyStock":"0"}'

curl -sS -X POST "$BASE_URL/api/v1/mrp/materials" \
  -H "Content-Type: application/json" -H "X-Tenant-Id: $TENANT" \
  -d '{"id":"RM-WHEEL","plantId":"PLANT-1000","name":"Wheel","materialNumber":"RM-WHEEL","mrpProcedure":"materialRequirementsPlanning","lotSizingProcedure":"lotForLot","procurementType":"external","status":"active","independentDemand":"0","safetyStock":"0"}'

curl -sS -X POST "$BASE_URL/api/v1/mrp/bills-of-material" \
  -H "Content-Type: application/json" -H "X-Tenant-Id: $TENANT" \
  -d '{"id":"BOM-1","plantId":"PLANT-1000","name":"Bike BOM","parentMaterialId":"FG-BIKE","componentMaterialId":"RM-WHEEL","componentQuantity":"2","baseQuantity":"1"}'

curl -sS -X POST "$BASE_URL/api/v1/mrp/inventory-positions" \
  -H "Content-Type: application/json" -H "X-Tenant-Id: $TENANT" \
  -d '{"id":"INV-FG","plantId":"PLANT-1000","materialId":"FG-BIKE","stockSegment":"unrestricted","onHandQuantity":"0","scheduledReceipts":"0","reservedQuantity":"0"}'

curl -sS -X POST "$BASE_URL/api/v1/mrp/inventory-positions" \
  -H "Content-Type: application/json" -H "X-Tenant-Id: $TENANT" \
  -d '{"id":"INV-RM","plantId":"PLANT-1000","materialId":"RM-WHEEL","stockSegment":"unrestricted","onHandQuantity":"5","scheduledReceipts":"0","reservedQuantity":"0"}'

curl -sS -X POST "$BASE_URL/api/v1/mrp/runs" \
  -H "Content-Type: application/json" -H "X-Tenant-Id: $TENANT" \
  -d '{"id":"RUN-1","plantId":"PLANT-1000","name":"Daily Run","mode":"regenerative","planningDate":"2026-05-28","executedBy":"planner"}'

curl -sS "$BASE_URL/api/v1/mrp/procurement-proposals" | jq
```

### Enum payload support

The API now accepts enum values as strings for these fields:

- `materials`: `mrpProcedure`, `lotSizingProcedure`, `procurementType`, `status`
- `plants`: `planningScope`
- `inventory-positions`: `stockSegment`
- `runs`: `mode`, `status`
- `procurement-proposals`: `proposalType`, `status`

Invalid enum strings gracefully fall back to current/default values.

## Docker

```bash
docker build -t uim-platform/mrp:latest .
docker run -p 8119:8119 uim-platform/mrp:latest
```

## Kubernetes

```bash
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

## License

Apache-2.0
