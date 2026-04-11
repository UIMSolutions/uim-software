/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.entities.location;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

struct Location {
    LocationId id;
    TenantId tenantId;
    string name;
    string description;
    LocationType locationType = LocationType.warehouse;
    string address;
    string city;
    string country;
    string postalCode;
    string latitude;
    string longitude;
    string timezone;
    string sourceSystem;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
