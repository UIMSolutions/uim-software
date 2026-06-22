# NAFv4 - UIM APM Service

This document maps the Application Portfolio Assessment service to selected NAFv4 viewpoints.

## C1 - Capability Taxonomy

```text
Enterprise Architecture Governance
└── Application Portfolio Assessment
    ├── Application Inventory Transparency
    ├── Data Governance and Ownership Tracking
    ├── Fit and Value Assessment
    │   ├── Functional Fit
    │   ├── Technical Fit
    │   ├── Business Value
    │   └── Data Quality
    ├── Portfolio Recommendation Support
    │   ├── Invest
    │   ├── Tolerate
    │   ├── Migrate
    │   └── Eliminate
    └── KPI-based Portfolio Monitoring
```

## C2 - Enterprise Vision

The service establishes a single API-driven source for application portfolio assessments. It supports the initial governance cycle described in SAP LeanIX APM guidance:

- Consolidate data from distributed sources into a unified inventory.
- Assess applications through lightweight but consistent fit/value criteria.
- Expose transparent metrics for architecture stakeholders.
- Enable informed rationalization and modernization decisions.

## C4 - Standards Profile

| Standard | Usage |
|----------|-------|
| REST over HTTP/1.1 | Service interface |
| JSON | Payload format |
| D / vibe.d | Runtime implementation |
| 12-Factor | Environment-based configuration |
| NAFv4 | Architecture documentation framing |
| Kubernetes | Deployment target |

## C7 - Service Specification

| Service | Endpoint Base | Purpose |
|---------|---------------|---------|
| APM Inventory | `/api/v1/apm/applications` | Manage application fact base |
| APM Assessment | `/api/v1/apm/assessments` | Record and maintain assessments |
| APM Analysis | `/api/v1/apm/portfolio` | Provide summary and matrix analytics |
| Health | `/api/v1/health` | Liveness/readiness |

## C8 - Motivation

| Driver | Motivation |
|--------|------------|
| Transparency | Understand what applications exist and where they are used |
| Governance | Track ownership and assessment cadence |
| Rationalization | Identify redundancy and modernization candidates |
| Cost/Risk Awareness | Balance business criticality against fit and quality signals |
| Stakeholder Alignment | Share concise, actionable portfolio insights |

## OV-2 / Logical Node View

```text
+----------------------+          +------------------------+
| API Clients          |  HTTP    | APM Service            |
| - Architects         +--------->+ - Presentation Layer   |
| - Domain Owners      |          | - Application Layer    |
| - Governance Team    |          | - Domain Layer         |
+----------------------+          | - Memory Adapters      |
                                  +-----------+------------+
                                              |
                                              v
                                  +------------------------+
                                  | In-Memory Repositories |
                                  +------------------------+
```

## SV-1 / Deployment View

```text
+------------------------------------------------------+
| Kubernetes Namespace: uim-platform                   |
|                                                      |
|  Deployment: apm                                     |
|   - image: uim-platform/apm:latest                  |
|   - container port: 8140                             |
|   - env: APM_HOST, APM_PORT (ConfigMap)              |
|                                                      |
|  Service: apm (ClusterIP)                            |
|   - port 8140 -> targetPort 8140                     |
+------------------------------------------------------+
```

## Data Quality and Assessment Notes

The service includes a built-in weighted score model:

- Functional fit: 35%
- Technical fit: 35%
- Business value: 20%
- Data quality: 10%

Recommendations are policy-driven and can be replaced by another domain service implementation without changing controllers or repository interfaces.
