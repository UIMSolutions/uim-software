module uim.platform.freight_collaboration.domain.entities.freight_order;

import uim.platform.freight_collaboration.domain.types;

@safe:

struct FreightOrder {
    FreightOrderId id;
    TenantId tenantId;
    string orderNumber;
    string shipperId;
    string carrierId;
    string transportMode;
    string status = "planned";
    string originLocation;
    string destinationLocation;
    string plannedPickup;
    string plannedDelivery;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
