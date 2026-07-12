module uim.platform.etd.domain.entities.threat_indicator;

@safe:

struct ThreatIndicator {
    string id;
    string tenantId;
    string indicatorType;
    string indicatorValue;
    string confidence;
    string severity;
    string firstSeenAt;
    string lastSeenAt;
    string source;
    string status;
    string enrichment;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
