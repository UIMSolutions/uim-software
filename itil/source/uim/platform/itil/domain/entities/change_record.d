/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.entities.change_record;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct ChangeRecord {
    ChangeRecordId id;
    TenantId tenantId;
    string title;
    string description;
    ChangeType changeType = ChangeType.normal;
    ChangeStatus changeStatus = ChangeStatus.draft;
    ChangeRisk risk = ChangeRisk.medium;
    Priority priority = Priority.medium;
    string requestedBy;
    string assignedTo;
    string[] approvers;
    string[] affectedServiceIds;
    string[] affectedCIIds;
    string scheduledStartDate;
    string scheduledEndDate;
    string actualStartDate;
    string actualEndDate;
    string implementationNotes;
    string backoutPlan;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
