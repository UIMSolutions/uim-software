# Manufacturing Integration and Intelligence Service - NAFv4 Mapping

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Overview

This document maps the MII microservice to selected NATO Architecture Framework v4 viewpoints.

The mapping is aligned with SAP Manufacturing Integration and Intelligence guidance from SAP Help and translates manufacturing integration and intelligence concerns into a cloud-native service architecture.

## C1 Capability View

### C1.1 Capability Taxonomy

| Capability | Sub-Capability | Service Realization |
|---|---|---|
| Message Integration | Production message intake and normalization | /api/v1/mii/production-messages |
| Shop-Floor Connectivity | Work center event ingestion | /api/v1/mii/work-center-events |
| Data Acquisition | Structured data collection pipelines | /api/v1/mii/data-collections |
| Operational Intelligence | KPI observation and aggregation | /api/v1/mii/kpi-observations |
| Alerting | Alert and notification management | /api/v1/mii/alert-notifications |
| Workflow Orchestration | Workflow instance tracking | /api/v1/mii/workflow-instances |
| Visualization Integration | Dashboard widget feed and interaction | /api/v1/mii/dashboard-widgets |
| Endpoint Governance | Integration endpoint and synchronization control | /api/v1/mii/integration-endpoints, /api/v1/mii/integrations/* |

### C1.2 Capability Dependencies

```text
Message Integration
  -> Shop-Floor Connectivity
  -> Data Acquisition
  -> Endpoint Governance

Data Acquisition
  -> Operational Intelligence
  -> Alerting

Workflow Orchestration
  -> Alerting
  -> Visualization Integration
```

## C2 Enterprise Vision

### Vision Statement

Provide an MII-like backend that connects plant events and production messages with KPI intelligence, alerting, and enterprise synchronization workflows.

### Goals

| Goal | Description |
|---|---|
| Integration consistency | Keep manufacturing message flows coherent across systems |
| Operational insight | Enable KPI and alert visibility from shop-floor data |
| Interoperability | Expose stable endpoints for ERP and analytics synchronization |
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
| Production Message Service | /api/v1/mii/production-messages | Integration engineers |
| Work Center Event Service | /api/v1/mii/work-center-events | Plant connectivity services |
| Data Collection Service | /api/v1/mii/data-collections | Data acquisition pipelines |
| KPI Observation Service | /api/v1/mii/kpi-observations | Operational intelligence teams |
| Alert Notification Service | /api/v1/mii/alert-notifications | Monitoring and incident teams |
| Workflow Instance Service | /api/v1/mii/workflow-instances | Process orchestration owners |
| Dashboard Widget Service | /api/v1/mii/dashboard-widgets | Manufacturing dashboards |
| Integration Endpoint Service | /api/v1/mii/integration-endpoints | Interface governance teams |
| Integration Orchestration Service | /api/v1/mii/integrations/* | ERP and analytics integration operations |

### C7.2 Service Dependencies

```text
MII Service
  consumes: tenant-scoped production integration payloads
  produces: governed message records and synchronization events
  exposes: stable service interfaces for MII-like operations
```

## C8 Motivation View

### Drivers

| Driver | Description |
|---|---|
| Plant connectivity | Integrate heterogeneous shop-floor signals and events |
| Real-time intelligence | Improve KPI visibility and response speed |
| Enterprise interoperability | Synchronize manufacturing context with ERP and analytics |
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
  MII Pod
    vibe.d HTTP server
      presentation adapters
      application orchestration
      domain model and ports
      memory persistence adapter
      SAP MII integration stub adapters

ConfigMap
  MII_HOST
  MII_PORT
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
[https://help.sap.com/docs/SAP_MANUFACTURING_INTEGRATION_AND_INTELLIGENCE?locale=en-US](https://help.sap.com/docs/SAP_MANUFACTURING_INTEGRATION_AND_INTELLIGENCE?locale=en-US)
