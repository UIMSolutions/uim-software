module uim.platform.bw.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct BwObjectDTO {
    string id;
    string objectType;
    string tenantId;
    string technicalName;
    string businessName;
    string semanticLayer;
    string sourceSystem;
    string lifecycleState;
    string parentId;
    string owner;
    string description;
    string externalReference;
    string createdBy;
    string modifiedBy;
    string[string] metadata;
}

struct QueryExecutionDTO {
    string providerId;
    string queryId;
    string language;
    string[string] variables;
}
