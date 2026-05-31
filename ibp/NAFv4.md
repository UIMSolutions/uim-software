# Integrated Business Planning Service - NAFv4 Mapping

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Overview

This document maps the EWM microservice to selected NATO Architecture Framework v4 viewpoints.

The mapping is aligned with SAP Integrated Business Planning guidance from SAP Help and translates warehouse process concerns into a cloud-native service architecture.

## C1 Capability View

### C1.1 Capability Taxonomy

| Capability | Sub-Capability | Service Realization |
|---|---|---|
| Warehouse Master Control | Warehouse profile and status management | /api/v1/ibp/demand-plans |
| Bin and Layout Governance | Storage bin organization | /api/v1/ibp/supply-plans |
| Task Execution | Warehouse task lifecycle | /api/v1/ibp/response-plans |
| Inbound Processing | Receipt-oriented delivery handling | /api/v1/ibp/inventory-plans |
| Outbound Processing | Shipment-oriented delivery handling | /api/v1/ibp/scenario-simulations |
| Handling Unit Management | Packaging unit lifecycle | /api/v1/ibp/sop-cycles |
| Resource Orchestration | Queue and assignment coordination | /api/v1/ibp/collaboration-workspaces |
| Stock Visibility | Stock item representation and synchronization | /api/v1/ibp/planning-areas, /api/v1/ibp/integrations/* |

### C1.2 Capability Dependencies

```text
Warehouse Master Control
  -> Bin and Layout Governance
  -> Task Execution
  -> Stock Visibility

Inbound Processing
  -> Task Execution
  -> Handling Unit Management

Outbound Processing
  -> Task Execution
  -> Resource Orchestration
  -> Stock Visibility
```

## C2 Enterprise Vision

### Vision Statement

Provide an IBP-like warehouse execution backend that supports controlled inbound/outbound processing, warehouse task orchestration, and synchronized stock visibility for SAP-centric landscapes.

### Goals

| Goal | Description |
|---|---|
| Operational consistency | Keep warehouse entities and stock states coherent |
| Process traceability | Track task and delivery lifecycle transitions |
| Integration readiness | Expose stable synchronization ports |
| Reliable operations | Support health, deployment, and runtime controls |

## C4 Standards View

| Standard | Usage |
|---|---|
| HTTP/REST | Service interaction model |
| JSON | Payload format |
| Kubernetes | Runtime orchestration |
| OCI images | Packaging and deployment |

## C7 Service-Oriented View

### C7.1 Service Catalog

| Service | Endpoint Prefix | Consumers |
|---|---|---|
| Warehouse Service | /api/v1/ibp/demand-plans | Warehouse master data teams |
| Storage Bin Service | /api/v1/ibp/supply-plans | Warehouse design and operations |
| Warehouse Task Service | /api/v1/ibp/response-plans | Operational supervisors and automation flows |
| Inbound Delivery Service | /api/v1/ibp/inventory-plans | Receiving processes |
| Outbound Delivery Service | /api/v1/ibp/scenario-simulations | Shipping processes |
| Handling Unit Service | /api/v1/ibp/sop-cycles | Packaging and staging processes |
| Resource Queue Service | /api/v1/ibp/collaboration-workspaces | Workforce and queue planning |
| Stock Service | /api/v1/ibp/planning-areas | Inventory visibility workflows |
| Integration Orchestration Service | /api/v1/ibp/integrations/* | ERP and warehouse integration operations |

### C7.2 Service Dependencies

```text
IBP Service
  consumes: tenant-scoped warehouse payloads
  produces: governed warehouse records and synchronization events
  exposes: stable service interfaces for IBP-like operations
```

## C8 Motivation View

### Drivers

| Driver | Description |
|---|---|
| Warehouse transparency | Improve visibility of warehouse entities and stock |
| Process efficiency | Streamline inbound/outbound and task execution flows |
| Integration continuity | Keep warehouse data aligned with enterprise systems |
| Maintainability | Isolate domain behavior from adapters and transport concerns |

### Constraints

| Constraint | Impact |
|---|---|
| In-memory persistence adapter | Not durable for production persistence |
| Single-instance profile | Horizontal scaling policies not yet modeled |
| Stub integration adapters | External connectivity is represented as placeholders |

## Ns Logical Node View

```text
Kubernetes Namespace
  IBP Pod
    vibe.d HTTP server
      presentation adapters
      application orchestration
      domain model and ports
      memory persistence adapter
      SAP IBP integration stub adapters

ConfigMap
  IBP_HOST
  IBP_PORT
```

## Pr Physical Resource View

| Resource | Value |
|---|---|
| HTTP Port | 8132/TCP |
| Health Endpoints | /health, /api/v1/health |
| Container Image Style | LDC2-built OCI image |
| Initial Profile | 100m CPU, 64Mi memory request |

## Source Reference

SAP Help Portal:
[https://help.sap.com/docs/SAP_INTEGRATED_BUSINESS_PLANNING?locale=en-US](https://help.sap.com/docs/SAP_INTEGRATED_BUSINESS_PLANNING?locale=en-US)
