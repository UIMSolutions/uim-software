/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.entities.functional_location;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

struct FunctionalLocation {
    FunctionalLocationId id;
    TenantId tenantId;
    string name;
    string description;
    string locationLabel;
    FunctionalLocationType locationType = FunctionalLocationType.plant;
    FunctionalLocationStatus status = FunctionalLocationStatus.active;
    FunctionalLocationId parentLocationId;
    string plantSection;
    string costCenter;
    string address;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
