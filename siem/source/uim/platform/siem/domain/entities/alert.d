/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.entities.alert;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

struct Alert {
    AlertId id;
    TenantId tenantId;
    string name;
    string description;
    AlertSeverity severity = AlertSeverity.medium;
    AlertStatus status = AlertStatus.open;
    string correlationRuleId;
    string ruleName;
    string sourceEventIds;
    string affectedAssetId;
    string sourceIp;
    string destinationIp;
    string username;
    string mitreTactic;
    string mitreTechnique;
    string assignedTo;
    string resolvedBy;
    string resolutionNote;
    string firstSeenAt;
    string lastSeenAt;
    string resolvedAt;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
