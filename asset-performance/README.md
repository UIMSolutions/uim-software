# Asset Performance Management Service

A microservice implementing features similar to SAP Asset Performance Management (SAP APM) - a comprehensive solution for managing equipment strategies, failure mode analysis (FMEA), risk and criticality assessments, maintenance instructions, functional specifications, and performance indicators.

This service is designed for outcome-based operations with high asset availability and resilient, safe operations, with support for risk-based maintenance and condition monitoring.

Note: This is an open implementation inspired by SAP APM concepts, not an SAP product.

Built with D (dlang) and vibe.d using a combination of clean and hexagonal architecture patterns.

## Features

- **Asset Data and Information Management** - Explore technical objects, maintain class-like templates, and model hierarchical industrial systems
- **Asset Risk Assessment** - Classify assets by risk and criticality score to prioritize maintenance
- **Asset Reliability Engineering** - Use RCM/FMEA-oriented modeling to define failure modes, consequences, and mitigation strategies
- **Asset Health Monitoring** - Capture indicators and threshold states to support proactive maintenance backlogs
- **Asset Performance Analysis** - Provide input data structures for probability-of-failure and trend analytics

- **Equipment Management** - Physical asset registry with criticality ratings, maintenance strategies, lifecycle tracking, and firmware versioning
- **Model Management** - Equipment model templates with ISO standards, categorization, versioning, and publishing workflows
- **Location Management** - Hierarchical functional locations (buildings, floors, rooms) with geospatial coordinates
- **Failure Mode Analysis (FMEA)** - Failure mode definitions with cause, effect, detection, mitigation, severity, risk priority numbers, and detectability scoring
- **Assessment Management** - Risk assessments, criticality assessments, RCM analysis, and checklists with scoring, likelihood, consequence, and review scheduling
- **Instruction Management** - Maintenance task instructions with steps, safety notes, required tools, estimated durations, and version control
- **Function Management** - Functional specifications defining operating context, performance standards, failure definitions, and redundancy
- **Performance Indicators** - Equipment measurements (temperature, pressure, vibration, etc.) with warning and critical thresholds

## Architecture

```
source/
  uim/platform/asset_performance/
    domain/           # Entities, repository interfaces, domain services
    application/      # DTOs, use cases
    infrastructure/   # Config, container (DI), in-memory persistence
    presentation/     # HTTP controllers, JSON serialization
```

### Layers

| Layer | Responsibility |
|-------|---------------|
| **Domain** | Equipment, Model, Location, FailureMode, Assessment, Instruction, Function, Indicator entities; repository interfaces; StrategyValidator |
| **Application** | EquipmentDTO/ModelDTO/etc.; ManageEquipment/ManageModels/etc. use cases |
| **Infrastructure** | AppConfig (port 8105); Container (DI wiring); Memory repositories |
| **Presentation** | REST controllers; JSON serialization helpers |

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/asset-performance/equipment` | List equipment |
| POST | `/api/v1/asset-performance/equipment` | Create equipment |
| GET | `/api/v1/asset-performance/equipment/:id` | Get equipment by ID |
| PUT | `/api/v1/asset-performance/equipment/:id` | Update equipment |
| DELETE | `/api/v1/asset-performance/equipment/:id` | Delete equipment |
| GET | `/api/v1/asset-performance/models` | List models |
| POST | `/api/v1/asset-performance/models` | Create model |
| GET | `/api/v1/asset-performance/models/:id` | Get model by ID |
| PUT | `/api/v1/asset-performance/models/:id` | Update model |
| DELETE | `/api/v1/asset-performance/models/:id` | Delete model |
| GET | `/api/v1/asset-performance/locations` | List locations |
| POST | `/api/v1/asset-performance/locations` | Create location |
| GET | `/api/v1/asset-performance/locations/:id` | Get location by ID |
| PUT | `/api/v1/asset-performance/locations/:id` | Update location |
| DELETE | `/api/v1/asset-performance/locations/:id` | Delete location |
| GET | `/api/v1/asset-performance/failure-modes` | List failure modes |
| POST | `/api/v1/asset-performance/failure-modes` | Create failure mode |
| GET | `/api/v1/asset-performance/failure-modes/:id` | Get failure mode by ID |
| PUT | `/api/v1/asset-performance/failure-modes/:id` | Update failure mode |
| DELETE | `/api/v1/asset-performance/failure-modes/:id` | Delete failure mode |
| GET | `/api/v1/asset-performance/assessments` | List assessments |
| POST | `/api/v1/asset-performance/assessments` | Create assessment |
| GET | `/api/v1/asset-performance/assessments/:id` | Get assessment by ID |
| PUT | `/api/v1/asset-performance/assessments/:id` | Update assessment |
| DELETE | `/api/v1/asset-performance/assessments/:id` | Delete assessment |
| GET | `/api/v1/asset-performance/instructions` | List instructions |
| POST | `/api/v1/asset-performance/instructions` | Create instruction |
| GET | `/api/v1/asset-performance/instructions/:id` | Get instruction by ID |
| PUT | `/api/v1/asset-performance/instructions/:id` | Update instruction |
| DELETE | `/api/v1/asset-performance/instructions/:id` | Delete instruction |
| GET | `/api/v1/asset-performance/functions` | List functions |
| POST | `/api/v1/asset-performance/functions` | Create function |
| GET | `/api/v1/asset-performance/functions/:id` | Get function by ID |
| PUT | `/api/v1/asset-performance/functions/:id` | Update function |
| DELETE | `/api/v1/asset-performance/functions/:id` | Delete function |
| GET | `/api/v1/asset-performance/indicators` | List indicators |
| POST | `/api/v1/asset-performance/indicators` | Create indicator |
| GET | `/api/v1/asset-performance/indicators/:id` | Get indicator by ID |
| DELETE | `/api/v1/asset-performance/indicators/:id` | Delete indicator |
| POST | `/api/v1/asset-performance/demo/seed` | Seed full demo dataset |
| GET | `/health` | Health check |

## Configuration

| Environment Variable | Default | Description |
|---------------------|---------|-------------|
| `ASSET_PERFORMANCE_HOST` | `0.0.0.0` | Server bind address |
| `ASSET_PERFORMANCE_PORT` | `8105` | Server port |
| `ASSET_PERFORMANCE_SEED_ON_START` | `false` | Seed demo data when service starts |

## Demo Seed and Curl Flows

Use one API call to seed the full demo dataset:

```bash
curl -X POST http://localhost:8105/api/v1/asset-performance/demo/seed \
  -H "X-Tenant-Id: demo-tenant" \
  -H "Content-Type: application/json"
```

Run end-to-end curl flows that exercise every endpoint:

```bash
./examples/curl-demo.sh
```

Optional variables:

```bash
BASE_URL=http://localhost:8105 TENANT_ID=demo-tenant ./examples/curl-demo.sh
```

## Build and Run

```bash
# Build
dub build

# Run
dub run

# Test
dub test
```

## Docker

```bash
# Build image
docker build -t uim-platform/asset-performance:latest .

# Run container
docker run -p 8105:8105 uim-platform/asset-performance:latest
```

## Podman

```bash
# Build image
podman build -t uim-platform/asset-performance:latest -f Containerfile .

# Run container
podman run -p 8105:8105 uim-platform/asset-performance:latest
```

## Kubernetes

```bash
kubectl apply -k k8s
```

## License

Apache 2.0 - see LICENSE.txt
