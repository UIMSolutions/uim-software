# SAP Business Network Freight Collaboration Service - NAFv4 Mapping

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Overview

This document maps the Freight Collaboration service to selected NATO Architecture Framework v4 viewpoints.

Reference:

- [https://help.sap.com/docs/business-network-freight-collaboration?locale=en-US](https://help.sap.com/docs/business-network-freight-collaboration?locale=en-US)

## C1 Capability View

### C1.1 Capability Taxonomy

| Capability | Sub-Capability | Service Realization |
|---|---|---|
| Freight Order Collaboration | Joint planning and order status | /api/v1/freight-collaboration/freight-orders |
| Tender Collaboration | Offer, response, award lifecycle | /api/v1/freight-collaboration/tenders |
| Shipment Visibility | Milestone event updates | /api/v1/freight-collaboration/milestones |
| Network Synchronization | External tender sync | /api/v1/freight-collaboration/integrations/* |

### C1.2 Capability Dependencies

Freight Order Collaboration
  -> Tender Collaboration
  -> Shipment Visibility

Tender Collaboration
  -> Network Synchronization

## C2 Enterprise Vision

### Vision Statement

Provide a freight collaboration backend that supports synchronized shipper and carrier interactions for tenders and transport visibility with clear integration boundaries.

### Goals

| Goal | Description |
|---|---|
| Collaboration fidelity | Keep shared freight order and tender states coherent |
| Operational visibility | Surface timely milestone updates |
| Integration readiness | Enable controlled synchronization to external business networks |
| Maintainability | Isolate domain logic from transport and persistence adapters |

## C4 Standards View

| Standard | Usage |
|---|---|
| HTTP/REST | Service interface |
| JSON | Payload format |
| Kubernetes/OCI | Container deployment model |

## C7 Service-Oriented View

### C7.1 Service Catalog

| Service | Endpoint Prefix | Consumers |
|---|---|---|
| Freight Order Service | /api/v1/freight-collaboration/freight-orders | Logistics planners |
| Tender Service | /api/v1/freight-collaboration/tenders | Carriers and dispatch teams |
| Milestone Service | /api/v1/freight-collaboration/milestones | Tracking and operations teams |
| Integration Orchestration Service | /api/v1/freight-collaboration/integrations/* | External network integration workflows |

### C7.2 Service Dependencies

Freight Collaboration Service
  consumes: tenant-scoped logistics payloads
  produces: validated freight order, tender, and milestone records
  exposes: tender synchronization trigger

## C8 Motivation View

### Drivers

| Driver | Description |
|---|---|
| Partner collaboration | Improve shipper-carrier coordination |
| Transport transparency | Improve event-driven shipment visibility |
| Integration continuity | Keep tender state aligned with external networks |
| Architectural quality | Preserve clean separation of core and adapters |

### Constraints

| Constraint | Impact |
|---|---|
| In-memory persistence | Not durable for production persistence |
| Stub outbound adapter | External API connectivity not yet implemented |
| Single-service profile | Advanced orchestration not modeled |

## Ns Logical Node View

Kubernetes Namespace
  Freight Collaboration Pod
    vibe.d HTTP server
      presentation adapters
      application use cases
      domain model and ports
      memory persistence adapters
      tender sync stub adapter

ConfigMap
  FREIGHT_COLLAB_HOST
  FREIGHT_COLLAB_PORT

## Pr Physical Resource View

| Resource | Value |
|---|---|
| HTTP Port | 8140/TCP |
| Health Endpoints | /health, /api/v1/health |
| Runtime Profile | vibe.d + D |
