/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.infrastructure.persistence.memory.tracking_events;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class MemoryTrackingEventRepository : TrackingEventRepository {
    private TrackingEvent[] store;

    TrackingEvent[] findAll() { return store; }

    TrackingEvent* findById(TrackingEventId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    TrackingEvent[] findByTenant(TenantId tenantId) {
        TrackingEvent[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    TrackingEvent[] findByTrackedObject(string trackedObjectId) {
        TrackingEvent[] result;
        foreach (ref e; store)
            if (e.trackedObjectId == trackedObjectId) result ~= e;
        return result;
    }

    TrackingEvent[] findByEventType(EventType eventType) {
        TrackingEvent[] result;
        foreach (ref e; store)
            if (e.eventType == eventType) result ~= e;
        return result;
    }

    void save(TrackingEvent event) { store ~= event; }

    void update(TrackingEvent event) {
        foreach (ref e; store)
            if (e.id == event.id) { e = event; return; }
    }

    void remove(TrackingEventId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
