# UML - UIM APM Service

## Package Structure

```text
uim.platform.apm
├── domain
│   ├── types
│   ├── entities
│   │   ├── ApplicationPortfolioItem
│   │   └── ApplicationAssessment
│   ├── repositories
│   │   ├── PortfolioItemRepository
│   │   └── AssessmentRepository
│   └── services
│       └── AssessmentPolicy
├── application
│   ├── dto
│   └── usecases.manage
│       ├── ManagePortfolioItemsUseCase
│       ├── ManageAssessmentsUseCase
│       └── AnalyzePortfolioUseCase
├── infrastructure
│   ├── config
│   ├── container
│   └── persistence.memory
│       ├── MemoryPortfolioItemRepository
│       └── MemoryAssessmentRepository
└── presentation
    └── http
        ├── json_utils
        └── controllers
            ├── ApmHealthController
            ├── PortfolioItemsController
            ├── AssessmentsController
            └── PortfolioAnalysisController
```

## Hexagonal Diagram

```text
+-----------------------------------------------------------+
| Presentation (Driving Adapters)                           |
| HTTP Controllers                                           |
+-----------------------------+-----------------------------+
                              |
                              v
+-----------------------------------------------------------+
| Application Layer (Use Cases)                             |
| ManagePortfolioItems / ManageAssessments / AnalyzePortfolio|
+-----------------------------+-----------------------------+
                              |
                              v
+-----------------------------------------------------------+
| Domain Core                                                |
| Entities + Repository Ports + AssessmentPolicy             |
+-----------------------------+-----------------------------+
                              ^
                              |
+-----------------------------+-----------------------------+
| Infrastructure (Driven Adapters)                           |
| In-memory repository implementations                        |
+-----------------------------------------------------------+
```

## Class Relationships

```text
ApplicationPortfolioItem 1 --- * ApplicationAssessment
ApplicationAssessment --> AssessmentPolicy

ManagePortfolioItemsUseCase --> PortfolioItemRepository
ManageAssessmentsUseCase --> AssessmentRepository
ManageAssessmentsUseCase --> PortfolioItemRepository
AnalyzePortfolioUseCase --> PortfolioItemRepository
AnalyzePortfolioUseCase --> AssessmentRepository

PortfolioItemsController --> ManagePortfolioItemsUseCase
AssessmentsController --> ManageAssessmentsUseCase
PortfolioAnalysisController --> AnalyzePortfolioUseCase
```

## Sequence - Create Assessment

```text
Client
  -> AssessmentsController.handleCreate
  -> ManageAssessmentsUseCase.create
  -> PortfolioItemRepository.findById
  -> AssessmentPolicy.computeOverallScore
  -> AssessmentPolicy.recommend
  -> AssessmentRepository.save
  <- CommandResult(success, id)
  <- HTTP 201 { id }
```

## Sequence - Portfolio Summary

```text
Client
  -> PortfolioAnalysisController.handleSummary
  -> AnalyzePortfolioUseCase.summary
  -> PortfolioItemRepository.findByTenant
  -> AssessmentRepository.findByTenant
  -> aggregate KPIs and recommendation counters
  <- PortfolioSummaryDTO
  <- HTTP 200 JSON
```
