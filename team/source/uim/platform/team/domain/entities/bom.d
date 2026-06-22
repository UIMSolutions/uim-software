module uim.platform.team.domain.entities.bom;

import uim.platform.team.domain.types;

@safe:

struct BomLine {
    PartId childPartId;
    long quantity;
    string unitOfMeasure;
    string findNumber;
    string effectivity;
}

struct Bom {
    BomId id;
    TenantId tenantId;
    PartId parentPartId;
    string name;
    string revision;
    BomLine[] lines;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
