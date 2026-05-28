# Security Information and Event Management (SIEM) Service

A microservice implementing Security Information and Event Management features using **D language (dlang)** and **vibe.d**, following a combination of **clean architecture** and **hexagonal architecture** principles.

## Overview

This service provides comprehensive security monitoring and incident response capabilities, including raw security event ingestion, automated alert generation through correlation rules, incident lifecycle management, monitored asset inventory, and threat intelligence (IOC) management.

## Features

- **Security Events** — Ingest and process raw security events from diverse sources (Syslog, CEF, LEEF, JSON, Windows, Linux, cloud, network, endpoint, application)
- **Alerts** — Triggered security alerts produced by correlation rules, enriched with MITRE ATT&CK mappings
- **Incidents** — Full incident lifecycle management from detection through post-incident review (containment, eradication, recovery, lessons learned)
- **Correlation Rules** — Define threshold, correlation, anomaly, threat-intelligence, behavioral, and sequence detection rules
- **Assets** — Maintain an inventory of monitored assets (servers, workstations, network devices, cloud instances, containers, IoT, mobile, applications) with criticality scoring
- **Threat Indicators** — Manage Indicators of Compromise (IP, domain, URL, hash, email, filename, registry, certificate) with TLP-level and confidence scoring

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   Presentation Layer                     │
│       (HTTP Controllers, JSON Utils — vibe.d)            │
├─────────────────────────────────────────────────────────┤
│                   Application Layer                      │
│              (Use Cases, DTOs)                           │
├─────────────────────────────────────────────────────────┤
│                    Domain Layer                          │
│    (Entities, Repository Interfaces, Domain Services)    │
├─────────────────────────────────────────────────────────┤
│                 Infrastructure Layer                     │
│   (Config, DI Container, In-Memory Repositories)         │
└─────────────────────────────────────────────────────────┘
```

### Clean Architecture

- **Domain Layer** — Pure business entities, value objects, and repository interfaces with zero external dependencies
- **Application Layer** — Use cases orchestrate domain objects; DTOs decouple transport from domain
- **Infrastructure Layer** — Implements repository interfaces (in-memory; swap to database without touching domain/application)
- **Presentation Layer** — HTTP controllers translate HTTP requests/responses to/from use case calls

### Hexagonal Architecture (Ports and Adapters)

- **Ports** — Repository interfaces (`SecurityEventRepository`, `AlertRepository`, etc.) and use case classes are the ports
- **Adapters** — `Memory*Repository` implementations are driving adapters; HTTP controllers are driving adapters via vibe.d

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/siem/security-events` | List all security events |
| POST | `/api/v1/siem/security-events` | Ingest a new security event |
| GET | `/api/v1/siem/security-events/:id` | Get security event by ID |
| PUT | `/api/v1/siem/security-events/:id` | Update security event status |
| DELETE | `/api/v1/siem/security-events/:id` | Delete a security event |
| GET | `/api/v1/siem/alerts` | List all alerts |
| POST | `/api/v1/siem/alerts` | Create an alert |
| GET | `/api/v1/siem/alerts/:id` | Get alert by ID |
| PUT | `/api/v1/siem/alerts/:id` | Update alert (assign, resolve) |
| DELETE | `/api/v1/siem/alerts/:id` | Delete an alert |
| GET | `/api/v1/siem/incidents` | List all incidents |
| POST | `/api/v1/siem/incidents` | Open a new incident |
| GET | `/api/v1/siem/incidents/:id` | Get incident by ID |
| PUT | `/api/v1/siem/incidents/:id` | Update incident lifecycle |
| DELETE | `/api/v1/siem/incidents/:id` | Delete an incident |
| GET | `/api/v1/siem/correlation-rules` | List all correlation rules |
| POST | `/api/v1/siem/correlation-rules` | Create a correlation rule |
| GET | `/api/v1/siem/correlation-rules/:id` | Get correlation rule by ID |
| PUT | `/api/v1/siem/correlation-rules/:id` | Update a correlation rule |
| DELETE | `/api/v1/siem/correlation-rules/:id` | Delete a correlation rule |
| GET | `/api/v1/siem/assets` | List all monitored assets |
| POST | `/api/v1/siem/assets` | Register an asset |
| GET | `/api/v1/siem/assets/:id` | Get asset by ID |
| PUT | `/api/v1/siem/assets/:id` | Update asset details |
| DELETE | `/api/v1/siem/assets/:id` | Remove an asset |
| GET | `/api/v1/siem/threat-indicators` | List all threat indicators |
| POST | `/api/v1/siem/threat-indicators` | Add a threat indicator |
| GET | `/api/v1/siem/threat-indicators/:id` | Get threat indicator by ID |
| PUT | `/api/v1/siem/threat-indicators/:id` | Update a threat indicator |
| DELETE | `/api/v1/siem/threat-indicators/:id` | Retire a threat indicator |
| GET | `/api/v1/health` | Health check |

## Request Headers

| Header | Description |
|--------|-------------|
| `X-Tenant-Id` | Tenant identifier for multi-tenant isolation |
| `Content-Type: application/json` | Required for POST/PUT requests |

## Configuration

| Environment Variable | Default | Description |
|----------------------|---------|-------------|
| `SIEM_HOST` | `0.0.0.0` | Bind address |
| `SIEM_PORT` | `8125` | HTTP port |

## Building

```bash
# Development build
dub build

# Release build (LDC2)
dub build --compiler=ldc2 -b release

# Run tests
dub test
```

## Docker / Podman

```bash
# Build image
docker build -t uim-platform/siem:latest .

# Run container
docker run -p 8125:8125 \
  -e SIEM_HOST=0.0.0.0 \
  -e SIEM_PORT=8125 \
  uim-platform/siem:latest
```

## Kubernetes

```bash
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

## Domain Model

### Security Event
Raw log entry ingested from a source system. Fields include source/destination IPs, protocol, username, hostname, raw log, event type, category, action, outcome, and SIEM linkage fields (assetId, correlationRuleId, alertId).

### Alert
A security finding raised when a correlation rule fires. Enriched with MITRE ATT&CK tactic/technique, assigned analyst, and resolution tracking.

### Incident
A coordinated security incident grouping one or more alerts. Tracks the full IR lifecycle: detected → containment → eradication → recovery → closed → post-incident review.

### Correlation Rule
A detection logic definition. Supports threshold (count-based), correlation (multi-event), anomaly, threat-intelligence (IOC match), behavioral, and sequence rule types. Maps to MITRE ATT&CK.

### Asset
A monitored network asset with type classification (server, workstation, network device, cloud instance, container, IoT, mobile, application) and criticality scoring (low/medium/high/critical).

### Threat Indicator (IOC)
An Indicator of Compromise: IP address, domain, URL, file hash, email, filename, registry key, or certificate. Tagged with TLP level, confidence, threat actor, malware family, and campaign attribution.

## License

Apache-2.0 — Copyright (c) 2018-2026, Ozan Nurettin Suel
