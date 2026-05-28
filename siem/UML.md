# SIEM Service — UML Diagrams

## 1. Package Structure

```
uim.platform.siem
├── domain
│   ├── types                   (enums, ID aliases)
│   ├── entities
│   │   ├── SecurityEvent
│   │   ├── Alert
│   │   ├── Incident
│   │   ├── CorrelationRule
│   │   ├── Asset
│   │   └── ThreatIndicator
│   ├── repositories            (interfaces)
│   │   ├── SecurityEventRepository
│   │   ├── AlertRepository
│   │   ├── IncidentRepository
│   │   ├── CorrelationRuleRepository
│   │   ├── AssetRepository
│   │   └── ThreatIndicatorRepository
│   └── services
│       └── SiemValidator
├── application
│   ├── dto                     (SecurityEventDTO, AlertDTO, ...)
│   └── usecases.manage
│       ├── ManageSecurityEventsUseCase
│       ├── ManageAlertsUseCase
│       ├── ManageIncidentsUseCase
│       ├── ManageCorrelationRulesUseCase
│       ├── ManageAssetsUseCase
│       └── ManageThreatIndicatorsUseCase
├── infrastructure
│   ├── config                  (AppConfig, loadConfig)
│   ├── container               (Container, buildContainer)
│   └── persistence.memory
│       ├── MemorySecurityEventRepository
│       ├── MemoryAlertRepository
│       ├── MemoryIncidentRepository
│       ├── MemoryCorrelationRuleRepository
│       ├── MemoryAssetRepository
│       └── MemoryThreatIndicatorRepository
└── presentation.http
    ├── json_utils
    └── controllers
        ├── SecurityEventController
        ├── AlertController
        ├── IncidentController
        ├── CorrelationRuleController
        ├── AssetController
        └── ThreatIndicatorController
```

---

## 2. Domain Class Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                        DOMAIN LAYER                                  │
│                                                                       │
│  ┌────────────────┐   ┌──────────────┐   ┌─────────────────────┐   │
│  │  SecurityEvent │   │    Alert     │   │      Incident       │   │
│  │─────────────── │   │────────────  │   │─────────────────────│   │
│  │ id             │   │ id           │   │ id                  │   │
│  │ tenantId       │   │ tenantId     │   │ tenantId            │   │
│  │ name           │   │ name         │   │ name                │   │
│  │ source         │   │ severity     │   │ severity            │   │
│  │ severity       │   │ status       │   │ status              │   │
│  │ status         │   │ ruleId       │   │ alertIds            │   │
│  │ sourceIp       │   │ mitreTactic  │   │ leadAnalyst         │   │
│  │ destinationIp  │   │ mitreTech.   │   │ mitreTactics        │   │
│  │ protocol       │   │ assignedTo   │   │ containmentActions  │   │
│  │ timestamp      │   │ resolvedBy   │   │ detectedAt          │   │
│  └────────────────┘   └──────────────┘   └─────────────────────┘   │
│                                                                       │
│  ┌─────────────────────┐  ┌───────────────┐  ┌──────────────────┐  │
│  │  CorrelationRule    │  │    Asset      │  │ ThreatIndicator  │  │
│  │─────────────────────│  │───────────────│  │──────────────────│  │
│  │ id                  │  │ id            │  │ id               │  │
│  │ tenantId            │  │ tenantId      │  │ tenantId         │  │
│  │ ruleType            │  │ assetType     │  │ indicatorType    │  │
│  │ status              │  │ criticality   │  │ confidence       │  │
│  │ ruleExpression      │  │ ipAddress     │  │ value            │  │
│  │ timeWindowSeconds   │  │ hostname      │  │ threatActor      │  │
│  │ threshold           │  │ operatingSystem│  │ malwareFamily    │  │
│  │ mitreTactic         │  │ owner         │  │ campaign         │  │
│  │ mitreTechnique      │  │ department    │  │ tlpLevel         │  │
│  └─────────────────────┘  └───────────────┘  └──────────────────┘  │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 3. Hexagonal Architecture (Ports and Adapters)

```
        ┌──────────────────────────────────────────────────┐
        │                HTTP Client / curl                 │
        └──────────────────────┬───────────────────────────┘
                               │ HTTP Requests
                               ▼
        ┌──────────────────────────────────────────────────┐
        │           DRIVING ADAPTER (vibe.d)               │
        │   SecurityEventController, AlertController,      │
        │   IncidentController, CorrelationRuleController, │
        │   AssetController, ThreatIndicatorController     │
        └──────────────────────┬───────────────────────────┘
                               │ calls
                               ▼
        ┌──────────────────────────────────────────────────┐
        │             APPLICATION LAYER (Ports)            │
        │   ManageSecurityEventsUseCase                    │
        │   ManageAlertsUseCase                            │
        │   ManageIncidentsUseCase                         │
        │   ManageCorrelationRulesUseCase                  │
        │   ManageAssetsUseCase                            │
        │   ManageThreatIndicatorsUseCase                  │
        └────────────────────┬─────────────────────────────┘
                             │ depends on interfaces (ports)
                             ▼
        ┌──────────────────────────────────────────────────┐
        │              DOMAIN LAYER (Core)                 │
        │   Entities + Repository Interfaces               │
        │   SecurityEventRepository (interface)            │
        │   AlertRepository (interface)                    │
        │   IncidentRepository (interface)                 │
        │   CorrelationRuleRepository (interface)          │
        │   AssetRepository (interface)                    │
        │   ThreatIndicatorRepository (interface)          │
        │   SiemValidator (domain service)                 │
        └────────────────────┬─────────────────────────────┘
                             │ implemented by
                             ▼
        ┌──────────────────────────────────────────────────┐
        │          DRIVEN ADAPTER (Infrastructure)         │
        │   MemorySecurityEventRepository                  │
        │   MemoryAlertRepository                          │
        │   MemoryIncidentRepository                       │
        │   MemoryCorrelationRuleRepository                │
        │   MemoryAssetRepository                          │
        │   MemoryThreatIndicatorRepository                │
        └──────────────────────────────────────────────────┘
```

---

## 4. Request / Response Sequence — Ingest Security Event

```
Client          SecurityEventController    ManageSecurityEventsUseCase    MemorySecurityEventRepository
  │                       │                           │                              │
  │  POST /api/v1/siem/   │                           │                              │
  │  security-events      │                           │                              │
  │──────────────────────►│                           │                              │
  │                       │  uc.create(dto)           │                              │
  │                       │──────────────────────────►│                              │
  │                       │                           │  SiemValidator.isValid(e)    │
  │                       │                           │◄─────────────────────────    │
  │                       │                           │  repo.save(event)            │
  │                       │                           │─────────────────────────────►│
  │                       │                           │  CommandResult(true, id)     │
  │                       │◄──────────────────────────│                              │
  │  201 Created {id}     │                           │                              │
  │◄──────────────────────│                           │                              │
```

---

## 5. Incident Lifecycle State Machine

```
         ┌─────────┐
         │  open   │◄──────────────────────────────────┐
         └────┬────┘                                   │
              │                                        │
              ▼                                        │
      ┌───────────────┐                                │
      │ investigating │                                │
      └───────┬───────┘                                │
              │                                        │
              ▼                                        │
      ┌───────────────┐                                │
      │  containment  │                                │
      └───────┬───────┘                                │
              │                                        │
              ▼                                        │
      ┌───────────────┐                                │
      │ eradication   │                                │
      └───────┬───────┘                                │
              │                                        │
              ▼                                        │
      ┌───────────────┐                                │
      │   recovery    │                                │
      └───────┬───────┘                                │
              │                                        │
              ▼                                        │
         ┌────────┐        ┌───────────────────────┐   │
         │ closed │───────►│ postIncidentReview    │───┘
         └────────┘        └───────────────────────┘
```

---

## 6. Correlation Rule Types

```
CorrelationRule
└── ruleType: RuleType
    ├── threshold         — Fire when event count > N within time window
    ├── correlation       — Fire when multiple different event types occur together
    ├── anomaly           — Fire on statistical deviation from baseline
    ├── threatIntelligence— Fire when an IOC matches a ThreatIndicator
    ├── behavioral        — Fire on sequence of actions from a single user/host
    └── sequence          — Fire when events appear in a specific ordered sequence
```
