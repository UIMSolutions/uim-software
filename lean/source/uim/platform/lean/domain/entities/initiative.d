/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.entities.initiative;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

struct Initiative {
    InitiativeId id;
    TenantId tenantId;
    string name;
    string description;
    FactSheetStatus status = FactSheetStatus.draft;
    InitiativeStatus initiativeStatus = InitiativeStatus.planned;
    InitiativePhase phase = InitiativePhase.discover;
    string budgetUsd;
    string startDate;
    string endDate;
    string responsiblePerson;
    OrganizationId responsibleOrgId;
    string[] objectiveIds;
    string[] affectedApplicationIds;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
