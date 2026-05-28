# SIEM Service — NATO Architecture Framework v4 (NAFv4)

## Overview

This document describes the SIEM (Security Information and Event Management) microservice using the **NATO Architecture Framework version 4 (NAFv4)** viewpoints. NAFv4 organises architecture descriptions into seven viewpoints (C1–C8, excluding C5 which is deprecated), here adapted to a cloud-native security monitoring service.

---

## C1 — Capability View

### C1.1 Capability Taxonomy

| Capability | Sub-Capability | Description |
|------------|----------------|-------------|
| Security Monitoring | Event Ingestion | Collect raw security events from diverse log sources |
| Security Monitoring | Event Normalisation | Standardise events into a common data model |
| Threat Detection | Correlation | Apply rule-based correlation to detect threats |
| Threat Detection | Alert Generation | Produce actionable alerts from correlation results |
| Incident Response | Incident Management | Track and coordinate security incidents |
| Incident Response | IR Lifecycle | Support containment, eradication, recovery, and PIR |
| Asset Intelligence | Asset Inventory | Maintain register of monitored assets with criticality |
| Threat Intelligence | IOC Management | Ingest and manage Indicators of Compromise |
| Threat Intelligence | TI Attribution | Track threat actors, malware families, and campaigns |

### C1.2 Capability Dependencies

```
Asset Intelligence
       │
       ├──► Security Monitoring (events linked to assets)
       │
       └──► Threat Detection (asset criticality factors alert severity)

Threat Intelligence
       │
       └──► Threat Detection (IOC-based correlation rules)

Security Monitoring
       │
       └──► Threat Detection (events feed correlation engine)

Threat Detection
       │
       └──► Incident Response (alerts grouped into incidents)
```

---

## C2 — Enterprise Vision

The SIEM service provides a **unified security operations platform** for the UIM platform, enabling:

- Continuous monitoring of infrastructure and application events
- Automated threat detection through configurable correlation rules
- Structured incident response aligned with NIST SP 800-61 phases
- Threat intelligence management for proactive IOC-based detection
- Multi-tenant isolation supporting multiple organisational units
- Kubernetes-native deployment within the `uim-platform` namespace

**Strategic Objectives:**
1. Reduce mean time to detect (MTTD) through automated correlation
2. Reduce mean time to respond (MTTR) through structured incident workflows
3. Maintain comprehensive audit trails for compliance (ISO 27001, SOC 2)
4. Enable MITRE ATT&CK-aligned detection and response

---

## C4 — Standard Profiles (Standards & Protocols)

| Standard | Version | Application |
|----------|---------|-------------|
| MITRE ATT&CK | v14 | Tactic/technique mapping for alerts and correlation rules |
| STIX/TAXII | 2.1 | Threat intelligence exchange format (IOC import/export roadmap) |
| CEF (Common Event Format) | ArcSight CEF | Security event source format |
| LEEF (Log Event Extended Format) | IBM LEEF 1.0 | Security event source format |
| Syslog | RFC 5424 | Network device and Linux log transport |
| TLP (Traffic Light Protocol) | 2.0 | Threat indicator sharing classification |
| HTTP/REST | RFC 7231 | Service API transport |
| JSON | RFC 8259 | API payload encoding |
| NIST SP 800-61 | Rev. 2 | Incident response lifecycle phases |
| ISO/IEC 27001 | 2022 | Information security management framework |
| OpenID Connect | 1.0 | Identity and access management (future) |
| Kubernetes | v1.29+ | Container orchestration |
| OCI Container | 1.0 | Container image standard |

---

## C7 — Service View (Service-Oriented Architecture)

### C7.1 Services Provided

| Service | Endpoint Prefix | Consumer |
|---------|----------------|----------|
| Security Event Ingestion | `POST /api/v1/siem/security-events` | Log shippers, agents |
| Security Event Query | `GET /api/v1/siem/security-events` | SOC analysts, dashboards |
| Alert Management | `/api/v1/siem/alerts` | SOC analysts, SOAR systems |
| Incident Management | `/api/v1/siem/incidents` | Incident responders |
| Correlation Rule Management | `/api/v1/siem/correlation-rules` | Security engineers |
| Asset Inventory | `/api/v1/siem/assets` | Asset owners, vulnerability managers |
| Threat Intelligence | `/api/v1/siem/threat-indicators` | Threat intel teams, TI feeds |
| Health Check | `GET /api/v1/health` | Kubernetes probes, monitoring |

### C7.2 Service Dependencies

```
SIEM Service
    │
    ├── Consumes: Log events (from endpoint agents, network devices, applications)
    ├── Consumes: Threat feeds (manual upload via API; STIX/TAXII roadmap)
    ├── Provides: Alert stream (to SOAR, ticketing, notification systems)
    ├── Provides: Incident data (to GRC, reporting, compliance tools)
    └── Provides: Asset context (enriches events with criticality metadata)
```

---

## C8 — Motivation View

### C8.1 Drivers

| Driver | Category | Description |
|--------|----------|-------------|
| Regulatory compliance | External | SOC 2, ISO 27001 require security monitoring and incident logging |
| Threat landscape | External | Increasing sophistication of attacks demands automated detection |
| MTTD/MTTR reduction | Internal | Business requires measurable improvement in detection and response |
| Multi-tenancy | Internal | Platform serves multiple organisational units with isolation |
| DevSecOps integration | Internal | Security must be observable and automatable in CI/CD pipelines |

### C8.2 Goals and Objectives

| Goal | Measurable Objective |
|------|----------------------|
| Continuous visibility | 100% of infrastructure events normalised and indexed |
| Rapid detection | MTTD < 15 minutes for high-severity events |
| Structured response | All critical incidents follow NIST SP 800-61 phases |
| Threat intelligence | IOC database updated within 1 hour of new TI feeds |
| Compliance | Audit logs retained for 12 months minimum |

### C8.3 Constraints

| Constraint | Type | Description |
|------------|------|-------------|
| In-memory persistence (initial) | Technical | Production deployment requires persistent database adapter |
| Single replica | Operational | Scale-out requires distributed event ordering consideration |
| No authentication (initial) | Security | API gateway / OAuth2 required before production exposure |
| Event volume | Technical | In-memory store suits dev/test; switch to time-series DB for production |

---

## Ns — Logical Architecture Node

```
┌─────────────────────────────────────────────────────────────────────┐
│                     uim-platform (Kubernetes)                        │
│                                                                       │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │                    siem Pod (port 8125)                      │   │
│   │                                                              │   │
│   │   ┌────────────────────────────────────────────────────┐    │   │
│   │   │          vibe.d HTTP Server (URLRouter)            │    │   │
│   │   └────────────────────────┬───────────────────────────┘    │   │
│   │                            │                                │   │
│   │   ┌────────────────────────▼───────────────────────────┐    │   │
│   │   │                 Controllers                         │    │   │
│   │   │  SecurityEvent │ Alert │ Incident │ CorrelRule     │    │   │
│   │   │  Asset │ ThreatIndicator │ Health                   │    │   │
│   │   └────────────────────────┬───────────────────────────┘    │   │
│   │                            │                                │   │
│   │   ┌────────────────────────▼───────────────────────────┐    │   │
│   │   │                  Use Cases                          │    │   │
│   │   │  Manage* (6 use case classes)                       │    │   │
│   │   └────────────────────────┬───────────────────────────┘    │   │
│   │                            │                                │   │
│   │   ┌────────────────────────▼───────────────────────────┐    │   │
│   │   │           In-Memory Repositories                    │    │   │
│   │   │  Memory*Repository (6 implementations)              │    │   │
│   │   └────────────────────────────────────────────────────┘    │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                       │
│   ConfigMap: siem-config (SIEM_HOST, SIEM_PORT)                      │
│   Service: ClusterIP :8125                                            │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Pr — Physical Resource View

| Resource | Specification | Notes |
|----------|---------------|-------|
| Container Image | Alpine 3.20 + LDC2 | Multi-stage build; final image ~20 MB |
| CPU Request | 100m | Kubernetes resource request |
| CPU Limit | 500m | Kubernetes resource limit |
| Memory Request | 64 Mi | Kubernetes resource request |
| Memory Limit | 256 Mi | Kubernetes resource limit |
| Port | 8125/TCP | HTTP service port |
| Liveness Probe | GET /api/v1/health | 10s initial delay, 30s period |
| Readiness Probe | GET /api/v1/health | 5s initial delay, 10s period |
