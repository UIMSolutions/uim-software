# UML - ITIL 5 Platform Service

This document describes the structural and behavioral design of the ITIL 5 platform service.

## 1. Package Structure (Clean + Hexagonal)

```mermaid
classDiagram
    namespace Domain {
        class ITService
        class ServiceRequest
        class Incident
        class Problem
        class ChangeRecord
        class ConfigurationItem
        class ServiceLevelAgreement
        class KnowledgeArticle
        class ReleaseRecord
        class MonitoringEvent
        class ImprovementItem
        class ITAsset

        class ITServiceRepository
        class ServiceRequestRepository
        class IncidentRepository
        class ProblemRepository
        class ChangeRecordRepository
        class ConfigurationItemRepository
        class SLARepository
        class KnowledgeArticleRepository
        class ReleaseRecordRepository
        class MonitoringEventRepository
        class ImprovementItemRepository
        class ITAssetRepository

        class ITILValidator
    }

    namespace Application {
        class ManageITServicesUseCase
        class ManageServiceRequestsUseCase
        class ManageIncidentsUseCase
        class ManageProblemsUseCase
        class ManageChangeRecordsUseCase
        class ManageConfigurationItemsUseCase
        class ManageSLAsUseCase
        class ManageKnowledgeArticlesUseCase
        class ManageReleaseRecordsUseCase
        class ManageMonitoringEventsUseCase
        class ManageImprovementItemsUseCase
        class ManageITAssetsUseCase
    }

    namespace Infrastructure {
        class MemoryITServiceRepository
        class MemoryServiceRequestRepository
        class MemoryIncidentRepository
        class MemoryProblemRepository
        class MemoryChangeRecordRepository
        class MemoryConfigurationItemRepository
        class MemorySLARepository
        class MemoryKnowledgeArticleRepository
        class MemoryReleaseRecordRepository
        class MemoryMonitoringEventRepository
        class MemoryImprovementItemRepository
        class MemoryITAssetRepository
        class Container
        class AppConfig
    }

    namespace Presentation {
        class ITServiceController
        class ServiceRequestController
        class IncidentController
        class ProblemController
        class ChangeController
        class ConfigurationItemController
        class SLAController
        class KnowledgeController
        class ReleaseController
        class EventController
        class ImprovementController
        class AssetController
    }

    ManageITServicesUseCase --> ITServiceRepository
    ManageServiceRequestsUseCase --> ServiceRequestRepository
    ManageIncidentsUseCase --> IncidentRepository
    ManageProblemsUseCase --> ProblemRepository
    ManageChangeRecordsUseCase --> ChangeRecordRepository
    ManageConfigurationItemsUseCase --> ConfigurationItemRepository
    ManageSLAsUseCase --> SLARepository
    ManageKnowledgeArticlesUseCase --> KnowledgeArticleRepository
    ManageReleaseRecordsUseCase --> ReleaseRecordRepository
    ManageMonitoringEventsUseCase --> MonitoringEventRepository
    ManageImprovementItemsUseCase --> ImprovementItemRepository
    ManageITAssetsUseCase --> ITAssetRepository

    MemoryITServiceRepository ..|> ITServiceRepository
    MemoryServiceRequestRepository ..|> ServiceRequestRepository
    MemoryIncidentRepository ..|> IncidentRepository
    MemoryProblemRepository ..|> ProblemRepository
    MemoryChangeRecordRepository ..|> ChangeRecordRepository
    MemoryConfigurationItemRepository ..|> ConfigurationItemRepository
    MemorySLARepository ..|> SLARepository
    MemoryKnowledgeArticleRepository ..|> KnowledgeArticleRepository
    MemoryReleaseRecordRepository ..|> ReleaseRecordRepository
    MemoryMonitoringEventRepository ..|> MonitoringEventRepository
    MemoryImprovementItemRepository ..|> ImprovementItemRepository
    MemoryITAssetRepository ..|> ITAssetRepository

    ITServiceController --> ManageITServicesUseCase
    ServiceRequestController --> ManageServiceRequestsUseCase
    IncidentController --> ManageIncidentsUseCase
    ProblemController --> ManageProblemsUseCase
    ChangeController --> ManageChangeRecordsUseCase
    ConfigurationItemController --> ManageConfigurationItemsUseCase
    SLAController --> ManageSLAsUseCase
    KnowledgeController --> ManageKnowledgeArticlesUseCase
    ReleaseController --> ManageReleaseRecordsUseCase
    EventController --> ManageMonitoringEventsUseCase
    ImprovementController --> ManageImprovementItemsUseCase
    AssetController --> ManageITAssetsUseCase
```

## 2. Hexagonal View

```mermaid
flowchart LR
    HTTP[HTTP Controllers] --> UC[Application Use Cases]
    UC --> PORTS[Repository Interfaces / Ports]
    PORTS --> MEM[Memory Repositories / Adapters]

    subgraph Core
      DOMAIN[Domain Entities + Validator]
      UC
      PORTS
    end

    DOMAIN --> UC
```

## 3. Key Entity Relationships

```mermaid
erDiagram
    ITService ||--o{ ServiceRequest : receives
    ITService ||--o{ Incident : impactedBy
    ITService ||--o{ Problem : impactedBy
    ITService ||--o{ ServiceLevelAgreement : governedBy
    ITService ||--o{ KnowledgeArticle : documentedBy
    ITService ||--o{ ReleaseRecord : releasedBy
    ITService ||--o{ MonitoringEvent : monitoredBy
    ITService ||--o{ ImprovementItem : improvedBy

    ConfigurationItem ||--o{ Incident : impactedCI
    ConfigurationItem ||--o{ MonitoringEvent : eventSource
    ConfigurationItem ||--o{ ITAsset : representedAs

    Problem ||--o{ Incident : linkedIncident
```

## 4. Sequence Diagram: Incident Lifecycle

```mermaid
sequenceDiagram
    participant Client
    participant IncidentController
    participant ManageIncidentsUseCase
    participant IncidentRepository

    Client->>IncidentController: POST /api/v1/itil/incidents
    IncidentController->>ManageIncidentsUseCase: create(dto)
    ManageIncidentsUseCase->>ManageIncidentsUseCase: ITILValidator.isValidIncident
    ManageIncidentsUseCase->>IncidentRepository: save(incident)
    IncidentRepository-->>ManageIncidentsUseCase: ok
    ManageIncidentsUseCase-->>IncidentController: CommandResult(success)
    IncidentController-->>Client: 201 Created {id}

    Client->>IncidentController: GET /api/v1/itil/incidents/:id
    IncidentController->>ManageIncidentsUseCase: get_(id)
    ManageIncidentsUseCase->>IncidentRepository: findById(id)
    IncidentRepository-->>ManageIncidentsUseCase: Incident*
    ManageIncidentsUseCase-->>IncidentController: Incident*
    IncidentController-->>Client: 200 OK {incident-json}
```

## 5. State Machines

### Incident Status

```mermaid
stateDiagram-v2
    [*] --> open
    open --> inProgress
    inProgress --> pending
    pending --> inProgress
    inProgress --> resolved
    resolved --> closed
    open --> cancelled
    inProgress --> cancelled
    pending --> cancelled
```

### Change Record Status

```mermaid
stateDiagram-v2
    [*] --> draft
    draft --> requested
    requested --> authorized
    authorized --> scheduled
    scheduled --> implemented
    implemented --> reviewComplete
    reviewComplete --> closed
    draft --> cancelled
    requested --> cancelled
    authorized --> cancelled
    scheduled --> cancelled
```

## 6. Deployment Components

```mermaid
flowchart TB
    ConfigMap[itil-config ConfigMap] --> Deployment[itil-deployment]
    Deployment --> Pod1[itil pod replica 1]
    Deployment --> Pod2[itil pod replica 2]
    Service[itil-service ClusterIP:8140] --> Pod1
    Service --> Pod2
```
