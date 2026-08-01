module uim.platform.ecm.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct EcmObjectDTO {
    string id;
    string objectType;
    string tenantId;
    string name;
    string title;
    string status;
    string parentId;
    string owner;
    string description;
    string externalReference;
    string createdBy;
    string modifiedBy;
    string[string] metadata;
}
