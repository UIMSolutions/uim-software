# NAFv4 — UIM LEAN Platform Service

NATO Architecture Framework v4 views for the UIM LEAN Enterprise Architecture Management Platform Service.

---

## C1 — Capability Taxonomy

The service supports the following enterprise capabilities:

```
EA Management Platform
├── Strategy Management
│   ├── Objective Tracking
│   ├── Platform Portfolio Management
│   └── Initiative Planning
├── Business Architecture Management
│   ├── Organisation Modelling
│   ├── Business Capability Mapping
│   └── Business Context Definition
├── Application Architecture Management
│   ├── Application Portfolio Management
│   ├── Application Interface Mapping
│   └── Data Object Governance
└── Technical Architecture Management
    ├── IT Component Lifecycle Management
    ├── Provider / Vendor Management
    └── Technology Category Governance
```

---

## C2 — Enterprise Vision

The UIM LEAN Platform Service provides a cloud-native, tenant-aware API for managing enterprise architecture artefacts across the full LeanIX meta model. Its purpose is to give architects, product owners, and business analysts a single source of truth for all IT landscape facts, enabling:

- Strategic alignment of applications to business objectives
- Continuous lifecycle tracking of applications and IT components
- Technology risk and fitness assessments (functional fit / technical fit)
- Data classification and GDPR compliance awareness
- Organisation-scoped cost transparency via annual cost fields

---

## C4 — Standards

| Standard | Application |
|---------|-------------|
| LeanIX Meta Model v4 | Fact sheet types and relationships |
| NAFv4 | Architecture documentation structure |
| REST / HTTP 1.1 | API transport |
| JSON | Data interchange format |
| OpenID Connect (future) | Authentication |
| OWASP Top 10 | Security baseline |
| 12-Factor App | Configuration via environment variables |
| OCI / Docker | Container image format |
| Kubernetes 1.28+ | Orchestration platform |

---

## C7 — Services

| Service Name | Endpoint Base | Port | Description |
|-------------|--------------|------|-------------|
| lean-platform | `/api/v1/lean` | 8130 | EAM REST API |
| Health | `/api/v1/health` | 8130 | Liveness / readiness |

### Service Dependencies (runtime)

The service has no external runtime dependencies in its current in-memory configuration. Future deployments should connect to:

- PostgreSQL (persistence adapter)
- Keycloak / SAP IAS (OIDC authentication)
- Kafka (change event streaming)

---

## C8 — Motivation

| Driver | Rationale |
|--------|-----------|
| Strategic Alignment | Link IT initiatives directly to corporate objectives and measure contribution |
| Cost Transparency | Aggregate annual costs per application, IT component, and provider |
| Risk Reduction | Track technical fit, functional fit, and lifecycle status to proactively identify obsolescence |
| Compliance | GDPR basis, data classification, and personal data flag on data objects |
| Standardisation | Enforce common taxonomy for tech categories and IT components across the enterprise |

---

## Node Diagram (Physical Deployment)

```
┌──────────────────────────────────────────────────────────┐
│  Kubernetes Cluster — namespace: uim-platform            │
│                                                          │
│  ┌──────────────────────────────────────────────────┐   │
│  │  Deployment: lean (2 replicas)                   │   │
│  │  Image: uim-lean-platform-service:latest         │   │
│  │  ┌────────────────────────────────────────────┐  │   │
│  │  │  Container: lean                           │  │   │
│  │  │  Port: 8130                                │  │   │
│  │  │  Env: LEAN_HOST, LEAN_PORT (ConfigMap)     │  │   │
│  │  └────────────────────────────────────────────┘  │   │
│  └──────────────────────────────────────────────────┘   │
│                           │                              │
│  ┌────────────────────────▼─────────────────────────┐   │
│  │  Service: lean (ClusterIP)                       │   │
│  │  Port: 8130 → targetPort: 8130                   │   │
│  └──────────────────────────────────────────────────┘   │
│                           │                              │
│  ┌────────────────────────▼─────────────────────────┐   │
│  │  ConfigMap: lean-config                          │   │
│  │  LEAN_HOST=0.0.0.0  LEAN_PORT=8130               │   │
│  └──────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────┘
              ▲
              │ HTTP
┌─────────────┴───────────┐
│  Ingress / API Gateway  │
└─────────────────────────┘
              ▲
              │
┌─────────────┴───────────┐
│  Client (browser / CLI) │
└─────────────────────────┘
```

---

## Physical Resources

| Resource | Spec |
|----------|------|
| Container base image | Alpine 3.20 |
| Compiler | LDC2 (LLVM-based D compiler) |
| CPU request | 100m |
| CPU limit | 500m |
| Memory request | 128Mi |
| Memory limit | 512Mi |
| Replicas | 2 (default) |
| Storage | None (in-memory) |
