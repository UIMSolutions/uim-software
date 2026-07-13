module uim.platform.freight_collaboration.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct FreightOrderDTO {
    string id;
    string tenantId;
    string orderNumber;
    string shipperId;
    string carrierId;
    string transportMode;
    string status;
    string originLocation;
    string destinationLocation;
    string plannedPickup;
    string plannedDelivery;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct TenderDTO {
    string id;
    string tenantId;
    string freightOrderId;
    string tenderNumber;
    string status;
    string offeredRate;
    string currency;
    string responseBy;
    string awardedCarrierId;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct MilestoneUpdateDTO {
    string id;
    string tenantId;
    string freightOrderId;
    string milestoneType;
    string eventTime;
    string location;
    string statusComment;
    string reportedBy;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
