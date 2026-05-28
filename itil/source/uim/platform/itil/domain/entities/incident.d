/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.entities.incident;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct Incident {
    IncidentId id;
    TenantId tenantId;
    string title;
    string description;
    RecordStatus status = RecordStatus.open;
    Priority priority = Priority.medium;
    IncidentCategory category = IncidentCategory.other;
    string reportedById;
    string assignedTo;
    string assignedTeam;
    ITServiceId affectedServiceId;
    ConfigurationItemId affectedCIId;
    ProblemId linkedProblemId;
    string reportedAt;
    string resolvedAt;
    string closedAt;
    string resolutionNotes;
    bool escalated = false;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
