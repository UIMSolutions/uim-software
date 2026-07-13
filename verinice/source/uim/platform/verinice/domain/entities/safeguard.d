module uim.platform.verinice.domain.entities.safeguard;

import uim.platform.verinice.domain.types;

@safe:

struct Safeguard {
    SafeguardId id;
    TenantId tenantId;
    AssetId assetId;
    string code;
    string title;
    string description;
    string implementationStatus = "planned";
    string maturityLevel;
    string owner;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
