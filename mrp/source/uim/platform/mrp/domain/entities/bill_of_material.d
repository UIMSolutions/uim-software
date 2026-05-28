/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.mrp.domain.entities.bill_of_material;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

struct BillOfMaterial {
    BillOfMaterialId id;
    TenantId tenantId;
    PlantId plantId;
    string name;
    string description;
    MaterialId parentMaterialId;
    MaterialId componentMaterialId;
    string componentQuantity;
    string baseQuantity;
    string scrapPercent;
    string validFrom;
    string validTo;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
