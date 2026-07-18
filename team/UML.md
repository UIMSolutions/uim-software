# UML - UIM TEAM Service

## Package Diagram

```text
uim.platform.team
├── domain
│   ├── types
│   ├── entities
│   │   ├── Part
│   │   ├── Bom
│   │   ├── BomLine
│   │   ├── Document
│   │   └── ChangeRequest
│   ├── repositories
│   │   ├── PartRepository
│   │   ├── BomRepository
│   │   ├── DocumentRepository
│   │   └── ChangeRequestRepository
│   └── services
│       └── ChangePolicy
├── application
│   ├── dto
│   └── usecases.manage
│       ├── ManagePartsUseCase
│       ├── ManageBomsUseCase
│       ├── ManageDocumentsUseCase
│       ├── ManageChangesUseCase
│       └── AnalyzePlmUseCase
├── infrastructure
│   ├── config
│   ├── container
│   └── persistence.repositories
└── presentation
    └── http.controllers
```

## Hexagonal View

```text
+-----------------------------------------------------+
| Presentation (Driving)                              |
| Controllers: Parts, BOM, Documents, Changes,        |
|              PLM Analysis, Health                   |
+----------------------------+------------------------+
                             |
                             v
+-----------------------------------------------------+
| Application (Use Cases)                             |
| Manage* + AnalyzePlm                                |
+----------------------------+------------------------+
                             |
                             v
+-----------------------------------------------------+
| Domain                                               |
| Entities + Policies + Repository Ports              |
+----------------------------+------------------------+
                             ^
                             |
+----------------------------+------------------------+
| Infrastructure (Driven)                              |
| Memory repositories, config, container wiring       |
+-----------------------------------------------------+
```

## Entity Relations

```text
Part 1 --- * Bom (parentPartId)
Bom 1 --- * BomLine (childPartId, quantity)
Part 1 --- * Document (relatedPartId)
ChangeRequest * --- * Part (affectedPartIds)
ChangeRequest * --- * Document (affectedDocumentIds)
Document * --- 1 ChangeRequest (relatedChangeId)
```

## Sequence - Submit Engineering Change

```text
Client
  -> ChangesController.handleCreate
  -> ManageChangesUseCase.create
  -> PartRepository.findById (validate affected parts)
  -> DocumentRepository.findById (validate affected docs)
  -> ChangeRequestRepository.save
  <- CommandResult(success, changeId)
  <- HTTP 201
```

## Sequence - Change Impact Analysis

```text
Client
  -> PlmAnalysisController.handleChangeImpact
  -> AnalyzePlmUseCase.changeImpact
  -> ChangeRequestRepository.findByTenant
  -> ChangePolicy.computeImpactScore
  <- ChangeImpactDTO[]
  <- HTTP 200
```
