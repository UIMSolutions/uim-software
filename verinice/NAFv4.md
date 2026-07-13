# Verinice IT-Grundschutz Service - NAFv4 Mapping

<!-- markdownlint-disable MD040 MD060 MD047 -->

## Overview

This document maps the Verinice IT-Grundschutz service to selected NATO Architecture Framework v4 viewpoints.

The mapping aligns with IT-Grundschutz-oriented capabilities described in verinice domain references and realizes them as cloud-native service interfaces.

## C1 Capability View

### C1.1 Capability Taxonomy

| Capability | Sub-Capability | Service Realization |
|---|---|---|
| Asset Governance | Asset registration and classification | /api/v1/verinice/assets |
| Safeguard Management | Safeguard planning and implementation tracking | /api/v1/verinice/safeguards |
| Assessment Management | Risk and status assessments | /api/v1/verinice/assessments |
| Catalog Synchronization | External safeguard catalog alignment | /api/v1/verinice/integrations/* |

### C1.2 Capability Dependencies

```text
Asset Governance
  -> Safeguard Management
  -> Assessment Management

Safeguard Management
  -> Assessment Management
  -> Catalog Synchronization
```

## C2 Enterprise Vision

### Vision Statement

Provide an IT-Grundschutz-oriented backend for structured asset protection planning, safeguard execution, and risk assessment with clear integration boundaries.

### Goals

| Goal | Description |
|---|---|
| Consistent protection modeling | Keep assets, safeguards, and assessments coherent |
| Traceable governance | Track safeguard and assessment lifecycle states |
| Integration readiness | Support external catalog synchronization adapters |
| Operational reliability | Provide predictable health and runtime controls |

## C4 Standards View

| Standard | Usage |
|---|---|
| HTTP/REST | Service interaction model |
| JSON | Payload format |
| Kubernetes/OCI | Deployment target model |

## C7 Service-Oriented View

### C7.1 Service Catalog

| Service | Endpoint Prefix | Consumers |
|---|---|---|
| Asset Service | /api/v1/verinice/assets | Security architecture teams |
| Safeguard Service | /api/v1/verinice/safeguards | IT-GS control owners |
| Assessment Service | /api/v1/verinice/assessments | Risk and compliance teams |
| Integration Orchestration Service | /api/v1/verinice/integrations/* | External IT-GS catalog workflows |

### C7.2 Service Dependencies

```text
Verinice IT-GS Service
  consumes: tenant-scoped governance payloads
  produces: validated assets, safeguards, and assessments
  exposes: synchronization trigger for external catalog integration
```

## C8 Motivation View

### Drivers

| Driver | Description |
|---|---|
| Security governance quality | Improve consistency of protection planning |
| Auditability | Maintain evidence-ready assessment records |
| Integration continuity | Keep safeguard definitions aligned with external sources |
| Maintainability | Isolate domain behavior from adapters and transport concerns |

### Constraints

| Constraint | Impact |
|---|---|
| In-memory repository adapter | Not durable for production persistence |
| Stub integration adapter | External platform connection not yet implemented |
| Single-service profile | Horizontal scale and workflow orchestration not modeled |

## Ns Logical Node View

```text
Kubernetes Namespace
  Verinice Pod
    vibe.d HTTP server
      presentation adapters
      application orchestration
      domain model and ports
      memory persistence adapter
      verinice catalog sync stub adapter

ConfigMap
  VERINICE_HOST
  VERINICE_PORT
```

## Pr Physical Resource View

| Resource | Value |
|---|---|
| HTTP Port | 8139/TCP |
| Health Endpoints | /health, /api/v1/health |
| Runtime Profile | vibe.d + D (LDC/GDC compatible) |

## Source References

- https://docs.eu.verinice.cloud/en/domain-it-gs/
- https://github.com/sernet/verinice
