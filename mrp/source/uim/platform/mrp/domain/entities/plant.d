/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.mrp.domain.entities.plant;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

struct Plant {
    PlantId id;
    TenantId tenantId;
    string name;
    string description;
    string plantCode;
    PlanningScope planningScope = PlanningScope.plant;
    string mrpAreas;
    string companyCode;
    string country;
    string timezone;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
