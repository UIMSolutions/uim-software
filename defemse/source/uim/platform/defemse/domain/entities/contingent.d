module uim.platform.defemse.domain.entities.contingent;

import uim.platform.defemse.domain.types;

@safe:

struct Contingent {
    ContingentId id;
    TenantId tenantId;
    string code;
    string name;
    string unitType;
    string personnelStrength;
    string equipmentCount;
    ContingentStatus status = ContingentStatus.available;
    ReadinessStatus readinessStatus = ReadinessStatus.medium;
    string currentLocationId;
    string destinationLocationId;
    string transportMode;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}