# Integrated Product Development Service - NAFv4 Mapping

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Overview

This document maps the EPD microservice to selected NATO Architecture Framework v4 viewpoints.

The architecture is inspired by SAP Integrated Product Development, which emphasizes digital orchestration of product development from design to operate, with integration toward SAP S/4HANA and related enterprise landscapes.

## C1 Capability View

### C1.1 Capability Taxonomy

| Capability | Sub-Capability | Implementation in This Service |
|---|---|---|
| Engineering | Product Master Governance | Products endpoint and domain entity |
| Enterprise Product Structure | BOM and Hierarchy Control | BOM and ProductStructure endpoints |
| Configuration Management | Change Control | ChangeRequest endpoints |
| Specification Management | Product Requirements and Constraints | Specification endpoints |
| Collaboration | Cross-functional Engineering Collaboration | Collaboration endpoints |
| Product Handover Readiness | Release data packaging for downstream systems | Product, document, BOM, and status cohesion |
| Formulation | Process product design data | Recipe endpoints |

### C1.2 Capability Dependencies

```text
Engineering
  -> Enterprise Product Structure
  -> Specification Management
  -> Configuration Management

Configuration Management
  -> Collaboration
  -> Product Handover Readiness

Enterprise Product Structure
  -> Product Handover Readiness
```

## C2 Enterprise Vision

### Vision Statement

Provide a modular, cloud-native backend that enables integrated product development data flows across engineering disciplines and supports predictable handover to downstream ERP and manufacturing execution landscapes.

### Goals

| Goal | Description |
|---|---|
| Faster development cycles | Streamline product definition and change propagation |
| Better traceability | Preserve links between products, structures, specs, and change records |
| Consistent governance | Enforce tenant-aware, domain-driven lifecycle operations |
| Integration readiness | Keep data model and APIs aligned with enterprise integration patterns |

## C4 Standards View

| Standard | Usage |
|---|---|
| HTTP/REST | Service contracts |
| JSON | Payload format |
| Kubernetes | Runtime deployment |
| OCI images | Packaging and transport |

## C7 Service-Oriented View

### C7.1 Service Catalog

| Service | Endpoint Prefix | Primary Consumers |
|---|---|---|
| Product Management | /api/v1/epd/products | Engineering teams |
| Product Structure | /api/v1/epd/product-structures | Product architects |
| BOM Management | /api/v1/epd/boms | Engineering and manufacturing planners |
| Change Management | /api/v1/epd/change-requests | Configuration managers |
| Specification Management | /api/v1/epd/specifications | Compliance and quality |
| Collaboration | /api/v1/epd/collaborations | Cross-functional teams |
| Engineering Documents | /api/v1/epd/documents | Technical documentation owners |
| Formulation | /api/v1/epd/recipes | Process development teams |
| Integration Orchestration | /api/v1/epd/integrations/* | ERP and handover integration operators |

### C7.2 Service Dependencies

```text
EPD Service
  consumes: tenant context, engineering payloads
  produces: governed lifecycle records and change history
  exposes: product-development APIs for integration and handover
```

## C8 Motivation View

### Drivers

| Driver | Description |
|---|---|
| Digital product development | Replace fragmented data silos with unified product lifecycle APIs |
| Time-to-market pressure | Enable faster and better-controlled product iteration |
| Cross-domain collaboration | Connect engineering, quality, and planning roles |
| Integration with enterprise backbone | Prepare product data for ERP and manufacturing handover |

### Constraints

| Constraint | Impact |
|---|---|
| In-memory persistence in current adapter | Non-durable runtime state |
| Single-process service profile | Horizontal scale and consistency controls not yet implemented |
| Tenant isolation by header | Requires API gateway or policy enforcement in production |

## Ns Logical Node View

```text
Kubernetes Namespace
  EPD Pod
    vibe.d HTTP server
      presentation adapters
      application use cases
      domain model
      memory persistence adapter

ConfigMap
  EPD_HOST
  EPD_PORT
```

## Pr Physical Resource View

| Resource | Value |
|---|---|
| HTTP Port | 8132/TCP |
| Probe Endpoint | /api/v1/health |
| Image Style | LDC2-built OCI image |
| Initial Sizing | 100m CPU, 64Mi memory |

## Source Reference

SAP Help Portal, SAP Integrated Product Development:
[https://help.sap.com/docs/PLM_EPD?locale=en-US](https://help.sap.com/docs/PLM_EPD?locale=en-US)
