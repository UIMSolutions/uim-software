# Extended Warehouse Management Service - UML

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Package Overview

```text
uim.platform.ewm
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
│   ├── integrations.sap_ewm
│   └── persistence.repositories
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
        +warehouseId
        +binCode
    }

    class WarehouseTask {
        +id
        +tenantId
        +warehouseId
        +status
    }

    class InboundDelivery {
        +id
        +tenantId
        +warehouseId
        +deliveryNumber
    }

    class OutboundDelivery {
        +id
        +tenantId
        +warehouseId
        +deliveryNumber
    }

    class HandlingUnit {
        +id
        +tenantId
        +warehouseId
        +huNumber
    }

    class ResourceQueue {
        +id
        +tenantId
        +warehouseId
        +queueName
    }

    class StockItem {
        +id
        +tenantId
        +warehouseId
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
        SG[SAP EWM Stub Gateways]
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
