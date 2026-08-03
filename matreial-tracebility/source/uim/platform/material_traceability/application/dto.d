module uim.platform.material_traceability.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct MtObjectDTO {
    string id;
    string objectType;
    string tenantId;
    string technicalName;
    string businessName;
    string traceabilityDomain;
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

struct RecallSimulationDTO {
    string recallCaseId;
    string materialId;
    string lotId;
    string horizon;
    string[string] parameters;
}
