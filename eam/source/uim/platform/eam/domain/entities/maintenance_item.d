/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.entities.maintenance_item;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

struct MaintenanceItem {
    MaintenanceItemId id;
    TenantId tenantId;
    string name;
    string description;
    MaintenancePlanId maintenancePlanId;
    EquipmentId equipmentId;
    FunctionalLocationId functionalLocationId;
    string taskListId;
    string taskListDescription;
    WorkCenterId workCenterId;
    string orderType;
    string cycle;
    string cycleUnit;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
