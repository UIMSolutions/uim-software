# NAFv4 Architecture Notes - ETD Service

## Scope

This document maps the ETD service to a NAFv4-style viewpoint set for operational cyber threat detection in cloud-centric enterprise landscapes.

## Capability View (CV)

- CV-1 Capability Taxonomy:
  - Detect suspicious activity patterns from telemetry.
  - Correlate indicators and incidents.
  - Coordinate response handoff.
  - Integrate with external threat intelligence.
- CV-2 Capability Dependencies:
  - Detection rule lifecycle supports incident generation quality.
  - Threat indicator enrichment supports triage speed and confidence.

## Operational View (OV)

- OV-1 High-level Operational Concept:
  - SOC clients manage incidents, indicators, and rules through REST APIs.
  - ETD service provides consistent threat-state data and response metadata.
- OV-5 Operational Activity Model:
  - Ingest indicator -> enrich indicator -> detect event pattern -> create/update incident -> track containment.
- OV-6 Event-Trace:
  - Rule trigger and IOC matches can drive incident updates and integration workflows.

## Service-Oriented View (SOV)

- SOV-1 Service Interface:
  - REST interfaces under `/api/v1/etd`.
- SOV-2 Service Realization:
  - Inbound adapters: HTTP controllers.
  - Application services: use-case classes.
  - Outbound adapters: in-memory repositories and threat-intel gateway stub.

## Logical View (LV)

- Domain entities:
  - Incident
  - ThreatIndicator
  - DetectionRule
- Bounded context:
  - Enterprise Threat Detection context with explicit repository and gateway ports.

## Security Considerations

- Tenant context expected via `X-Tenant-Id` header.
- Validation guards prevent creation of malformed incidents, indicators, and rules.
- Integration endpoint returns controlled error details for missing indicators or adapter failures.

## Deployment Notes

- Stateless service process with in-memory adapters suitable for local development and architecture validation.
- Production deployment should replace memory adapters with persistent storage and secure outbound integration adapters.
