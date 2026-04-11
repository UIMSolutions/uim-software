# SAP S/4HANA Enterprise Asset Management (EAM) Service

A microservice implementing SAP S/4HANA Enterprise Asset Management features using **D language (dlang)** and **vibe.d**, following a combination of **clean architecture** and **hexagonal architecture** principles.

## Overview

This service provides comprehensive asset lifecycle management capabilities inspired by SAP S/4HANA Plant Maintenance / Enterprise Asset Management, including equipment management, functional location hierarchies, work order processing, maintenance notifications, preventive maintenance planning, work center management, bills of material (BOMs), and maintenance scheduling items.

## Features

- **Equipment Management** — Create, track, and manage physical assets (machines, vehicles, tools, instruments) throughout their lifecycle
- **Functional Locations** — Hierarchical location structures (plant → building → floor → room → area) for organizing where equipment is installed
- **Maintenance Orders (Work Orders)** — Plan, schedule, and execute corrective, preventive, predictive, and emergency maintenance activities
- **Maintenance Notifications** — Report malfunctions, breakdowns, and maintenance requests with priority-based processing
- **Maintenance Plans** — Define time-based, performance-based, and condition-based preventive maintenance schedules
- **Work Centers** — Manage maintenance workshops, crews, and organizational units that perform work
- **Material BOMs (Bills of Material)** — Track spare parts, components, and materials required for equipment maintenance
- **Maintenance Items** — Link equipment and task lists to maintenance plans for scheduled execution

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   Presentation Layer                     │
│              (HTTP Controllers, JSON Utils)               │
├─────────────────────────────────────────────────────────┤
│                   Application Layer                      │
│                (Use Cases, DTOs)                          │
├─────────────────────────────────────────────────────────┤
│                    Domain Layer                           │
│         (Entities, Repository Interfaces, Services)       │
├─────────────────────────────────────────────────────────┤
│                 Infrastructure Layer                      │
│       (Memory Repositories, Config, DI Container)         │
└─────────────────────────────────────────────────────────┘
```

### Layers

| Layer | Responsibility |
|-------|---------------|
| **Domain** | Core business entities, repository interfaces, validation services |
| **Application** | Use cases orchestrating domain logic, DTOs for data transfer |
| **Infrastructure** | In-memory persistence, configuration, dependency injection container |
| **Presentation** | HTTP controllers (REST API), JSON serialization |

## API Endpoints

### Equipment
| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/eam/equipment` | List all equipment |
| POST | `/api/v1/eam/equipment` | Create equipment |
| GET | `/api/v1/eam/equipment/:id` | Get equipment by ID |
| PUT | `/api/v1/eam/equipment/:id` | Update equipment |
| DELETE | `/api/v1/eam/equipment/:id` | Delete equipment |

### Functional Locations
| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/eam/functional-locations` | List all functional locations |
| POST | `/api/v1/eam/functional-locations` | Create functional location |
| GET | `/api/v1/eam/functional-locations/:id` | Get functional location by ID |
| PUT | `/api/v1/eam/functional-locations/:id` | Update functional location |
| DELETE | `/api/v1/eam/functional-locations/:id` | Delete functional location |

### Maintenance Orders
| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/eam/maintenance-orders` | List all maintenance orders |
| POST | `/api/v1/eam/maintenance-orders` | Create maintenance order |
| GET | `/api/v1/eam/maintenance-orders/:id` | Get maintenance order by ID |
| PUT | `/api/v1/eam/maintenance-orders/:id` | Update maintenance order |
| DELETE | `/api/v1/eam/maintenance-orders/:id` | Delete maintenance order |

### Maintenance Notifications
| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/eam/maintenance-notifications` | List all notifications |
| POST | `/api/v1/eam/maintenance-notifications` | Create notification |
| GET | `/api/v1/eam/maintenance-notifications/:id` | Get notification by ID |
| PUT | `/api/v1/eam/maintenance-notifications/:id` | Update notification |
| DELETE | `/api/v1/eam/maintenance-notifications/:id` | Delete notification |

### Maintenance Plans
| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/eam/maintenance-plans` | List all maintenance plans |
| POST | `/api/v1/eam/maintenance-plans` | Create maintenance plan |
| GET | `/api/v1/eam/maintenance-plans/:id` | Get maintenance plan by ID |
| PUT | `/api/v1/eam/maintenance-plans/:id` | Update maintenance plan |
| DELETE | `/api/v1/eam/maintenance-plans/:id` | Delete maintenance plan |

### Work Centers
| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/eam/work-centers` | List all work centers |
| POST | `/api/v1/eam/work-centers` | Create work center |
| GET | `/api/v1/eam/work-centers/:id` | Get work center by ID |
| PUT | `/api/v1/eam/work-centers/:id` | Update work center |
| DELETE | `/api/v1/eam/work-centers/:id` | Delete work center |

### Material BOMs
| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/eam/material-boms` | List all material BOMs |
| POST | `/api/v1/eam/material-boms` | Create material BOM |
| GET | `/api/v1/eam/material-boms/:id` | Get material BOM by ID |
| PUT | `/api/v1/eam/material-boms/:id` | Update material BOM |
| DELETE | `/api/v1/eam/material-boms/:id` | Delete material BOM |

### Maintenance Items
| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/eam/maintenance-items` | List all maintenance items |
| POST | `/api/v1/eam/maintenance-items` | Create maintenance item |
| GET | `/api/v1/eam/maintenance-items/:id` | Get maintenance item by ID |
| PUT | `/api/v1/eam/maintenance-items/:id` | Update maintenance item |
| DELETE | `/api/v1/eam/maintenance-items/:id` | Delete maintenance item |

### Health
| Method | Path | Description |
|--------|------|-------------|
| GET | `/health` | Health check |

## Configuration

| Environment Variable | Default | Description |
|---------------------|---------|-------------|
| `EAM_HOST` | `0.0.0.0` | Server bind address |
| `EAM_PORT` | `8120` | Server listen port |

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
docker build -t uim-platform/eam:latest .
docker run -p 8120:8120 uim-platform/eam:latest
```

## Kubernetes

```bash
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

## License

Apache 2.0 - See [LICENSE](../LICENSE) for details.
