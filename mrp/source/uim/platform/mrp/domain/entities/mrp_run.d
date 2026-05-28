/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.mrp.domain.entities.mrp_run;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

struct MrpRun {
    MrpRunId id;
    TenantId tenantId;
    PlantId plantId;
    string name;
    string description;
    RunMode mode = RunMode.regenerative;
    RunStatus status = RunStatus.planned;
    string planningDate;
    string horizonDays;
    string includeExternalRequirements;
    string includeDependentRequirements;
    string includeSafetyStock;
    string generatedProposalCount;
    UserId executedBy;
    string executedAt;
    string createdAt;
    string modifiedAt;
}
