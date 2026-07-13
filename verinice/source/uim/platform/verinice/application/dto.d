module uim.platform.verinice.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct AssetDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string assetType;
    string confidentiality;
    string integrity;
    string availability;
    string owner;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct SafeguardDTO {
    string id;
    string tenantId;
    string assetId;
    string code;
    string title;
    string description;
    string implementationStatus;
    string maturityLevel;
    string owner;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct AssessmentDTO {
    string id;
    string tenantId;
    string assetId;
    string safeguardId;
    string status;
    string riskLevel;
    string justification;
    string reviewer;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
