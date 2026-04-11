# NATO Architecture Framework v4 (NAFv4) Views - EAM Service

## C1 - Capability Taxonomy

```
Enterprise Asset Management (EAM)
├── Asset Lifecycle Management
│   ├── Equipment Registration
│   ├── Equipment Status Tracking
│   ├── Equipment Decommissioning
│   └── Warranty Management
├── Location Hierarchy Management
│   ├── Functional Location Definition
│   ├── Parent-Child Location Relationships
│   ├── Plant Section Organization
│   └── Cost Center Allocation
├── Maintenance Execution
│   ├── Corrective Maintenance Orders
│   ├── Preventive Maintenance Orders
│   ├── Predictive Maintenance Orders
│   ├── Emergency Maintenance Orders
│   └── Overhaul and Inspection Orders
├── Notification Processing
│   ├── Malfunction Reporting
│   ├── Breakdown Notification
│   ├── Maintenance Request Handling
│   └── Activity Reporting
├── Preventive Maintenance Planning
│   ├── Time-Based Scheduling
│   ├── Performance-Based Scheduling
│   ├── Condition-Based Scheduling
│   └── Maintenance Cycle Management
├── Work Center Management
│   ├── Workshop Organization
│   ├── Crew Assignment
│   ├── Capacity Planning
│   └── Cost Tracking
├── Material Management
│   ├── Bill of Material (BOM) Definition
│   ├── Spare Parts Tracking
│   ├── Storage Location Management
│   └── Supplier Management
└── Maintenance Scheduling
    ├── Maintenance Item Definition
    ├── Task List Assignment
    ├── Cycle-Based Scheduling
    └── Work Center Allocation
```

## C2 - Enterprise Vision

| Aspect | Description |
|--------|-------------|
| **Mission** | Maximize asset availability and reliability while minimizing maintenance costs and asset downtime |
| **Vision** | A unified enterprise asset management platform providing end-to-end lifecycle management, intelligent maintenance scheduling, and real-time operational visibility |
| **Strategic Goals** | Increase asset uptime to >99%, reduce unplanned maintenance by 40%, optimize spare parts inventory, enable predictive maintenance |
| **Scope** | All physical assets across plants, buildings, production lines, and mobile equipment |
| **Stakeholders** | Maintenance planners, technicians, plant managers, reliability engineers, procurement, finance |

## L1 - Node Types

| Node Type | Description | Examples |
|-----------|-------------|----------|
| Equipment | Physical assets maintained by the organization | Machines, vehicles, instruments, tools |
| Functional Location | Hierarchical positions where equipment is installed | Plants, buildings, floors, production lines |
| Maintenance Order | Work instructions for maintenance activities | Corrective orders, preventive orders, inspections |
| Notification | Reports of required maintenance or malfunctions | Breakdown reports, maintenance requests |
| Maintenance Plan | Scheduled preventive maintenance programs | Time-based plans, condition-based plans |
| Work Center | Organizational units performing maintenance | Workshops, maintenance crews, laboratories |
| Material BOM | Spare parts and materials for equipment | Component lists, spare part inventories |
| Maintenance Item | Scheduled items linking plans to equipment | Task assignments, cycle definitions |

## L2 - Logical Scenario

| Scenario | Trigger | Flow |
|----------|---------|------|
| Breakdown Maintenance | Equipment malfunction detected | Notification created → Order generated → Work center assigned → Technician dispatched → Repair executed → Order completed |
| Preventive Maintenance | Maintenance plan cycle due | Plan schedules item → Order auto-created → Parts reserved → Work scheduled → Maintenance performed → Plan updated |
| Equipment Installation | New asset acquired | Equipment registered → Assigned to functional location → BOM created → Maintenance plan linked → Monitoring begins |
| Corrective Maintenance | Notification submitted | Notification reviewed → Priority assessed → Order created → Resources allocated → Work performed → Notification closed |
| Predictive Maintenance | Condition threshold reached | Sensor data evaluated → Condition-based plan triggered → Order created → Proactive maintenance performed |

## L4 - Activity

| Activity | Input | Output | Actor |
|----------|-------|--------|-------|
| Register Equipment | Equipment details, location | Equipment record | Asset Manager |
| Define Functional Location | Location hierarchy, cost center | Location structure | Plant Manager |
| Create Maintenance Order | Equipment ID, order type, priority | Work order | Maintenance Planner |
| Submit Notification | Malfunction description, equipment | Notification record | Operator |
| Create Maintenance Plan | Schedule, cycle, equipment list | Maintenance schedule | Reliability Engineer |
| Manage Work Center | Capacity, skills, cost center | Work center record | HR/Plant Manager |
| Define Material BOM | Equipment, spare parts list | BOM record | Materials Manager |
| Schedule Maintenance Item | Plan, equipment, task list | Scheduled maintenance item | Maintenance Planner |

## P1 - Resource Types

| Resource | Type | Purpose |
|----------|------|---------|
| EAM Service | Software | Core application providing REST API |
| vibe.d Runtime | Framework | HTTP server and request processing |
| In-Memory Store | Storage | Data persistence (development/testing) |
| Container Runtime | Infrastructure | Docker/Podman container execution |
| Kubernetes Cluster | Infrastructure | Orchestration and scaling |
| ConfigMap | Configuration | Environment-based settings |

## P2 - Resource Structure

```
EAM Service (Port 8120)
├── Presentation Layer
│   ├── EquipmentController
│   ├── FunctionalLocationController
│   ├── MaintenanceOrderController
│   ├── MaintenanceNotificationController
│   ├── MaintenancePlanController
│   ├── WorkCenterController
│   ├── MaterialBOMController
│   ├── MaintenanceItemController
│   ├── HealthController
│   └── JSON Utils
├── Application Layer
│   ├── ManageEquipmentUseCase
│   ├── ManageFunctionalLocationsUseCase
│   ├── ManageMaintenanceOrdersUseCase
│   ├── ManageMaintenanceNotificationsUseCase
│   ├── ManageMaintenancePlansUseCase
│   ├── ManageWorkCentersUseCase
│   ├── ManageMaterialBOMsUseCase
│   └── ManageMaintenanceItemsUseCase
├── Domain Layer
│   ├── 8 Entity Structs
│   ├── 8 Repository Interfaces
│   └── MaintenanceValidator
└── Infrastructure Layer
    ├── AppConfig
    ├── Container (DI)
    └── 8 Memory Repository Implementations
```

## S1 - Service Taxonomy

| Service | Layer | API |
|---------|-------|-----|
| Equipment Service | Application | CRUD /api/v1/eam/equipment |
| Functional Location Service | Application | CRUD /api/v1/eam/functional-locations |
| Maintenance Order Service | Application | CRUD /api/v1/eam/maintenance-orders |
| Notification Service | Application | CRUD /api/v1/eam/maintenance-notifications |
| Maintenance Plan Service | Application | CRUD /api/v1/eam/maintenance-plans |
| Work Center Service | Application | CRUD /api/v1/eam/work-centers |
| Material BOM Service | Application | CRUD /api/v1/eam/material-boms |
| Maintenance Item Service | Application | CRUD /api/v1/eam/maintenance-items |
| Health Service | Infrastructure | GET /health |

## S4 - Service Functions

| Function | Method | Path | Description |
|----------|--------|------|-------------|
| ListEquipment | GET | /api/v1/eam/equipment | List all equipment with count |
| CreateEquipment | POST | /api/v1/eam/equipment | Register new equipment |
| GetEquipment | GET | /api/v1/eam/equipment/:id | Get equipment details |
| UpdateEquipment | PUT | /api/v1/eam/equipment/:id | Update equipment record |
| DeleteEquipment | DELETE | /api/v1/eam/equipment/:id | Remove equipment |
| ListFunctionalLocations | GET | /api/v1/eam/functional-locations | List all locations |
| CreateFunctionalLocation | POST | /api/v1/eam/functional-locations | Define new location |
| GetFunctionalLocation | GET | /api/v1/eam/functional-locations/:id | Get location details |
| UpdateFunctionalLocation | PUT | /api/v1/eam/functional-locations/:id | Update location |
| DeleteFunctionalLocation | DELETE | /api/v1/eam/functional-locations/:id | Remove location |
| ListMaintenanceOrders | GET | /api/v1/eam/maintenance-orders | List all orders |
| CreateMaintenanceOrder | POST | /api/v1/eam/maintenance-orders | Create work order |
| GetMaintenanceOrder | GET | /api/v1/eam/maintenance-orders/:id | Get order details |
| UpdateMaintenanceOrder | PUT | /api/v1/eam/maintenance-orders/:id | Update order |
| DeleteMaintenanceOrder | DELETE | /api/v1/eam/maintenance-orders/:id | Remove order |
| ListNotifications | GET | /api/v1/eam/maintenance-notifications | List all notifications |
| CreateNotification | POST | /api/v1/eam/maintenance-notifications | Submit notification |
| GetNotification | GET | /api/v1/eam/maintenance-notifications/:id | Get notification |
| UpdateNotification | PUT | /api/v1/eam/maintenance-notifications/:id | Update notification |
| DeleteNotification | DELETE | /api/v1/eam/maintenance-notifications/:id | Remove notification |
| ListMaintenancePlans | GET | /api/v1/eam/maintenance-plans | List all plans |
| CreateMaintenancePlan | POST | /api/v1/eam/maintenance-plans | Create plan |
| GetMaintenancePlan | GET | /api/v1/eam/maintenance-plans/:id | Get plan details |
| UpdateMaintenancePlan | PUT | /api/v1/eam/maintenance-plans/:id | Update plan |
| DeleteMaintenancePlan | DELETE | /api/v1/eam/maintenance-plans/:id | Remove plan |
| ListWorkCenters | GET | /api/v1/eam/work-centers | List all work centers |
| CreateWorkCenter | POST | /api/v1/eam/work-centers | Create work center |
| GetWorkCenter | GET | /api/v1/eam/work-centers/:id | Get work center |
| UpdateWorkCenter | PUT | /api/v1/eam/work-centers/:id | Update work center |
| DeleteWorkCenter | DELETE | /api/v1/eam/work-centers/:id | Remove work center |
| ListMaterialBOMs | GET | /api/v1/eam/material-boms | List all BOMs |
| CreateMaterialBOM | POST | /api/v1/eam/material-boms | Create BOM |
| GetMaterialBOM | GET | /api/v1/eam/material-boms/:id | Get BOM details |
| UpdateMaterialBOM | PUT | /api/v1/eam/material-boms/:id | Update BOM |
| DeleteMaterialBOM | DELETE | /api/v1/eam/material-boms/:id | Remove BOM |
| ListMaintenanceItems | GET | /api/v1/eam/maintenance-items | List all items |
| CreateMaintenanceItem | POST | /api/v1/eam/maintenance-items | Create item |
| GetMaintenanceItem | GET | /api/v1/eam/maintenance-items/:id | Get item details |
| UpdateMaintenanceItem | PUT | /api/v1/eam/maintenance-items/:id | Update item |
| DeleteMaintenanceItem | DELETE | /api/v1/eam/maintenance-items/:id | Remove item |
| HealthCheck | GET | /health | Service health status |
