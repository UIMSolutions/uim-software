/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.entities.equipment;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

struct Equipment {
    EquipmentId id;
    TenantId tenantId;
    string name;
    string description;
    string equipmentNumber;
    EquipmentCategory category = EquipmentCategory.machine;
    EquipmentStatus status = EquipmentStatus.active;
    FunctionalLocationId functionalLocationId;
    string manufacturer;
    string modelNumber;
    string serialNumber;
    string installationDate;
    string warrantyEndDate;
    string acquisitionValue;
    string currency;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
