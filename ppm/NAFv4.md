# Enterprise Portfolio and Project Management Service - NAFv4

<!-- markdownlint-disable MD040 MD060 MD047 MD058 MD031 -->

## Overview

This document maps the service to selected NATO Architecture Framework v4 views for enterprise portfolio and project management.

## C1 Capability View

| Capability | Sub-Capability | Description |
|------------|----------------|-------------|
| Portfolio Governance | Strategic Portfolio Planning | Define and steer strategic portfolios |
| Initiative Governance | Intake and Prioritization | Evaluate and rank candidate initiatives |
| Program Management | Program Coordination | Group related projects under program outcomes |
| Project Management | Project Lifecycle Control | Plan and execute projects with milestones |
| Demand Management | Demand Qualification | Capture, triage, and qualify incoming demand |
| Resource Management | Resource Requesting | Track requested staffing and role needs |

## C2 Enterprise Vision

The service enables enterprise planning teams to align strategic portfolios with executable programs and projects while maintaining transparent demand and resource pipelines.

### Strategic Outcomes

- Better alignment of investment decisions with strategy
- Improved traceability from demand to funded execution
- Faster portfolio balancing through consistent status views
- Shared visibility for project and staffing decisions

## C4 Standards View

| Standard | Usage |
|----------|-------|
| HTTP REST | Service transport |
| JSON | Payload format |
| Kubernetes | Runtime platform |
| OCI Containers | Packaging |

## C7 Service View

| Service | Endpoint Prefix | Main Consumer |
|---------|-----------------|---------------|
| Portfolio Service | /api/v1/ppm/portfolios | Portfolio managers |
| Initiative Service | /api/v1/ppm/initiatives | PMO and governance boards |
| Program Service | /api/v1/ppm/programs | Program managers |
| Project Service | /api/v1/ppm/projects | Project managers |
| Demand Service | /api/v1/ppm/demands | Business demand owners |
| Resource Request Service | /api/v1/ppm/resource-requests | Resource and staffing leads |

## C8 Motivation View

| Driver | Type | Notes |
|--------|------|-------|
| Investment transparency | Business | Link strategy to delivery execution |
| Governance traceability | Operational | Keep initiative and project decisions auditable |
| Capacity constraints | Operational | Expose resource demand early |
| Process standardization | Technical | Common API model across portfolio entities |

## Ns Logical Node View

```text
uim-platform Kubernetes cluster
  ppm pod
    vibe.d HTTP server
    clean and hexagonal layers
```

## Pr Physical Resource View

| Resource | Baseline |
|----------|----------|
| HTTP Port | 8141 |
| Liveness probe | GET /api/v1/health |
| Readiness probe | GET /api/v1/health |
| CPU request | 100m |
| Memory request | 64 Mi |
