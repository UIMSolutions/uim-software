/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.entities.monitoring_event;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct MonitoringEvent {
    MonitoringEventId id;
    TenantId tenantId;
    string title;
    string description;
    EventSeverity severity = EventSeverity.informational;
    EventStatus eventStatus = EventStatus.open;
    ConfigurationItemId sourceCI;
    ITServiceId affectedServiceId;
    string detectedAt;
    string acknowledgedAt;
    string resolvedAt;
    string acknowledgedBy;
    IncidentId linkedIncidentId;
    string eventCode;
    string eventSource;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
