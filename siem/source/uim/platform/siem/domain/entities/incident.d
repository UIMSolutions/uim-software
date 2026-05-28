/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.entities.incident;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

struct Incident {
    IncidentId id;
    TenantId tenantId;
    string name;
    string description;
    IncidentSeverity severity = IncidentSeverity.medium;
    IncidentStatus status = IncidentStatus.open;
    string alertIds;
    string affectedAssetIds;
    string leadAnalyst;
    string respondents;
    string attackVector;
    string mitreTactics;
    string mitreTechniques;
    string containmentActions;
    string eradicationActions;
    string recoveryActions;
    string lessonsLearned;
    string detectedAt;
    string containedAt;
    string resolvedAt;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
