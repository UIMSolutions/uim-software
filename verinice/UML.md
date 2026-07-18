# Verinice IT-Grundschutz Service - UML

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Package Overview

```text
uim.platform.verinice
├── domain
│   ├── types
│   ├── entities
│   │   ├── Asset
│   │   ├── Safeguard
│   │   └── Assessment
│   ├── integration
│   │   └── GsCatalogSyncGateway
│   ├── repositories
│   └── services
│       └── VeriniceValidator
├── application
│   ├── dto
│   ├── usecases.manage
│   └── usecases.integration
├── infrastructure
│   ├── config
│   ├── container
│   ├── integrations.verinice_cloud
│   └── persistence.repositories
└── presentation.http
    ├── controllers
    └── json_utils
```

## Domain Class Model

```mermaid
classDiagram
    direction TB

    class Asset {
        +id
        +tenantId
        +name
        +assetType
        +confidentiality
        +integrity
        +availability
    }

    class Safeguard {
        +id
        +tenantId
        +assetId
        +code
        +title
        +implementationStatus
        +maturityLevel
    }

    class Assessment {
        +id
        +tenantId
        +assetId
        +safeguardId
        +status
        +riskLevel
    }

    Asset --> Safeguard : protected by
    Safeguard --> Assessment : evaluated by
    Asset --> Assessment : assessed in
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
        VL[VeriniceValidator]
    end

    subgraph D[Secondary Adapters]
        MR[Memory Repositories]
        SG[GS Catalog Sync Stub]
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
