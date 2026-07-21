module uim.platform.defense.domain.entities.redeployment_order;

import uim.platform.defense.domain.types;

@safe:

struct RedeploymentOrder {
    RedeploymentOrderId id;
    TenantId tenantId;
    MissionPlanId missionPlanId;
    ContingentId contingentId;
    string originLocationId;
    string destinationLocationId;
    string transportType;
    string priority;
    string executionWindow;
    RedeploymentStatus status = RedeploymentStatus.requested;
    string reason;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}