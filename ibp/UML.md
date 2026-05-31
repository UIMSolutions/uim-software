# Integrated Business Planning Service - UML

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Package Overview

```text
uim.platform.ibp
├── domain
│   ├── types
│   ├── entities
│   │   ├── Warehouse
│   │   ├── StorageBin
│   │   ├── WarehouseTask
│   │   ├── InboundDelivery
│   │   ├── OutboundDelivery
│   │   ├── HandlingUnit
│   │   ├── ResourceQueue
│   │   └── StockItem
│   ├── integration
│   │   ├── WarehouseSyncGateway
│   │   └── StockSyncGateway
│   ├── repositories
│   └── services
│       └── EwmValidator
├── application
│   ├── dto
│   ├── usecases.manage
│   └── usecases.integration
├── infrastructure
│   ├── config
│   ├── container
│   ├── integrations.sap_ibp
│   └── persistence.memory
└── presentation.http
    ├── controllers
    └── json_utils
```

## Domain Class Model

```mermaid
classDiagram
    direction TB

    class Warehouse {
        +id
        +tenantId
        +warehouseNumber
        +status
    }

    class StorageBin {
        +id
        +tenantId
        +demandPlanId
        +binCode
    }

    class WarehouseTask {
        +id
        +tenantId
        +demandPlanId
        +status
    }

    class InboundDelivery {
        +id
        +tenantId
        +demandPlanId
        +deliveryNumber
    }

    class OutboundDelivery {
        +id
        +tenantId
        +demandPlanId
        +deliveryNumber
    }

    class HandlingUnit {
        +id
        +tenantId
        +demandPlanId
        +huNumber
    }

    class ResourceQueue {
        +id
        +tenantId
        +demandPlanId
        +queueName
    }

    class StockItem {
        +id
        +tenantId
        +demandPlanId
        +materialNumber
    }

    Warehouse --> StorageBin : contains
    Warehouse --> WarehouseTask : executes
    Warehouse --> InboundDelivery : receives
    Warehouse --> OutboundDelivery : ships
    Warehouse --> HandlingUnit : packs
    Warehouse --> ResourceQueue : allocates
    Warehouse --> StockItem : tracks
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
        VL[EwmValidator]
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
