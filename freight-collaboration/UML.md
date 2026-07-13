# SAP Business Network Freight Collaboration Service - UML

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Package Overview

uim.platform.freight_collaboration
├── domain
│   ├── types
│   ├── entities
│   │   ├── FreightOrder
│   │   ├── Tender
│   │   └── MilestoneUpdate
│   ├── integration
│   │   └── TenderSyncGateway
│   ├── repositories
│   └── services
│       └── FreightCollaborationValidator
├── application
│   ├── dto
│   ├── usecases.manage
│   └── usecases.integration
├── infrastructure
│   ├── config
│   ├── container
│   ├── integrations.sap_bn_fc
│   └── persistence.memory
└── presentation.http
    ├── controllers
    └── json_utils

## Domain Class Model

```mermaid
classDiagram
    direction TB

    class FreightOrder {
        +id
        +tenantId
        +orderNumber
        +shipperId
        +carrierId
        +transportMode
        +status
    }

    class Tender {
        +id
        +tenantId
        +freightOrderId
        +tenderNumber
        +status
        +offeredRate
        +currency
    }

    class MilestoneUpdate {
        +id
        +tenantId
        +freightOrderId
        +milestoneType
        +eventTime
        +location
    }

    FreightOrder --> Tender : offered through
    FreightOrder --> MilestoneUpdate : tracked by
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
        IP[Integration Port]
        VL[Validator]
    end

    subgraph D[Secondary Adapters]
        MR[Memory Repositories]
        SG[Tender Sync Stub]
    end

    HC --> MU
    HC --> IU
    MU --> EN
    MU --> RP
    MU --> VL
    IU --> IP
    MR --> RP
    SG --> IP
```
