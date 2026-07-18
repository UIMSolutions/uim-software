# Manufacturing Integration and Intelligence Service - UML

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Package Overview

```text
uim.platform.mii
├── domain
│   ├── types
│   ├── entities
│   │   ├── ProductionMessage
│   │   ├── WorkCenterEvent
│   │   ├── DataCollection
│   │   ├── KpiObservation
│   │   ├── AlertNotification
│   │   ├── WorkflowInstance
│   │   ├── DashboardWidget
│   │   └── IntegrationEndpoint
│   ├── integration
│   │   ├── ErpMessageSyncGateway
│   │   └── AnalyticsSyncGateway
│   ├── repositories
│   └── services
│       └── MiiValidator
├── application
│   ├── dto
│   ├── usecases.manage
│   └── usecases.integration
├── infrastructure
│   ├── config
│   ├── container
│   ├── integrations.sap_mii
│   └── persistence.repositories
└── presentation.http
    ├── controllers
    └── json_utils
```

## Domain Class Model

```mermaid
classDiagram
    direction TB

    class ProductionMessage {
        +id
        +tenantId
        +messageNumber
        +status
    }

    class WorkCenterEvent {
        +id
        +tenantId
        +messageId
        +eventCode
    }

    class DataCollection {
        +id
        +tenantId
        +messageId
        +collectionType
    }

    class KpiObservation {
        +id
        +tenantId
        +messageId
        +kpiCode
    }

    class AlertNotification {
        +id
        +tenantId
        +messageId
        +severity
    }

    class WorkflowInstance {
        +id
        +tenantId
        +messageId
        +workflowName
    }

    class DashboardWidget {
        +id
        +tenantId
        +messageId
        +widgetName
    }

    class IntegrationEndpoint {
        +id
        +tenantId
        +messageId
        +endpointCode
    }

    ProductionMessage --> WorkCenterEvent : emits
    ProductionMessage --> DataCollection : collects
    ProductionMessage --> KpiObservation : measures
    ProductionMessage --> AlertNotification : notifies
    ProductionMessage --> WorkflowInstance : orchestrates
    ProductionMessage --> DashboardWidget : visualized in
    ProductionMessage --> IntegrationEndpoint : exchanged through
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
        VL[MiiValidator]
    end

    subgraph D[Secondary Adapters]
        MR[Memory Repositories]
        SG[SAP MII Stub Gateways]
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
