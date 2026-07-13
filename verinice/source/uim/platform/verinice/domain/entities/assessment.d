module uim.platform.verinice.domain.entities.assessment;

import uim.platform.verinice.domain.types;

@safe:

struct Assessment {
    AssessmentId id;
    TenantId tenantId;
    AssetId assetId;
    SafeguardId safeguardId;
    string status = "open";
    string riskLevel;
    string justification;
    string reviewer;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
