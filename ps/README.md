# Project System Service (PS)

A microservice implementing a solution similar to SAP S/4HANA Project System (PS), built with D (dlang) and vibe.d using a combination of clean and hexagonal architecture.

Reference description: [SAP S/4HANA On-Premise - Project System (PS)](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/4dd8cb7b1c484b4b93af84d00f60fdb8/1ad4b65334e6b54ce10000000a174cb4.html?locale=en-US)

## SAP PS Alignment

This service mirrors the core PS goals and process patterns from SAP documentation:

- Precise planning of all project activities from trade fair organization to factory construction
- Structural project organization using a Work Breakdown Structure (WBS)
- Process-oriented planning using individual network activities (work packages)
- Monitoring of both technical and commercial aspects of the project
- Integration of cost planning, budget management, and revenue planning
- Support for externally financed (customer) and internally financed (overhead/capital) projects
- Milestone tracking for billing and progress monitoring

## Features

- **Project Definition Management** - Create and track customer, overhead cost, capital investment, and maintenance projects
- **Work Breakdown Structure (WBS)** - Hierarchical decomposition of projects into deliverable-oriented elements
- **Network Activities** - Process-oriented work packages with duration, resource, and cost planning
- **Milestone Tracking** - Key project dates for progress, billing, and payment milestones
- **Cost Planning and Control** - Planned vs. actual cost monitoring by WBS element and activity
- **Budget Management** - Budget allocation, availability control, supplements, and transfers

### Project types supported

- Customer projects (externally financed)
- Overhead cost projects (internally financed)
- Capital investment projects (internally financed)
- Maintenance projects

## Architecture

```
source/
  uim/platform/ps/
    domain/           # Entities, types, repository interfaces, domain validators
    application/      # DTOs and PS-focused use cases
    infrastructure/   # Configuration, DI container, in-memory persistence adapters
    presentation/     # HTTP controllers and JSON serializers
```

### Layers

| Layer | Responsibility |
|-------|---------------|
| **Domain** | `Project`, `WBSElement`, `NetworkActivity`, `Milestone`, `ProjectCost`, `ProjectBudget` and repository ports |
| **Application** | CRUD use cases for all PS entities |
| **Infrastructure** | In-memory adapter implementations, environment-driven config, dependency wiring |
| **Presentation** | REST endpoints with JSON payloads and tenant-aware request handling |

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/ps/projects` | List projects |
| POST | `/api/v1/ps/projects` | Create project |
| GET | `/api/v1/ps/projects/:id` | Get project |
| PUT | `/api/v1/ps/projects/:id` | Update project |
| DELETE | `/api/v1/ps/projects/:id` | Delete project |
| GET | `/api/v1/ps/wbs-elements` | List WBS elements |
| POST | `/api/v1/ps/wbs-elements` | Create WBS element |
| GET | `/api/v1/ps/wbs-elements/:id` | Get WBS element |
| PUT | `/api/v1/ps/wbs-elements/:id` | Update WBS element |
| DELETE | `/api/v1/ps/wbs-elements/:id` | Delete WBS element |
| GET | `/api/v1/ps/network-activities` | List network activities |
| POST | `/api/v1/ps/network-activities` | Create network activity |
| GET | `/api/v1/ps/network-activities/:id` | Get network activity |
| PUT | `/api/v1/ps/network-activities/:id` | Update network activity |
| DELETE | `/api/v1/ps/network-activities/:id` | Delete network activity |
| GET | `/api/v1/ps/milestones` | List milestones |
| POST | `/api/v1/ps/milestones` | Create milestone |
| GET | `/api/v1/ps/milestones/:id` | Get milestone |
| PUT | `/api/v1/ps/milestones/:id` | Update milestone |
| DELETE | `/api/v1/ps/milestones/:id` | Delete milestone |
| GET | `/api/v1/ps/costs` | List project costs |
| POST | `/api/v1/ps/costs` | Create project cost |
| GET | `/api/v1/ps/costs/:id` | Get project cost |
| PUT | `/api/v1/ps/costs/:id` | Update project cost |
| DELETE | `/api/v1/ps/costs/:id` | Delete project cost |
| GET | `/api/v1/ps/budgets` | List project budgets |
| POST | `/api/v1/ps/budgets` | Create project budget |
| GET | `/api/v1/ps/budgets/:id` | Get project budget |
| PUT | `/api/v1/ps/budgets/:id` | Update project budget |
| DELETE | `/api/v1/ps/budgets/:id` | Delete project budget |
| GET | `/health` | Health check |

## Configuration

| Environment Variable | Default | Description |
|---------------------|---------|-------------|
| `PS_HOST` | `0.0.0.0` | HTTP bind address |
| `PS_PORT` | `8121` | HTTP listen port |

## Running

```bash
dub run
```

Or with Docker:

```bash
docker build -t uim-platform/ps .
docker run -p 8121:8121 uim-platform/ps
```

## Kubernetes

```bash
kubectl apply -f k8s/
```
