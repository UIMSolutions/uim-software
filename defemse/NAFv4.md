# Defense & Security Service - NATO Architecture Framework v4 (NAFv4)

<!-- markdownlint-disable MD040 MD060 -->

## Overview

This document maps the Defense & Security service to NATO Architecture Framework version 4 viewpoints. The architecture is tailored to the SAP S/4HANA Defense & Security mission: planning and executing operations and exercises, relocating contingents, triggering downstream processes, and operating even when communications are limited.

## C1 - Capability View

### C1.1 Capability Taxonomy

| Capability | Sub-Capability | Description |
|------------|----------------|-------------|
| Mission Planning | Operational Planning | Define missions, objectives, and execution windows |
| Mission Planning | Exercise Planning | Prepare and manage exercises and training scenarios |
| Force Management | Contingent Management | Track units, detachments, and deployed teams |
| Force Management | Relocation Management | Coordinate movement and redeployment of contingents |
| Readiness Management | Personnel Readiness | Track personnel availability and assignment status |
| Readiness Management | Equipment Readiness | Track equipment availability, mobility, and serviceability |
| Logistics Orchestration | Maintenance Triggering | Create follow-up maintenance tasks from mission events |
| Logistics Orchestration | Supply Triggering | Create procurement and supply actions from mission demand |
| Financial Orchestration | Budget Triggering | Initiate budget or costing follow-up processes |
| Offline Continuity | Deferred Synchronisation | Queue updates and reconcile them after connectivity returns |
| Degraded Operations | Offline Continuity | Support disconnected operations and later synchronisation |

### C1.2 Capability Dependencies

```
Mission Planning
    │
    ├──► Contingent Management
    ├──► Relocation Management
    ├──► Budget Triggering
    └──► Maintenance Triggering

Offline Continuity
    │
    └──► Deferred Synchronisation

Readiness Management
    │
    ├──► Mission Planning
    └──► Degraded Operations

Logistics Orchestration
    │
    └──► Relocation Management

Degraded Operations
    │
    └──► Synchronisation back to core records
```

## C2 - Enterprise Vision

The service provides a mission-aware operational platform for defence, security, and aid organisations. It helps planners and operators manage deployments from the domestic base, coordinate relocations and redeployments, and activate the business processes that follow a change in mission posture.

### Strategic Goals

| Goal | Description |
|------|-------------|
| Operational agility | Shorten the time from mission definition to execution |
| Readiness transparency | Keep personnel, equipment, and logistics status visible |
| Process automation | Trigger purchase orders, maintenance, and budget workflows automatically |
| Disconnected resilience | Keep mission-critical actions available without continuous connectivity |
| Integration readiness | Align with enterprise components such as materials management, maintenance, accounting, and document management |

## C4 - Standards and Protocols

| Standard | Version | Application |
|----------|---------|-------------|
| HTTP/REST | RFC 7231 | Service interface style |
| JSON | RFC 8259 | Payload encoding |
| Kubernetes | v1.29+ | Deployment target |
| OCI Container | 1.0 | Container packaging |
| OpenAPI | 3.x | Future API contract publication |
| SAP integration patterns | N/A | Business system interoperability |

## C7 - Service View

### C7.1 Services Provided

| Service | Endpoint Prefix | Consumer |
|---------|----------------|----------|
| Mission Planning | `/api/v1/defemse/missions` | Planners and commanders |
| Exercise Management | `/api/v1/defemse/exercises` | Training coordinators |
| Contingent Management | `/api/v1/defemse/contingents` | Force managers |
| Readiness Management | `/api/v1/defemse/readiness` | Operations staff |
| Redeployment Orchestration | `/api/v1/defemse/redeployment-orders` | Logistics and transport planners |
| Health Check | `/api/v1/health` | Kubernetes probes and monitoring |

### C7.2 Service Dependencies

```
Defemse Service
    │
    ├── Consumes: mission plans, exercise definitions, readiness updates
    ├── Consumes: organisational structure and location data
    ├── Produces: downstream work for purchasing, maintenance, and budgeting
    └── Produces: offline sync events for later reconciliation
```

## C8 - Motivation View

### C8.1 Drivers

| Driver | Category | Description |
|--------|----------|-------------|
| Mission responsiveness | Operational | Forces and aid organisations need rapid planning and execution |
| Multi-step follow-up | Process | Mission changes must trigger logistics, maintenance, and finance actions |
| Communication limits | Technical | Operations may continue in disconnected or degraded environments |
| Cross-system alignment | Integration | Defence operations depend on enterprise master data and transactional systems |
| Deferred reconciliation | Operational | Offline changes must be queued and replayed safely |

### C8.2 Constraints

| Constraint | Type | Description |
|------------|------|-------------|
| Initial in-memory persistence | Technical | Suitable for development and demo use only |
| Single service instance | Operational | Multi-node coordination is a later extension |
| SAP-aligned vocabulary | Functional | Domain terms should stay close to enterprise planning concepts |
| Tenant isolation | Security | Every transactional change must remain tenant-scoped |

## Ns - Logical Node View

```
┌───────────────────────────────────────────────────────────┐
│                    uim-platform (Kubernetes)              │
│                                                           │
│   ┌───────────────────────────────────────────────────┐   │
│   │               defemse Pod                         │   │
│   │                                                   │   │
│   │   vibe.d HTTP Server                              │   │
│   │   ├── Presentation adapters                       │   │
│   │   ├── Application use cases                       │   │
│   │   ├── Domain model                                │   │
│   │   └── Infrastructure configuration                │   │
│   │                                                   │   │
│   │   Disconnected sync queue / future adapter         │   │
│   └───────────────────────────────────────────────────┘   │
│                                                           │
│   ConfigMap: DEFEMSE_HOST, DEFEMSE_PORT                   │
│   Service: ClusterIP                                      │
└───────────────────────────────────────────────────────────┘
```

## Pr - Physical Resource View

| Resource | Specification | Notes |
|----------|---------------|-------|
| Container Image | LDC2 + minimal runtime | Small deployment image target |
| Port | 8130/TCP | HTTP service port |
| Liveness Probe | GET /api/v1/health | For orchestration health checks |
| Readiness Probe | GET /api/v1/health | For traffic routing decisions |
| CPU Request | 100m | Initial deployment profile |
| Memory Request | 64 Mi | Initial deployment profile |
