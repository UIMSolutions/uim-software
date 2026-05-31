# NAF v4 Views - Project System Service

This document maps the PS service to NATO Architecture Framework v4 viewpoints and uses the SAP S/4HANA Project System (PS) functional description as baseline behavior.

## C1 - Capability Taxonomy

```
Project System Platform
├── Project Definition and Structuring
│   ├── Project type classification (customer, overhead, capital, maintenance)
│   ├── Work breakdown structure creation and hierarchy management
│   └── Network and activity planning
├── Project Planning
│   ├── Schedule planning (planned/actual start and finish dates)
│   ├── Resource and work center assignment
│   └── Milestone definition and tracking
├── Cost and Budget Management
│   ├── Cost planning by WBS element and activity
│   ├── Actual cost posting and monitoring
│   ├── Budget allocation and availability control
│   └── Budget supplements and transfers
├── Project Monitoring and Control
│   ├── Progress monitoring against plan
│   ├── Variance analysis (planned vs. actual costs)
│   ├── Milestone achievement tracking
│   └── Technical completion and close-out
└── Billing and Revenue Management
    ├── Billing milestone management
    ├── Payment milestone tracking
    └── Project-based revenue recognition
```

## C2 - Enterprise Vision

### Vision Statement

Provide a project management service that enables precise planning, monitoring, and control of all project activities — from trade fair organization to major capital investments — aligned to SAP PS principles.

### Strategic Goals

| Goal | Description |
|------|-------------|
| Project Transparency | Expose all structural and commercial project data via APIs |
| Integrated Cost Control | Link WBS elements, activities, and cost postings in a unified model |
| Budget Governance | Enforce budget availability control at WBS level |
| Milestone-Driven Billing | Support billing and payment milestone tracking for customer projects |
| Organizational Alignment | Support company code, controlling area, and profit center assignment |
| Integration Readiness | Align with financial, procurement, and HR application components |

## L1 - Node Types

| Node Type | Description | Role |
|-----------|-------------|------|
| PS API Service | vibe.d microservice | Exposes project, WBS, activity, milestone, cost, and budget APIs |
| Project Engine | Application use case logic | Manages project lifecycle and cost/budget tracking |
| Project Data Node | Project/WBS/Activity domain stores | Holds structural and commercial project data |
| Cost Node | Project cost store | Records planned, actual, and committed costs |
| Budget Node | Project budget store | Controls budget availability per WBS element |
| Kubernetes Cluster | Runtime platform | Deployment, scaling, and health management |

## L2 - Logical Scenario

### Project Execution Scenario

```
1. Project manager creates project definition with type, dates, and budget
2. WBS elements are created to decompose project scope into deliverables
3. Network activities are assigned to WBS elements as work packages
4. Milestones are defined on activities for billing or progress tracking
5. Cost plans are entered against WBS elements and activities
6. Budget is allocated and released at WBS element level
7. Actual costs are posted as work is executed
8. Milestones are marked as reached when deliverables are confirmed
9. Project is technically completed and then closed
```

## L3 - Node Connectivity

| Source Node | Target Node | Protocol | Data |
|-------------|-------------|----------|------|
| Client System | PS API Service | HTTP/JSON | ProjectDTO, WBSElementDTO, NetworkActivityDTO |
| PS API Service | Project Data Node | In-process | Domain entities |
| PS API Service | Cost Node | In-process | ProjectCost records |
| PS API Service | Budget Node | In-process | ProjectBudget records |

## L4 - Logical Activities

| Activity | Input | Process | Output |
|----------|-------|---------|--------|
| Maintain Project | ProjectDTO | Validate -> Save definition | Project record |
| Maintain WBS | WBSElementDTO | Validate -> Save element | WBS element in hierarchy |
| Maintain Activity | NetworkActivityDTO | Validate -> Save activity | Network activity record |
| Record Milestone | MilestoneDTO | Validate -> Save milestone | Milestone record |
| Plan Cost | ProjectCostDTO | Validate -> Save cost plan | Cost planning record |
| Manage Budget | ProjectBudgetDTO | Validate -> Save budget | Budget availability record |
| Complete Milestone | MilestoneDTO (isReached=true) | Update milestone status | Billing/progress trigger |

## Ar3 - System Interface

| Interface | Direction | Description |
|-----------|-----------|-------------|
| `POST /api/v1/ps/projects` | Inbound | Create new project definition |
| `PUT /api/v1/ps/projects/:id` | Inbound | Update project status and dates |
| `POST /api/v1/ps/wbs-elements` | Inbound | Create WBS element in project hierarchy |
| `POST /api/v1/ps/network-activities` | Inbound | Create network activity / work package |
| `POST /api/v1/ps/milestones` | Inbound | Register project milestone |
| `PUT /api/v1/ps/milestones/:id` | Inbound | Mark milestone as reached |
| `POST /api/v1/ps/costs` | Inbound | Post planned or actual project cost |
| `POST /api/v1/ps/budgets` | Inbound | Allocate project budget |
| `GET /health` | Inbound | Liveness and readiness probe |

## S1 - Service Taxonomy

| Service | Tier | Description |
|---------|------|-------------|
| Project Definition Service | Core | CRUD for project header data |
| WBS Management Service | Core | Hierarchical WBS element management |
| Activity Management Service | Core | Network activity / work package management |
| Milestone Service | Core | Milestone definition and achievement tracking |
| Cost Service | Control | Cost planning and actuals recording |
| Budget Service | Control | Budget allocation and availability control |
| Health Service | Platform | Kubernetes liveness and readiness |
