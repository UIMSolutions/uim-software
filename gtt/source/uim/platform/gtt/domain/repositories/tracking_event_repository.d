/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.repositories.tracking_event_repository;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

interface TrackingEventRepository {
    TrackingEvent[] findAll();
    TrackingEvent* findById(TrackingEventId id);
    TrackingEvent[] findByTenant(TenantId tenantId);
    TrackingEvent[] findByTrackedObject(string trackedObjectId);
    TrackingEvent[] findByEventType(EventType eventType);
    void save(TrackingEvent event);
    void update(TrackingEvent event);
    void remove(TrackingEventId id);
}
