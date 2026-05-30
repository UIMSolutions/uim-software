# Product Lifecycle Management Service - NATO Architecture Framework v4 (NAFv4)

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Overview

This document maps the Product Lifecycle Management service to NATO Architecture Framework version 4 viewpoints. The service is tailored to manage product data, BOMs, engineering changes, documents, specifications, recipes, collaboration, and product structures in a cloud-native PLM style.

## C1 - Capability View

### C1.1 Capability Taxonomy

| Capability | Sub-Capability | Description |
|------------|----------------|-------------|
| Product Management | Product Registration | Create and maintain product master records |
| Product Management | Lifecycle Control | Track lifecycle phases and release status |
| BOM Management | BOM Creation | Define engineering and manufacturing BOMs |
| BOM Management | BOM Governance | Maintain versions, usage, and plant assignments |
| Change Management | Change Request Tracking | Capture engineering change requests |
| Change Management | Impact Analysis | Track affected BOMs and documents |
| Document Management | Document Registry | Manage technical and lifecycle documents |
| Specification Management | Constraint Definition | Define properties, limits, and standards |
| Recipe Management | Formulation Control | Manage recipes, ingredients, and batch sizing |
| Collaboration Management | Cross-Functional Review | Coordinate review tasks and approvals |
| Product Structure Management | Hierarchy Control | Manage parent-child product structures |

### C1.2 Capability Dependencies

```
Product Management
    │
    ├──► BOM Management
    ├──► Change Management
    ├──► Document Management
    ├──► Specification Management
    ├──► Recipe Management
    └──► Product Structure Management

Change Management
    │
    ├──► Document Management
    └──► BOM Management

Collaboration Management
    │
    └──► Change Management
```

## C2 - Enterprise Vision

The service provides a unified product lifecycle platform for designing, controlling, and releasing products across engineering and manufacturing domains. It helps product teams maintain consistent product definitions, collaborate on changes, and govern structures and documents across the lifecycle.

### Strategic Goals

| Goal | Description |
|------|-------------|
| Product consistency | Ensure product master, BOM, document, and specification data stay aligned |
| Controlled change | Route engineering changes through traceable review and approval flows |
| Lifecycle traceability | Preserve status, revision, and release history across lifecycle objects |
| Cross-functional collaboration | Support design, engineering, and quality collaboration around shared product data |
| Integration readiness | Align with enterprise systems for manufacturing, procurement, and compliance |

## C4 - Standards and Protocols

| Standard | Version | Application |
|----------|---------|-------------|
| HTTP/REST | RFC 7231 | Service interface transport |
| JSON | RFC 8259 | API payload encoding |
| Kubernetes | v1.29+ | Deployment target |
| OCI Container | 1.0 | Container packaging |
| OpenAPI | 3.x | Future API contract publication |

## C7 - Service View

### C7.1 Services Provided

| Service | Endpoint Prefix | Consumer |
|---------|----------------|----------|
| Product Management | `/api/v1/plm/products` | Product engineers |
| BOM Management | `/api/v1/plm/boms` | Manufacturing and engineering |
| Change Management | `/api/v1/plm/change-requests` | Change managers |
| Document Management | `/api/v1/plm/documents` | Technical authors, quality teams |
| Specification Management | `/api/v1/plm/specifications` | Quality and compliance teams |
| Recipe Management | `/api/v1/plm/recipes` | Process engineering teams |
| Collaboration Management | `/api/v1/plm/collaborations` | Cross-functional reviewers |
| Product Structure Management | `/api/v1/plm/product-structures` | Product architects |
| Health Check | `/api/v1/health` | Kubernetes probes and monitoring |

### C7.2 Service Dependencies

```
PLM Service
    │
    ├── Consumes: product master data, specifications, documents, BOM structures
    ├── Produces: lifecycle changes, review tasks, approvals, release metadata
    ├── Produces: downstream manufacturing and planning inputs
    └── Exposes: change-traceable product structures and release-ready records
```

## C8 - Motivation View

### C8.1 Drivers

| Driver | Category | Description |
|--------|----------|-------------|
| Lifecycle traceability | Operational | Products need consistent history across definition, change, and release |
| Engineering governance | Functional | BOMs, documents, and specifications must be controlled |
| Collaboration | Process | Product work spans engineering, manufacturing, quality, and compliance |
| Integration | Technical | PLM must align with downstream ERP and manufacturing systems |

### C8.2 Constraints

| Constraint | Type | Description |
|------------|------|-------------|
| Initial in-memory persistence | Technical | Suitable for development and demo use only |
| Single service instance | Operational | Multi-node coordination is a later extension |
| Tenant isolation | Security | Every transactional change must remain tenant-scoped |
| PLM vocabulary | Functional | Domain terms should remain aligned to product lifecycle concepts |

## Ns - Logical Node View

```
┌───────────────────────────────────────────────────────────┐
│                    uim-platform (Kubernetes)              │
│                                                           │
│   ┌───────────────────────────────────────────────────┐   │
│   │                 plm Pod                           │   │
│   │                                                   │   │
│   │   vibe.d HTTP Server                              │   │
│   │   ├── Presentation adapters                       │   │
│   │   ├── Application use cases                       │   │
│   │   ├── Domain model                                │   │
│   │   └── Infrastructure configuration                │   │
│   └───────────────────────────────────────────────────┘   │
│                                                           │
│   ConfigMap: PLM_HOST, PLM_PORT                           │
│   Service: ClusterIP                                      │
└───────────────────────────────────────────────────────────┘
```

## Pr - Physical Resource View

| Resource | Specification | Notes |
|----------|---------------|-------|
| Container Image | LDC2 + minimal runtime | Small deployment image target |
| Port | 8131/TCP | HTTP service port |
| Liveness Probe | GET /api/v1/health | For orchestration health checks |
| Readiness Probe | GET /api/v1/health | For traffic routing decisions |
| CPU Request | 100m | Initial deployment profile |
| Memory Request | 64 Mi | Initial deployment profile |
