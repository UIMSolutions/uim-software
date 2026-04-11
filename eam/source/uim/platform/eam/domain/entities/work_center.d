/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.entities.work_center;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

struct WorkCenter {
    WorkCenterId id;
    TenantId tenantId;
    string name;
    string description;
    WorkCenterCategory category = WorkCenterCategory.workshop;
    string plantSection;
    string costCenter;
    string capacity;
    string capacityUnit;
    string responsiblePerson;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
