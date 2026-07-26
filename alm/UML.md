# UML - UIM ALM Service

## Package Diagram

```text
uim.platform.alm
├── domain
│   ├── types
│   ├── entities
│   ├── repositories
│   └── services
├── application
│   ├── dto
│   └── usecases
├── infrastructure
│   ├── config
│   ├── container
│   └── persistence.memory
└── presentation
    └── http
        ├── json_utils
        └── controllers
```

## Hexagonal View

```text
+-----------------------------------------------------+
| Presentation (Driving)                              |
| Controllers: Health, Solutions, Delivery, Quality,  |
|              Operations, Summary                    |
+----------------------------+------------------------+
                             |
                             v
+-----------------------------------------------------+
| Application (Use Cases)                             |
| ManageSolutions, ManageDelivery, ManageQuality,     |
| ManageOperations, AnalyzeAlm                        |
+----------------------------+------------------------+
                             |
                             v
+-----------------------------------------------------+
| Domain                                               |
| Entities + Lifecycle Policy + CRUD Repository Ports |
+----------------------------+------------------------+
                             ^
                             |
+----------------------------+------------------------+
| Infrastructure (Driven)                              |
| In-memory repositories, config, container wiring    |
+-----------------------------------------------------+
```

## Entity Relations

```text
Solution 1 --- * Project
Solution 1 --- * Task
Solution 1 --- * TestPlan
Solution 1 --- * Release
Solution 1 --- * Environment
Solution 1 --- * Alert
Project 1 --- * Task
TestPlan 1 --- * TestCase
TestCase 1 --- * Defect
Release 1 --- * Deployment
Environment 1 --- * Deployment
```

## Lifecycle Sequence

```text
Client
  -> SolutionController.handleCreate
  -> ManageSolutionsUseCase.create
  -> SolutionRepository.save
  -> ALM summary picks up the new solution
  <- HTTP 201
```
