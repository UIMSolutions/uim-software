module uim.platform.defense.domain.entities.readiness_profile;

import uim.platform.defense.domain.types;

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