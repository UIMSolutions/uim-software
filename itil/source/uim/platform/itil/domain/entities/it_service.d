/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.entities.it_service;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct ITService {
    ITServiceId id;
    TenantId tenantId;
    string name;
    string description;
    RecordStatus status = RecordStatus.open;
    string serviceOwner;
    string serviceManager;
    string supportTeam;
    string serviceLevel;
    string category;
    string[] dependentServiceIds;
    string[] relatedCIIds;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
