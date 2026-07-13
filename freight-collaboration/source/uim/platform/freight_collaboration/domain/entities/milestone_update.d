module uim.platform.freight_collaboration.domain.entities.milestone_update;

import uim.platform.freight_collaboration.domain.types;

@safe:

struct MilestoneUpdate {
    MilestoneId id;
    TenantId tenantId;
    FreightOrderId freightOrderId;
    string milestoneType;
    string eventTime;
    string location;
    string statusComment;
    string reportedBy;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
