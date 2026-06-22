# NAFv4 - UIM TEAM Service

This file documents the Teamcenter-like PLM service in selected NAFv4 views.

## C1 - Capability Taxonomy

```text
Product Lifecycle Management
├── Product Data Management
│   ├── Part Master and Revision
│   └── Lifecycle State Tracking
├── Product Structure Management
│   ├── Bill of Materials Maintenance
│   └── Structure Revision Control
├── Engineering Document Management
│   ├── CAD and Specification Management
│   └── Part/Change Traceability
└── Engineering Change Management
    ├── Change Lifecycle Governance
    ├── Approval Support
    └── Impact Assessment
```

## C2 - Enterprise Vision

The service provides an API-driven PLM core that supports structured engineering collaboration and lifecycle governance. It is designed to enable data transparency across product, structure, document, and change domains and to act as an integration-ready component for ERP and external engineering systems.

## C4 - Standards

| Standard | Usage |
|----------|-------|
| REST/HTTP | Service APIs |
| JSON | Data exchange |
| D + vibe.d | Service runtime |
| OCI containers | Packaging |
| Kubernetes | Orchestration |
| NAFv4 | Architecture documentation structure |

## C7 - Service View

| Service | Endpoint Base | Responsibility |
|---------|---------------|----------------|
| Part Management | `/api/v1/team/parts` | Manage part masters and lifecycle |
| BOM Management | `/api/v1/team/boms` | Manage product structures |
| Document Management | `/api/v1/team/documents` | Manage engineering documents |
| Change Management | `/api/v1/team/changes` | Manage engineering change requests |
| PLM Analysis | `/api/v1/team/plm` | Summaries and impact analytics |

## C8 - Motivation

| Driver | Motivation |
|--------|------------|
| Traceability | Link parts, documents, and changes in one model |
| Governance | Enforce change-state transitions and accountability |
| Impact Visibility | Quantify change impact using severity and scope |
| Integration Readiness | Support external CAD/ERP and PLM synchronization patterns |
| Delivery Speed | Enable API-first automation of PLM workflows |

## OV-2 Logical Nodes

```text
+--------------------------+      HTTP      +---------------------------+
| Engineering Clients      +--------------->+ TEAM Service              |
| - CAD integration agents |                | - Presentation            |
| - PLM portals            |                | - Application             |
| - ERP integration jobs   |                | - Domain                  |
+--------------------------+                | - In-memory adapters      |
                                            +-------------+-------------+
                                                          |
                                                          v
                                            +---------------------------+
                                            | Repository adapters       |
                                            +---------------------------+
```

## SV-1 Deployment

```text
Kubernetes namespace: uim-platform
- Deployment: team
  - image: uim-platform/team:latest
  - container port: 8150
  - env: TEAM_HOST, TEAM_PORT
- Service: team (ClusterIP)
  - port 8150 -> targetPort 8150
```

## Operational Notes

Change impact score formula:

- Severity base weight: low=10, medium=30, high=60, critical=90
- Added scope factors: +5 per affected part, +3 per affected document

This policy is encapsulated in the domain service and can be replaced without changing adapters.
