/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.entities.security_event;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

struct SecurityEvent {
    SecurityEventId id;
    TenantId tenantId;
    string name;
    string description;
    EventSource source = EventSource.syslog;
    EventSeverity severity = EventSeverity.informational;
    EventStatus status = EventStatus.new_;
    string sourceIp;
    string destinationIp;
    string sourcePort;
    string destinationPort;
    string protocol;
    string username;
    string hostname;
    string rawLog;
    string eventType;
    string category;
    string action;
    string outcome;
    string assetId;
    string correlationRuleId;
    string alertId;
    string timestamp;
    string receivedAt;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
