module uim.platform.etd.domain.entities.incident;

@safe:

struct Incident {
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
    string createdAt;
    string modifiedAt;
}
