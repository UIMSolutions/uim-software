module uim.platform.etd.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct IncidentDTO {
    string id;
    string tenantId;
    string title;
    string description;
    string severity;
    string status;
    string category;
    string sourceSystem;
    string detectedAt;
    string assignedTo;
    string containmentStatus;
    string createdBy;
    string modifiedBy;
}

struct ThreatIndicatorDTO {
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
}

struct DetectionRuleDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string queryPattern;
    string severity;
    string schedule;
    string status;
    string mitreTactic;
    string mitreTechnique;
    string createdBy;
    string modifiedBy;
}
