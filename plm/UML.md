# Product Lifecycle Management Service - UML Diagrams

<!-- markdownlint-disable MD040 MD060 MD047 -->

## 1. Package Structure

```
uim.platform.plm
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
│   ├── repositories
│   │   ├── ProductRepository
│   │   ├── BillOfMaterialRepository
│   │   ├── ChangeRequestRepository
│   │   ├── DocumentRepository
│   │   ├── SpecificationRepository
│   │   ├── RecipeRepository
│   │   ├── CollaborationRepository
│   │   └── ProductStructureRepository
│   └── services
│       └── PlmValidator
├── application
│   ├── dto
│   └── usecases.manage
│       ├── ManageProductsUseCase
│       ├── ManageBillOfMaterialsUseCase
│       ├── ManageChangeRequestsUseCase
│       ├── ManageDocumentsUseCase
│       ├── ManageSpecificationsUseCase
│       ├── ManageRecipesUseCase
│       ├── ManageCollaborationsUseCase
│       └── ManageProductStructuresUseCase
├── infrastructure
│   ├── config
│   ├── container
│   └── persistence.repositories
└── presentation.http
    ├── json_utils
    └── controllers
```

## 2. Domain Class Diagram

```mermaid
classDiagram
    direction TB

    class Product {
        +ProductId id
        +TenantId tenantId
        +string name
        +string description
        +string productNumber
        +string productType
        +string lifecycleStatus
        +string category
        +string baseUnit
        +string validFrom
        +string validTo
        +UserId createdBy
        +UserId modifiedBy
        +string createdAt
        +string modifiedAt
    }

    class BillOfMaterial {
        +BillOfMaterialId id
        +TenantId tenantId
        +string productId
        +string name
        +string description
        +string bomType
        +string revision
        +string usage
        +string plant
        +string baseQuantity
        +string baseUnit
        +string isActive
        +UserId createdBy
        +UserId modifiedBy
        +string createdAt
        +string modifiedAt
    }

    class ChangeRequest {
        +ChangeRequestId id
        +TenantId tenantId
        +string productId
        +string title
        +string description
        +string priority
        +string status
        +string reason
        +string impact
        +string requestedBy
        +string assignedTo
        +string approvedBy
        +string affectedDocumentIds
        +string affectedBomIds
    }

    class Document {
        +DocumentId id
        +TenantId tenantId
        +string productId
        +string name
        +string description
        +string documentType
        +string status
        +string documentNumber
        +string fileName
        +string mimeType
        +string language
        +string author
        +string approvedBy
    }

    class Specification {
        +SpecificationId id
        +TenantId tenantId
        +string productId
        +string name
        +string description
        +string specificationType
        +string status
        +string specificationNumber
        +string property
        +string targetValue
        +string unit
        +string lowerLimit
        +string upperLimit
        +string testMethod
        +string complianceStandard
    }

    class Recipe {
        +RecipeId id
        +TenantId tenantId
        +string productId
        +string name
        +string description
        +string recipeType
        +string status
        +string recipeNumber
        +string yieldValue
        +string yieldUnit
        +string batchSize
        +string batchUnit
        +string shelfLife
        +string storageConditions
        +string ingredients
        +string instructions
    }

    class Collaboration {
        +CollaborationId id
        +TenantId tenantId
        +string productId
        +string title
        +string description
        +string collaborationType
        +string status
        +string assignedTo
        +string participants
        +string dueDate
        +string resolvedDate
        +string resolution
        +string relatedDocumentId
        +string relatedChangeRequestId
    }

    class ProductStructure {
        +ProductStructureId id
        +TenantId tenantId
        +string productId
        +string name
        +string description
        +string nodeType
        +string parentNodeId
        +string childNodeIds
        +string quantity
        +string mandatory
        +string status
        +string createdBy
        +string modifiedBy
        +string createdAt
        +string modifiedAt
    }

    Product --> BillOfMaterial : governed by
    Product --> ChangeRequest : changed by
    Product --> Document : documented by
    Product --> Specification : constrained by
    Product --> Recipe : formulated by
    Product --> Collaboration : reviewed in
    Product --> ProductStructure : structured by
    ChangeRequest --> Document : affects
    ChangeRequest --> BillOfMaterial : affects
    Collaboration --> Document : references
    Collaboration --> ChangeRequest : resolves
    ProductStructure --> Product : hierarchy root
```

## 3. Hexagonal Architecture

```mermaid
graph TB
    subgraph Presentation ["Presentation Layer"]
        PC[ProductController]
        BC[BillOfMaterialController]
        CRC[ChangeRequestController]
        DC[DocumentController]
        SC[SpecificationController]
        RC[RecipeController]
        CC[CollaborationController]
        PSC[ProductStructureController]
        HC[HealthController]
    end

    subgraph Application ["Application Layer"]
        PU[ManageProductsUseCase]
        BU[ManageBillOfMaterialsUseCase]
        CRU[ManageChangeRequestsUseCase]
        DU[ManageDocumentsUseCase]
        SU[ManageSpecificationsUseCase]
        RU[ManageRecipesUseCase]
        CU[ManageCollaborationsUseCase]
        PSU[ManageProductStructuresUseCase]
    end

    subgraph Domain ["Domain Layer"]
        P[Product]
        B[BillOfMaterial]
        CR[ChangeRequest]
        D[Document]
        S[Specification]
        R[Recipe]
        C[Collaboration]
        PS[ProductStructure]
        V[PlmValidator]
    end

    subgraph Infrastructure ["Infrastructure Layer"]
        CF[AppConfig]
        CN[Container]
        MR[Memory Repositories]
    end

    Presentation --> Application
    Application --> Domain
    Infrastructure --> Application
    Infrastructure --> Domain
```