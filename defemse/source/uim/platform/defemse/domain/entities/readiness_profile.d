module uim.platform.defemse.domain.entities.readiness_profile;

import uim.platform.defemse.domain.types;

@safe:

struct ReadinessProfile {
    ReadinessProfileId id;
    TenantId tenantId;
    ContingentId contingentId;
    MissionPlanId missionPlanId;
    string personnelReadyPercent;
    string equipmentReadyPercent;
    string supplyReadyPercent;
    string maintenanceOpenCount;
    string mobilityState;
    string communicationState;
    ReadinessStatus status = ReadinessStatus.medium;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}