module uim.platform.ead.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct EadObjectDTO {
    string id;
    string objectType;
    string tenantId;
    string technicalName;
    string businessName;
    string architectureLayer;
    string lifecycleState;
    string parentId;
    string sourceId;
    string targetId;
    string owner;
    string description;
    string externalReference;
    string createdBy;
    string modifiedBy;
    string[string] metadata;
}

struct DiagramRenderRequestDTO {
    string diagramId;
    string viewpoint;
    string language;
    string[string] variables;
}
