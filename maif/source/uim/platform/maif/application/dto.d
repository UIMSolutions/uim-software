module uim.platform.maif.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct MobileAppDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string platform;
    string versionTag;
    string status;
    string owner;
    string backendSystem;
    string authProfile;
    string createdBy;
    string modifiedBy;
}

struct IntegrationFlowDTO {
    string id;
    string tenantId;
    string appId;
    string name;
    string sourceSystem;
    string targetSystem;
    string protocol;
    string mappingPolicy;
    string retryPolicy;
    string status;
    string createdBy;
    string modifiedBy;
}

struct SyncJobDTO {
    string id;
    string tenantId;
    string flowId;
    string triggerType;
    string status;
    string startedAt;
    string finishedAt;
    string recordsProcessed;
    string recordsFailed;
    string lastError;
    string createdBy;
    string modifiedBy;
}
