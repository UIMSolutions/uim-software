module uim.platform.defense.application.dto;

@safe:

struct MissionPlanDTO {
    string id;
    string tenantId;
    string reference;
    string name;
    string objective;
    string missionType;
    string region;
    string status;
    string assignedContingentIds;
    string locationId;
    string downstreamProcessState;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct ExerciseDTO {
    string id;
    string tenantId;
    string reference;
    string name;
    string exerciseType;
    string exerciseScope;
    string status;
    string missionPlanId;
    string plannedStart;
    string plannedEnd;
    string contingencyLevel;
    string relocationRequired;
    string locationId;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct ContingentDTO {
    string id;
    string tenantId;
    string code;
    string name;
    string unitType;
    string personnelStrength;
    string equipmentCount;
    string status;
    string readinessStatus;
    string currentLocationId;
    string destinationLocationId;
    string transportMode;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct ReadinessProfileDTO {
    string id;
    string tenantId;
    string contingentId;
    string missionPlanId;
    string personnelReadyPercent;
    string equipmentReadyPercent;
    string supplyReadyPercent;
    string maintenanceOpenCount;
    string mobilityState;
    string communicationState;
    string status;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct RedeploymentOrderDTO {
    string id;
    string tenantId;
    string missionPlanId;
    string contingentId;
    string originLocationId;
    string destinationLocationId;
    string transportType;
    string priority;
    string executionWindow;
    string status;
    string reason;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct MaintenanceTaskDTO {
    string id;
    string tenantId;
    string contingentId;
    string equipmentId;
    string taskType;
    string priority;
    string dueAt;
    string status;
    string locationId;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct BudgetTriggerDTO {
    string id;
    string tenantId;
    string missionPlanId;
    string sourceProcess;
    string amount;
    string currency;
    string triggerReason;
    string status;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct OfflineSyncRecordDTO {
    string id;
    string tenantId;
    string recordType;
    string recordId;
    string action;
    string payload;
    string status;
    string lastSyncedAt;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}