/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.entities.material_bom;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

struct MaterialBOM {
    MaterialBOMId id;
    TenantId tenantId;
    string name;
    string description;
    EquipmentId equipmentId;
    string materialNumber;
    string materialDescription;
    string quantity;
    string unit;
    string storageLocation;
    string supplier;
    string unitPrice;
    string currency;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
