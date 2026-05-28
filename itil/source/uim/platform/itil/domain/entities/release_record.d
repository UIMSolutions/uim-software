/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.entities.release_record;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct ReleaseRecord {
    ReleaseRecordId id;
    TenantId tenantId;
    string name;
    string description;
    ReleaseType releaseType = ReleaseType.minor;
    ReleaseStatus releaseStatus = ReleaseStatus.planned;
    string version_;
    string targetDate;
    string actualDate;
    string deployedBy;
    string[] affectedServiceIds;
    string[] affectedCIIds;
    string[] linkedChangeIds;
    string testPlan;
    string deploymentPlan;
    string backoutPlan;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
