# ETD - Enterprise Threat Detection Service

This package provides an ETD-oriented service inspired by SAP Enterprise Threat Detection, Cloud Edition.

## Architectural Style

The implementation combines:

- Clean Architecture: domain and application rules are isolated from transport and persistence details.
- Hexagonal Architecture: inbound ports (HTTP controllers) and outbound ports (repositories, threat intel gateway) are connected by adapters.

## Capabilities

- Incident management lifecycle (`new`, `in-progress`, `contained`, `closed`).
- Threat indicator (IOC) management and enrichment metadata.
- Detection rule management for pattern-based monitoring.
- Outbound integration stub for threat-intel synchronization.

## HTTP API

Base path: `/api/v1/etd`

- `GET /incidents`
- `POST /incidents`
- `GET /incidents/:id`
- `PUT /incidents/:id`
- `DELETE /incidents/:id`
- `GET /threat-indicators`
- `POST /threat-indicators`
- `GET /threat-indicators/:id`
- `PUT /threat-indicators/:id`
- `DELETE /threat-indicators/:id`
- `GET /detection-rules`
- `POST /detection-rules`
- `GET /detection-rules/:id`
- `PUT /detection-rules/:id`
- `DELETE /detection-rules/:id`
- `POST /integrations/threat-intel-sync/:indicatorId`

Additional endpoints:

- `GET /`
- `GET /health`
- `GET /api/v1/health`

## Run Locally

```bash
cd etd
dub run
```

Optional environment variables:

- `ETD_HOST` (default `0.0.0.0`)
- `ETD_PORT` (default `8168`)

## Example Payloads

Create incident:

```json
{
  "title": "Suspicious lateral movement",
  "description": "Multiple failed RDP attempts followed by success",
  "severity": "high",
  "category": "credential-compromise",
  "sourceSystem": "sap-audit-log",
  "assignedTo": "soc-analyst-1"
}
```

Create threat indicator:

```json
{
  "indicatorType": "ip",
  "indicatorValue": "198.51.100.22",
  "confidence": "high",
  "severity": "medium",
  "source": "external-feed"
}
```

Create detection rule:

```json
{
  "name": "Brute force and privilege escalation chain",
  "queryPattern": "failed_logons > 20 and privileged_command=true",
  "severity": "high",
  "schedule": "*/5 * * * *"
}
```
