/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.persistence.repositories.monitoring_events;

import uim.platform.itil;
import std.algorithm : filter;
import std.array : array;

mixin(ShowModule!());

@safe:

class MemoryMonitoringEventRepository : MonitoringEventRepository {
    private MonitoringEvent[] store;

    MonitoringEvent[] findAll() { return store.dup; }

    MonitoringEvent* findById(MonitoringEventId id) {
        foreach (ref s; store) if (s.id == id) return &s;
        return null;
    }

    MonitoringEvent[] findByTenant(TenantId tenantId) {
        return store.filter!(s => s.tenantId == tenantId).array;
    }

    MonitoringEvent[] findByStatus(EventStatus eventStatus) {
        return store.filter!(s => s.eventStatus == eventStatus).array;
    }

    MonitoringEvent[] findBySeverity(EventSeverity severity) {
        return store.filter!(s => s.severity == severity).array;
    }

    MonitoringEvent[] findByService(ITServiceId serviceId) {
        return store.filter!(s => s.affectedServiceId == serviceId).array;
    }

    MonitoringEvent[] findByCI(ConfigurationItemId ciId) {
        return store.filter!(s => s.sourceCI == ciId).array;
    }

    void save(MonitoringEvent s) { store ~= s; }

    void update(MonitoringEvent s) {
        foreach (ref item; store) {
            if (item.id == s.id) { item = s; return; }
        }
    }

    void remove(MonitoringEventId id) {
        store = store.filter!(s => s.id != id).array;
    }
}
