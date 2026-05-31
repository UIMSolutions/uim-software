# Integrated Business Planning Service - NAFv4 Mapping

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Overview

This document maps the IBP microservice to selected NATO Architecture Framework v4 viewpoints.

The mapping is aligned with SAP Integrated Business Planning guidance from SAP Help and translates planning process concerns into a cloud-native service architecture.

## C1 Capability View

### C1.1 Capability Taxonomy

| Capability | Sub-Capability | Service Realization |
|---|---|---|
| Demand Planning | Baseline and consensus demand plans | /api/v1/ibp/demand-plans |
| Supply Planning | Supply balancing and replenishment planning | /api/v1/ibp/supply-plans |
| Response and Supply | Short-term response orchestration | /api/v1/ibp/response-plans |
| Inventory Planning | Target stock and policy planning | /api/v1/ibp/inventory-plans |
| Scenario Modeling | What-if simulation and version comparison | /api/v1/ibp/scenario-simulations |
| S&OP Coordination | Planning cycle alignment and governance | /api/v1/ibp/sop-cycles |
| Collaboration | Cross-functional planning workspace coordination | /api/v1/ibp/collaboration-workspaces |
| Planning Model Governance | Planning area assignment and synchronization | /api/v1/ibp/planning-areas, /api/v1/ibp/integrations/* |

### C1.2 Capability Dependencies

```text
Demand Planning
  -> Supply Planning
  -> Inventory Planning
  -> Scenario Modeling

Supply Planning
  -> Response and Supply
  -> Planning Model Governance

S&OP Coordination
  -> Collaboration
  -> Demand Planning
  -> Supply Planning
```

## C2 Enterprise Vision

### Vision Statement

Provide an IBP-like planning backend that enables synchronized demand, supply, and inventory planning with collaborative decision support and scenario-driven adjustments.

### Goals

| Goal | Description |
|---|---|
| Planning consistency | Keep planning records coherent across demand, supply, and inventory |
| Faster response | Enable quick response planning and scenario evaluation |
| Integration readiness | Expose stable synchronization ports for planning data exchange |
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
| Demand Plan Service | /api/v1/ibp/demand-plans | Demand planning teams |
| Supply Plan Service | /api/v1/ibp/supply-plans | Supply and operations planners |
| Response Plan Service | /api/v1/ibp/response-plans | Response and fulfillment planners |
| Inventory Plan Service | /api/v1/ibp/inventory-plans | Inventory optimization teams |
| Scenario Simulation Service | /api/v1/ibp/scenario-simulations | Decision support and analytics teams |
| S&OP Cycle Service | /api/v1/ibp/sop-cycles | Executive planning and governance groups |
| Collaboration Workspace Service | /api/v1/ibp/collaboration-workspaces | Cross-functional planning roles |
| Planning Area Service | /api/v1/ibp/planning-areas | Master planning and model governance |
| Integration Orchestration Service | /api/v1/ibp/integrations/* | ERP and analytics integration operations |

### C7.2 Service Dependencies

```text
IBP Service
  consumes: tenant-scoped planning payloads
  produces: governed planning records and synchronization events
  exposes: stable service interfaces for IBP-like operations
```

## C8 Motivation View

### Drivers

| Driver | Description |
|---|---|
| Demand-supply alignment | Improve synchronization between forecast and supply decisions |
| Planning agility | Support rapid response through scenario simulation |
| Collaborative decision making | Enable shared planning workflows across business functions |
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
