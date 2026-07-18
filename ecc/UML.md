# Engineering Control Center Service - UML

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Package Overview

```text
uim.platform.ecc
├── domain
│   ├── types
│   ├── entities
│   │   ├── Product
│   │   ├── BillOfMaterial
│   │   ├── ChangeRequest
│   │   ├── Document
│   │   ├── Specification
│   │   ├── Recipe
│   │   ├── Collaboration
│   │   └── ProductStructure
│   ├── integration
│   │   ├── ProductHandoverGateway
│   │   └── SpecificationSyncGateway
│   ├── repositories
│   └── services
│       └── EccValidator
├── application
│   ├── dto
│   ├── usecases.manage
│   └── usecases.integration
├── infrastructure
│   ├── config
│   ├── container
│   ├── integrations.sap_ecc
│   └── persistence.repositories
└── presentation.http
    ├── controllers
    └── json_utils
```

## Domain Class Model

```mermaid
classDiagram
    direction TB

    class Product {
        +id
        +tenantId
        +productNumber
        +lifecycleStatus
    }

    class Document {
        +id
        +tenantId
        +documentNumber
        +documentType
        +status
    }

    class BillOfMaterial {
        +id
        +tenantId
        +productId
        +revision
    }

    class ProductStructure {
        +id
        +tenantId
        +productId
        +parentNodeId
        +childNodeIds
    }

    class ChangeRequest {
        +id
        +tenantId
        +productId
        +title
        +status
    }

    class Specification {
        +id
        +tenantId
        +productId
        +specificationNumber
    }

    class Collaboration {
        +id
        +tenantId
        +productId
        +title
    }

    class Recipe {
        +id
        +tenantId
        +productId
        +recipeNumber
    }

    Product --> BillOfMaterial : structured by
    Product --> ProductStructure : assembled by
    Product --> Document : documented by
    Product --> ChangeRequest : changed by
    Product --> Specification : attributed by
    Product --> Collaboration : reviewed in
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
        VL[EccValidator]
    end

    subgraph D[Secondary Adapters]
        MR[Memory Repositories]
        SG[SAP ECC Stub Gateways]
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
