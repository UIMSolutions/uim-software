# NAFv4 Views - Digital Manufacturing Service

## C1 - Capability Taxonomy

```text
Digital Manufacturing
├── Production Execution
│   ├── Production Order Lifecycle
│   ├── Operation Dispatch and Sequencing
│   └── Shop Floor Control Rules
├── Resource Orchestration
│   ├── Work Center Capacity Management
│   ├── Equipment and Labor Allocation
│   └── Availability Tracking
├── Quality Management
│   ├── In-process Inspection
│   ├── Result Capture and Disposition
│   └── Nonconformance Handling
├── Work Instruction Management
│   ├── Digital SOP Publication
│   ├── Revision Control
│   └── Operation-linked Guidance
└── Traceability and Genealogy
    ├── Parent-child Assembly Trace
    ├── Component Consumption Mapping
    └── Audit-ready Trace Chains
```

## C2 - Enterprise Vision

| Aspect | Description |
|---|---|
| Mission | Execute production with high throughput, quality, and full traceability |
| Vision | Unified digital orchestration for planning-to-execution and quality feedback loops |
| Strategic goals | Improve OEE, reduce scrap, shorten cycle time, strengthen compliance traceability |
| Stakeholders | Production planners, line supervisors, operators, quality engineers, plant IT |

## L1 - Node Types

| Node Type | Description |
|---|---|
| ProductionOrder | Manufacturing demand execution entity |
| OperationActivity | Sequenced shop floor task linked to routing step |
| WorkCenter | Physical/logical execution area with capacity |
| Resource | Machine, tool, labor, or fixture participating in execution |
| Material | Produced/consumed item master in execution context |
| ShopFloorControl | Dispatch and release rule model |
| WorkInstruction | Operator guidance document linked to operation |
| QualityInspection | In-process or final quality check record |
| Nonconformance | Defect and disposition tracking record |
| GenealogyRecord | Parent-child traceability relation |

## L2 - Logical Scenarios

| Scenario | Trigger | Flow |
|---|---|---|
| Order release to execution | Order approved | Create order -> Generate operations -> Apply dispatch rules -> Start operations |
| Quality gate failure | Inspection reject | Capture result -> Create nonconformance -> Disposition decision -> Rework/scrap |
| Resource disruption | Machine unavailable | Update resource availability -> Re-dispatch operation -> Continue execution |
| Traceability query | Audit request | Resolve genealogy links -> Retrieve parent-child chain -> Provide evidence |

## P2 - Resource Structure

```text
DM Service (Port 8138)
├── Presentation Layer
│   ├── 10 Controllers + Health
│   └── JSON Serialization Utilities
├── Application Layer
│   ├── 10 Manage*UseCase classes
│   └── DTO + CommandResult contracts
├── Domain Layer
│   ├── 10 Manufacturing entities
│   ├── 10 Repository ports
│   └── DMValidator
└── Infrastructure Layer
    ├── AppConfig
    ├── Dependency Container
    └── 10 In-memory repository adapters
```

## S1 - Service Taxonomy

| Service Group | Endpoint Family |
|---|---|
| Production Orchestration | /api/v1/dm/production-orders, /api/v1/dm/operation-activities, /api/v1/dm/shop-floor-controls |
| Resource and Master Data | /api/v1/dm/work-centers, /api/v1/dm/resources, /api/v1/dm/materials |
| Quality and Compliance | /api/v1/dm/quality-inspections, /api/v1/dm/nonconformances |
| Guidance and Traceability | /api/v1/dm/work-instructions, /api/v1/dm/genealogy-records |
| Health | /health, /api/v1/health |
