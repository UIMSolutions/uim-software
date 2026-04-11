/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.entities.tracking_event;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

struct TrackingEvent {
    TrackingEventId id;
    TenantId tenantId;
    string name;
    string description;
    EventType eventType = EventType.statusChange;
    EventStatus status = EventStatus.created;
    string trackedObjectId;
    string trackedObjectType;
    string locationId;
    string latitude;
    string longitude;
    string eventTimestamp;
    string reportedBy;
    string sensorData;
    string milestone;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
