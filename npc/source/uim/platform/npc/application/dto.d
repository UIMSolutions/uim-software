module uim.platform.npc.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct NpcObjectDTO {
    string id;
    string objectType;
    string tenantId;
    string technicalName;
    string businessName;
    string planningDomain;
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

struct SimulationDTO {
    string scenarioId;
    string demandPlanId;
    string supplyPlanId;
    string horizon;
    string[string] parameters;
}
