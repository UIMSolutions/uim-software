module uim.platform.freight_collaboration.domain.entities.tender;

import uim.platform.freight_collaboration.domain.types;

@safe:

struct Tender {
    TenderId id;
    TenantId tenantId;
    FreightOrderId freightOrderId;
    string tenderNumber;
    string status = "open";
    string offeredRate;
    string currency;
    string responseBy;
    string awardedCarrierId;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
