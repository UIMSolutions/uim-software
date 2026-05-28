/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.entities.objective;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

struct Objective {
    ObjectiveId id;
    TenantId tenantId;
    string name;
    string description;
    FactSheetStatus status = FactSheetStatus.draft;
    ObjectiveType objectiveType = ObjectiveType.strategic;
    string targetDate;
    string owner;
    OrganizationId owningOrgId;
    string[] relatedInitiativeIds;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
