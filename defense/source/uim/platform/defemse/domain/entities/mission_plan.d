module uim.platform.defense.domain.entities.mission_plan;

import uim.platform.defense.domain.types;

@safe:

struct MissionPlan {
    MissionPlanId id;
    TenantId tenantId;
    string reference;
    string name;
    string objective;
    string missionType;
    string region;
    MissionStatus status = MissionStatus.planned;
    string assignedContingentIds;
    string locationId;
    string downstreamProcessState;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}