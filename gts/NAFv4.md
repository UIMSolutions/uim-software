# NAFv4 Views - Global Trade Services

## C1 - Capability Taxonomy

```text
Global Trade Services
├── Trade Compliance Management
│   ├── Sanctioned Party Screening
│   ├── Embargo Control
│   └── License Determination
├── Customs Management
│   ├── Export Declarations
│   ├── Import Declarations
│   └── Customs Procedure Control
├── Product Classification
│   ├── Commodity Code Assignment
│   ├── Export Control Classification
│   └── Origin Data Maintenance
├── Preference Management
│   ├── Agreement Master Data
│   ├── Origin Rule Tracking
│   └── Preference Eligibility
└── Intrastat Reporting
    ├── Dispatch Reporting
    ├── Arrival Reporting
    └── Statistical Value Reporting
```

## C2 - Enterprise Vision

| Aspect | Description |
|---|---|
| Mission | Enable compliant cross-border trade execution and reporting |
| Vision | Unified digital compliance and customs orchestration service for global operations |
| Strategic goals | Reduce compliance incidents, increase declaration automation, improve auditability |
| Stakeholders | Trade compliance officers, customs brokers, legal teams, logistics planners |

## L1 - Node Types

| Node Type | Description |
|---|---|
| BusinessPartner | Trade counterparties participating in import/export flows |
| ProductClassification | Commodity and export-control classification records |
| CustomsDeclaration | Customs submission records for cross-border transactions |
| TradeLicense | Authorization records from governmental bodies |
| PreferenceAgreement | Agreement and origin rule records |
| SanctionedPartyCase | Screening case and decision records |
| EmbargoControlCase | Destination and regulation check records |
| IntrastatDeclaration | EU statistical reporting records |

## L2 - Logical Scenarios

| Scenario | Trigger | Flow |
|---|---|---|
| Export declaration | Export shipment release | Partner check -> Product classification -> License validation -> Declaration submission |
| SPL hit review | Name screening hit | Case creation -> Risk assessment -> Compliance decision -> Release/block |
| Embargo check | Restricted destination detected | Embargo case -> Regulation lookup -> Decision and reason capture |
| Preference eligibility | FTA route selected | Agreement lookup -> Origin rule evaluation -> Preference outcome |
| Intrastat filing | Period close | Aggregate movements -> Validate commodity code -> Submit declaration |

## P2 - Resource Structure

```text
GTS Service (Port 8136)
├── Presentation Layer
│   ├── HealthController
│   ├── BusinessPartnerController
│   ├── ProductClassificationController
│   ├── CustomsDeclarationController
│   ├── TradeLicenseController
│   ├── PreferenceAgreementController
│   ├── SanctionedPartyCaseController
│   ├── EmbargoControlCaseController
│   └── IntrastatDeclarationController
├── Application Layer
│   ├── 8 Manage*UseCase classes
│   └── DTO + CommandResult contracts
├── Domain Layer
│   ├── 8 business objects
│   ├── 8 repository ports
│   └── GTSValidator
└── Infrastructure Layer
    ├── AppConfig
    ├── Container
    └── 8 in-memory repository adapters
```

## S1 - Service Taxonomy

| Service Function Group | Endpoint Family |
|---|---|
| Partner and Master Data | /api/v1/gts/business-partners, /api/v1/gts/product-classifications |
| Customs Execution | /api/v1/gts/customs-declarations |
| Compliance Controls | /api/v1/gts/trade-licenses, /api/v1/gts/sanctioned-party-cases, /api/v1/gts/embargo-control-cases |
| Preference Processing | /api/v1/gts/preference-agreements |
| Statistical Reporting | /api/v1/gts/intrastat-declarations |
| Operational Health | /health, /api/v1/health |
