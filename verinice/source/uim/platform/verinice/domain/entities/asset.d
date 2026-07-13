module uim.platform.verinice.domain.entities.asset;

import uim.platform.verinice.domain.types;

@safe:

struct Asset {
    AssetId id;
    TenantId tenantId;
    string name;
    string description;
    string assetType;
    string confidentiality;
    string integrity;
    string availability;
    string owner;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
