# Manufacturing Execution Service - NAFv4 Mapping

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Overview

This document maps the MES microservice to selected NATO Architecture Framework v4 viewpoints.

The mapping is aligned with SAP Manufacturing Execution guidance from SAP Help and translates manufacturing execution concerns into a cloud-native service architecture.

## C1 Capability View

### C1.1 Capability Taxonomy

| Capability | Sub-Capability | Service Realization |
|---|---|---|
| Order Execution | Production order release and tracking | /api/v1/mes/production-orders |
| Operation Dispatch | Step and operation orchestration | /api/v1/mes/operations |
| Work Center Coordination | Resource and station assignment | /api/v1/mes/work-center-assignments |
| Shop Floor Monitoring | Real-time manufacturing event capture | /api/v1/mes/shop-floor-events |
| Quality Assurance | In-process and final inspections | /api/v1/mes/quality-inspections |
| Batch History | Batch-level execution records | /api/v1/mes/batch-records |
| Operator Collaboration | Team task and escalation handling | /api/v1/mes/operator-collaborations |
| Traceability | End-to-end production genealogy | /api/v1/mes/production-traceability, /api/v1/mes/integrations/* |

### C1.2 Capability Dependencies

```text
Order Execution
  -> Operation Dispatch
  -> Work Center Coordination
  -> Shop Floor Monitoring

Shop Floor Monitoring
  -> Quality Assurance
  -> Batch History
  -> Traceability

Operator Collaboration
  -> Order Execution
  -> Quality Assurance
```

## C2 Enterprise Vision

### Vision Statement

Provide an MES-like execution backend that connects production orders, shop floor events, quality controls, and traceability records into a reliable operational flow.

### Goals

| Goal | Description |
|---|---|
| Execution consistency | Keep production execution records coherent across lifecycle states |
| Operational visibility | Improve real-time insight into shop floor progress and quality |
| Integration readiness | Expose stable synchronization ports for manufacturing data exchange |
| Reliable operations | Support health, configuration, and deployment standards |

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
| Production Order Service | /api/v1/mes/production-orders | Manufacturing supervisors |
| Operation Service | /api/v1/mes/operations | Line planners and dispatchers |
| Work Center Assignment Service | /api/v1/mes/work-center-assignments | Resource coordinators |
| Shop Floor Event Service | /api/v1/mes/shop-floor-events | Monitoring and telemetry teams |
| Quality Inspection Service | /api/v1/mes/quality-inspections | Quality engineering teams |
| Batch Record Service | /api/v1/mes/batch-records | Compliance and trace teams |
| Operator Collaboration Service | /api/v1/mes/operator-collaborations | Shift leads and operators |
| Production Traceability Service | /api/v1/mes/production-traceability | Audit and traceability functions |
| Integration Orchestration Service | /api/v1/mes/integrations/* | ERP and manufacturing integration operations |

### C7.2 Service Dependencies

```text
MES Service
  consumes: tenant-scoped manufacturing payloads
  produces: governed execution records and synchronization events
  exposes: stable service interfaces for MES-like operations
```

## C8 Motivation View

### Drivers

| Driver | Description |
|---|---|
| Shop-floor digitalization | Capture and control execution events in near real time |
| Quality-by-execution | Tie inspection outcomes directly to execution flow |
| Full traceability | Ensure genealogy and auditability across production lifecycle |
| Maintainability | Isolate domain behavior from transport and adapters |

### Constraints

| Constraint | Impact |
|---|---|
| In-memory persistence adapter | Not durable for production persistence |
| Single-instance profile | Horizontal scaling policies not yet modeled |
| Stub integration adapters | External connectivity is represented as placeholders |

## Ns Logical Node View

```text
Kubernetes Namespace
  MES Pod
    vibe.d HTTP server
      presentation adapters
      application orchestration
      domain model and ports
      memory persistence adapter
      SAP MES integration stub adapters

ConfigMap
  MES_HOST
  MES_PORT
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
[https://help.sap.com/docs/SAP_MANUFACTURING_EXECUTION?locale=en-US](https://help.sap.com/docs/SAP_MANUFACTURING_EXECUTION?locale=en-US)
