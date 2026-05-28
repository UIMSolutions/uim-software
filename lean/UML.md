# UML — UIM LEAN Platform Service

## Package Structure

```
uim.platform.lean
├── domain
│   ├── types                (FactSheetStatus, enums, ID aliases)
│   ├── entities             (12 fact sheet structs)
│   ├── repositories         (12 repository interfaces — ports)
│   └── services
│       └── lean_validator   (static validation helpers)
├── application
│   ├── dto                  (12 DTOs — pure string fields)
│   └── usecases.manage      (12 ManageXxx use cases)
├── infrastructure
│   ├── config               (AppConfig, loadConfig)
│   ├── persistence.memory   (12 in-memory repository adapters)
│   └── container            (Container struct, buildContainer)
└── presentation
    └── http
        ├── json_utils       (12 entity-to-Json functions)
        └── controllers      (12 SAPController subclasses)
```

## Hexagonal Architecture Diagram

```
┌─────────────────────────────────────────────────────┐
│                    Presentation                      │
│   HTTP Controllers (adapters — driving side)         │
│   ObjectiveController  LeanPlatformController  ...   │
└───────────────────────┬─────────────────────────────┘
                        │ calls
┌───────────────────────▼─────────────────────────────┐
│                    Application                       │
│   ManageObjectivesUseCase  ManagePlatformsUseCase    │
│   ...                                                │
│   (uses Repository interfaces = ports)               │
└───────────────────────┬─────────────────────────────┘
                        │ depends on interfaces
┌───────────────────────▼─────────────────────────────┐
│                    Domain                            │
│   Entities  ·  Repository Interfaces  ·  Validator   │
└─────────────────────────────────────────────────────┘
                        ▲
┌───────────────────────┴─────────────────────────────┐
│                   Infrastructure                     │
│   MemoryObjectiveRepository  MemoryPlatformRepo ...  │
│   (adapters — driven side)                           │
└─────────────────────────────────────────────────────┘
```

## Entity Diagram (key relationships)

```
Initiative ──────► Objective (objectiveIds[])
Initiative ──────► LeanApplication (affectedApplicationIds[])
LeanPlatform ────► BusinessCapability (businessCapabilityIds[])
LeanPlatform ────► LeanApplication (applicationIds[])
LeanPlatform ────► ITComponent (itComponentIds[])
Organization ────► Organization (parentOrgId, tree)
BusinessCapability ► BusinessCapability (parentCapabilityId, tree)
BusinessCapability ► Organization (owningOrgId)
BusinessContext  ─► BusinessCapability (capabilityId)
DataObject ──────► LeanApplication (owningApplicationId)
AppInterface ────► LeanApplication (sourceApplicationId, targetApplicationId)
AppInterface ────► DataObject (dataObjectId)
LeanApplication ─► Organization (owningOrgId)
LeanApplication ─► BusinessCapability (businessCapabilityIds[])
LeanApplication ─► ITComponent (itComponentIds[])
ITComponent ─────► TechCategory (techCategoryId)
ITComponent ─────► Provider (providerId)
TechCategory ────► TechCategory (parentCategoryId, tree)
```

## Fact Sheet Lifecycle State Machine

```
         ┌──────────────────┐
         │      draft       │
         └────────┬─────────┘
                  │ activate
         ┌────────▼─────────┐
         │      active      │◄──────────────┐
         └────────┬─────────┘               │
                  │ plan retirement          │ reactivate
         ┌────────▼─────────┐               │
         │   endOfLife      ├───────────────┘
         └────────┬─────────┘
                  │ archive
         ┌────────▼─────────┐
         │     archived     │
         └──────────────────┘
```

## Use Case Sequence: Create Application

```
Client                 AppInterfaceController    ManageLeanApplicationsUseCase   MemoryLeanApplicationRepo
  │                           │                            │                               │
  │── POST /api/v1/lean/applications ──────────────────►  │                               │
  │                           │── create(dto) ───────────►│                               │
  │                           │                            │── validate(dto) ─────────────►│
  │                           │                            │   generate id                 │
  │                           │                            │── save(entity) ──────────────►│
  │                           │                            │◄─ ok ─────────────────────────│
  │                           │◄─ CommandResult(success) ──│                               │
  │◄── 201 {id, message} ─────│                            │                               │
```

## Controller Class Hierarchy

```
SAPController (uim.platform.service)
├── ObjectiveController
├── LeanPlatformController
├── InitiativeController
├── OrganizationController
├── BusinessCapabilityController
├── BusinessContextController
├── DataObjectController
├── LeanApplicationController
├── AppInterfaceController
├── ProviderController
├── ITComponentController
└── TechCategoryController

HealthController (uim.platform.service)
```
