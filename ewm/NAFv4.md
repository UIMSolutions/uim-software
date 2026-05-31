# Warehouse Management Service - NAFv4 Mapping

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Overview

This document maps the ECC microservice to selected NATO Architecture Framework v4 viewpoints.

The mapping is aligned to the SAP Extended Warehouse Management for SAP S/4HANA documentation areas (installation and upgrade, configuration, security, and application help), and translates those concerns into a cloud-native service architecture.

## C1 Capability View

### C1.1 Capability Taxonomy

| Capability | Sub-Capability | Service Realization |
|---|---|---|
| Engineering Data Control | Material-centric engineering records | /api/v1/ewm/warehouses |
| Document Governance | CAD and engineering document metadata | /api/v1/ewm/inbound-deliveries |
| Structure Governance | BOM and assembly hierarchy | /api/v1/ewm/storage-bins, /api/v1/ewm/stock-items |
| Engineering Change | Change request lifecycle | /api/v1/ewm/warehouse-tasks |
| Attribute and Classification | Document and specification attributes | /api/v1/ewm/outbound-deliveries |
| Collaboration | Engineering workspace coordination | /api/v1/ewm/resource-queues |
| S/4HANA Synchronization | Material and document sync orchestration | /api/v1/ewm/integrations/* |

### C1.2 Capability Dependencies

```text
Engineering Data Control
  -> Document Governance
  -> Structure Governance
  -> Engineering Change

Engineering Change
  -> Collaboration
  -> S/4HANA Synchronization

Structure Governance
  -> S/4HANA Synchronization
```

## C2 Enterprise Vision

### Vision Statement

Provide an EWM-like engineering control service that keeps CAD-facing engineering data and SAP S/4HANA-aligned business objects synchronized, traceable, and governable across product lifecycle activities.

### Goals

| Goal | Description |
|---|---|
| Data consistency | Keep material, document, and structure data aligned |
| Traceable engineering changes | Ensure controlled and auditable change flows |
| Integration readiness | Provide stable integration ports for ERP synchronization |
| Operational reliability | Support health, configuration, and deployment standards |

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
| Material Engineering Service | /api/v1/ewm/warehouses | Engineering and master data teams |
| Document Service | /api/v1/ewm/inbound-deliveries | CAD and document control teams |
| BOM Service | /api/v1/ewm/storage-bins | Product structure governance |
| Assembly Structure Service | /api/v1/ewm/stock-items | Product architects |
| Change Service | /api/v1/ewm/warehouse-tasks | Change control boards |
| Attribute Service | /api/v1/ewm/outbound-deliveries | Metadata and classification teams |
| Workspace Service | /api/v1/ewm/resource-queues | Engineering collaboration roles |
| Integration Orchestration Service | /api/v1/ewm/integrations/* | ERP integration operations |

### C7.2 Service Dependencies

```text
EWM Service
  consumes: tenant-scoped engineering payloads
  produces: governed engineering records and synchronization events
  exposes: stable service interfaces for EWM-like operations
```

## C8 Motivation View

### Drivers

| Driver | Description |
|---|---|
| CAD-ERP alignment | Keep engineering system data synchronized with SAP S/4HANA-relevant objects |
| Controlled engineering operations | Centralize document and structure governance |
| Secure operations | Support security and configuration controls in deployment |
| Maintainability | Isolate domain logic from transport and adapter concerns |

### Constraints

| Constraint | Impact |
|---|---|
| In-memory persistence adapter | Not durable for production persistence |
| Single-instance profile | Horizontal scaling policies not yet modeled |
| Stub integration adapters | External connectivity is represented as placeholders |

## Ns Logical Node View

```text
Kubernetes Namespace
  EWM Pod
    vibe.d HTTP server
      presentation adapters
      application orchestration
      domain model and ports
      memory persistence adapter
      SAP ECC integration stub adapters

ConfigMap
  EWM_HOST
  EWM_PORT
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
[https://help.sap.com/docs/SAP_EXTENDED_WAREHOUSE_MANAGEMENT?locale=en-US](https://help.sap.com/docs/SAP_EXTENDED_WAREHOUSE_MANAGEMENT?locale=en-US)
