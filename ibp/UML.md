# Integrated Business Planning Service - UML

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Package Overview

```text
uim.platform.ibp
├── domain
│   ├── types
│   ├── entities
│   │   ├── DemandPlan
│   │   ├── SupplyPlan
│   │   ├── ResponsePlan
│   │   ├── InventoryPlan
│   │   ├── ScenarioSimulation
│   │   ├── SopCycle
│   │   ├── CollaborationWorkspace
│   │   └── PlanningArea
│   ├── integration
│   │   ├── PlanningMasterSyncGateway
│   │   └── ScenarioAnalyticsSyncGateway
│   ├── repositories
│   └── services
│       └── IbpValidator
├── application
│   ├── dto
│   ├── usecases.manage
│   └── usecases.integration
├── infrastructure
│   ├── config
│   ├── container
│   ├── integrations.sap_ibp
│   └── persistence.repositories
└── presentation.http
    ├── controllers
    └── json_utils
```

## Domain Class Model

```mermaid
classDiagram
    direction TB

    class DemandPlan {
        +id
        +tenantId
        +planNumber
        +status
    }

    class SupplyPlan {
        +id
        +tenantId
        +demandPlanId
        +supplyRevision
    }

    class ResponsePlan {
        +id
        +tenantId
        +demandPlanId
        +responseStatus
    }

    class InventoryPlan {
        +id
        +tenantId
        +demandPlanId
        +targetStock
    }

    class ScenarioSimulation {
        +id
        +tenantId
        +demandPlanId
        +scenarioName
    }

    class SopCycle {
        +id
        +tenantId
        +demandPlanId
        +cycleName
    }

    class CollaborationWorkspace {
        +id
        +tenantId
        +demandPlanId
        +workspaceName
    }

    class PlanningArea {
        +id
        +tenantId
        +demandPlanId
        +areaCode
    }

    DemandPlan --> SupplyPlan : balanced by
    DemandPlan --> ResponsePlan : fulfilled by
    DemandPlan --> InventoryPlan : constrained by
    DemandPlan --> ScenarioSimulation : evaluated by
    DemandPlan --> SopCycle : aligned by
    DemandPlan --> CollaborationWorkspace : coordinated in
    DemandPlan --> PlanningArea : modeled in
```

## Hexagonal View

```mermaid
graph LR
    subgraph A[Primary Adapters]
        HC[HTTP Controllers]
    end

    subgraph B[Application Core]
        MU[Manage Use Cases]
        IU[Integration Use Case]
    end

    subgraph C[Domain Core]
        EN[Entities]
        RP[Repository Ports]
        IP[Integration Ports]
        VL[IbpValidator]
    end

    subgraph D[Secondary Adapters]
        MR[Memory Repositories]
        SG[SAP IBP Stub Gateways]
    end

    HC --> MU
    HC --> IU
    MU --> EN
    MU --> RP
    IU --> IP
    MU --> VL
    MR --> RP
    SG --> IP
```
