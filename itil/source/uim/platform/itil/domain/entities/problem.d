/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.entities.problem;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct Problem {
    ProblemId id;
    TenantId tenantId;
    string title;
    string description;
    ProblemStatus problemStatus = ProblemStatus.identified;
    Priority priority = Priority.medium;
    IncidentCategory category = IncidentCategory.other;
    string rootCause;
    string workaround;
    string solution;
    ITServiceId affectedServiceId;
    string[] linkedIncidentIds;
    string assignedTo;
    string assignedTeam;
    string identifiedAt;
    string resolvedAt;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
