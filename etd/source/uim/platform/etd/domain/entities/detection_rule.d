module uim.platform.etd.domain.entities.detection_rule;

@safe:

struct DetectionRule {
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
    string createdAt;
    string modifiedAt;
}
