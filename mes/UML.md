# Manufacturing Execution Service - UML

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Package Overview

```text
uim.platform.mes
├── domain
│   ├── types
│   ├── entities
│   │   ├── ProductionOrder
│   │   ├── Operation
│   │   ├── WorkCenterAssignment
│   │   ├── ShopFloorEvent
│   │   ├── QualityInspection
│   │   ├── BatchRecord
│   │   ├── OperatorCollaboration
│   │   └── ProductionTraceability
│   ├── integration
│   │   ├── OrderSyncGateway
│   │   └── QualitySyncGateway
│   ├── repositories
│   └── services
│       └── MesValidator
├── application
│   ├── dto
│   ├── usecases.manage
│   └── usecases.integration
├── infrastructure
│   ├── config
│   ├── container
│   ├── integrations.sap_mes
│   └── persistence.memory
└── presentation.http
    ├── controllers
    └── json_utils
```

## Domain Class Model

```mermaid
classDiagram
    direction TB

    class ProductionOrder {
        +id
        +tenantId
        +orderNumber
        +status
    }

    class Operation {
        +id
        +tenantId
        +orderId
        +operationCode
    }

    class WorkCenterAssignment {
        +id
        +tenantId
        +orderId
        +workCenter
    }

    class ShopFloorEvent {
        +id
        +tenantId
        +orderId
        +eventType
    }

    class QualityInspection {
        +id
        +tenantId
        +orderId
        +inspectionType
    }

    class BatchRecord {
        +id
        +tenantId
        +orderId
        +batchNumber
    }

    class OperatorCollaboration {
        +id
        +tenantId
        +orderId
        +taskTitle
    }

    class ProductionTraceability {
        +id
        +tenantId
        +orderId
        +traceNode
    }

    ProductionOrder --> Operation : executed by
    ProductionOrder --> WorkCenterAssignment : assigned to
    ProductionOrder --> ShopFloorEvent : observed through
    ProductionOrder --> QualityInspection : verified by
    ProductionOrder --> BatchRecord : recorded in
    ProductionOrder --> OperatorCollaboration : coordinated by
    ProductionOrder --> ProductionTraceability : tracked through
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
        VL[MesValidator]
    end

    subgraph D[Secondary Adapters]
        MR[Memory Repositories]
        SG[SAP MES Stub Gateways]
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
