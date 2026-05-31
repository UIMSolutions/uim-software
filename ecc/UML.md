# Engineering Control Center Service - UML

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Package Overview

```text
uim.platform.ecc
├── domain
│   ├── types
│   ├── entities
│   ├── integration
│   │   ├── Product
│   │   ├── BillOfMaterial
│   │   ├── ChangeRequest
│   │   ├── Document
│   │   ├── Specification
│   │   ├── Recipe
│   │   ├── Collaboration
│   │   └── ProductStructure
│   ├── repositories
│   └── services
│       └── EccValidator
├── application
│   ├── dto
│   ├── usecases.integration
│   └── usecases.manage
├── infrastructure
│   ├── config
│   ├── container
│   ├── integrations.sap_ecc
│   └── persistence.memory
└── presentation.http
    ├── controllers
    └── json_utils
```

## Domain Model

```mermaid
classDiagram
    direction TB

    class Product {
        +string id
        +string tenantId
        +string name
        +string lifecycleStatus
        +string productType
    }

    class BillOfMaterial {
        +string id
        +string tenantId
        +string productId
        +string revision
        +string usage
    }

    class ChangeRequest {
        +string id
        +string tenantId
        +string productId
        +string title
        +string status
    }

    class Document {
        +string id
        +string tenantId
        +string productId
        +string documentNumber
    }

    class Specification {
        +string id
        +string tenantId
        +string productId
        +string specificationNumber
    }

    class Recipe {
        +string id
        +string tenantId
        +string productId
        +string recipeNumber
    }

    class Collaboration {
        +string id
        +string tenantId
        +string productId
        +string title
        +string assignedTo
    }

    class ProductStructure {
        +string id
        +string tenantId
        +string productId
        +string parentNodeId
        +string childNodeIds
    }

    Product --> BillOfMaterial : has
    Product --> ChangeRequest : changed_by
    Product --> Document : documented_by
    Product --> Specification : constrained_by
    Product --> Recipe : formulated_by
    Product --> Collaboration : reviewed_in
    Product --> ProductStructure : structured_by
    ChangeRequest --> Document : impacts
    ChangeRequest --> BillOfMaterial : impacts
```

## Hexagonal Interaction View

```mermaid
graph LR
    subgraph A[Primary Adapters]
        HC[HTTP Controllers]
    end

    subgraph B[Application Core]
        UC[Manage* Use Cases]
    end

    subgraph C[Domain Core]
        EN[Entities]
        RP[Repository Ports]
        IP[Integration Ports]
        VL[EccValidator]
    end

    subgraph D[Secondary Adapters]
        MR[Memory Repositories]
        SG[SAP ECC Stub Gateways]
    end

    HC --> UC
    UC --> EN
    UC --> RP
    UC --> IP
    UC --> VL
    MR --> RP
    SG --> IP
```

## Deployment Context

```mermaid
graph TB
    Client[Engineering Clients and Integrations] --> API[EPD HTTP API]
    API --> Core[Application and Domain Core]
    Core --> Store[In-memory Adapter]
    API --> Health[Health Endpoint]
```
