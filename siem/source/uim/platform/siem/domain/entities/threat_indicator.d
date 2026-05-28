/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.entities.threat_indicator;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

struct ThreatIndicator {
    ThreatIndicatorId id;
    TenantId tenantId;
    string name;
    string description;
    ThreatIndicatorType indicatorType = ThreatIndicatorType.ip;
    ThreatIndicatorConfidence confidence = ThreatIndicatorConfidence.medium;
    string value;
    string threatActor;
    string malwareFamily;
    string campaign;
    string tlpLevel;
    string source;
    string tags;
    string expiresAt;
    string firstSeenAt;
    string lastSeenAt;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
