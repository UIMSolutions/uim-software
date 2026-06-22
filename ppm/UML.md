# Enterprise Portfolio and Project Management Service - UML

## 1. Package Structure

```text
uim.platform.ppm
├── domain
│   ├── types
│   ├── entities
│   │   ├── Portfolio
│   │   ├── Initiative
│   │   ├── Program
│   │   ├── Project
│   │   ├── Demand
│   │   └── ResourceRequest
│   ├── repositories
│   └── services
├── application
│   ├── dto
│   └── usecases.manage
├── infrastructure
│   ├── config
│   ├── container
│   └── persistence.memory
└── presentation.http
```

## 2. Domain Class Diagram

```mermaid
classDiagram
    direction TB

    class Portfolio {
        +PortfolioId id
        +TenantId tenantId
        +string name
        +string status
        +string strategicTheme
        +string owner
        +string planningHorizon
    }

    class Initiative {
        +InitiativeId id
        +TenantId tenantId
        +PortfolioId portfolioId
        +string title
        +string category
        +string priority
        +string status
        +string sponsor
    }

    class Program {
        +ProgramId id
        +TenantId tenantId
        +PortfolioId portfolioId
        +string name
        +string objective
        +string status
        +string manager
    }

    class Project {
        +ProjectId id
        +TenantId tenantId
        +ProgramId programId
        +string name
        +string projectType
        +string status
        +string startDate
        +string endDate
        +string projectManager
    }

    class Demand {
        +DemandId id
        +TenantId tenantId
        +PortfolioId portfolioId
        +string title
        +string source
        +string businessValue
        +string priority
        +string status
    }

    class ResourceRequest {
        +ResourceRequestId id
        +TenantId tenantId
        +ProjectId projectId
        +string role
        +string quantity
        +string startDate
        +string endDate
        +string status
    }

    Portfolio --> Initiative : contains
    Portfolio --> Program : sponsors
    Portfolio --> Demand : receives
    Program --> Project : coordinates
    Project --> ResourceRequest : requests
```

## 3. Hexagonal Diagram

```mermaid
graph TB
    subgraph P[Presentation]
      C1[PortfolioController]
      C2[InitiativeController]
      C3[ProgramController]
      C4[ProjectController]
      C5[DemandController]
      C6[ResourceRequestController]
    end

    subgraph A[Application]
      U1[ManagePortfoliosUseCase]
      U2[ManageInitiativesUseCase]
      U3[ManageProgramsUseCase]
      U4[ManageProjectsUseCase]
      U5[ManageDemandsUseCase]
      U6[ManageResourceRequestsUseCase]
    end

    subgraph D[Domain]
      E1[Entities]
      R1[Repository Ports]
      V1[PpmValidator]
    end

    subgraph I[Infrastructure]
      M1[Memory Repositories]
      W1[Container]
      F1[Config]
    end

    P --> A
    A --> D
    I --> A
```
