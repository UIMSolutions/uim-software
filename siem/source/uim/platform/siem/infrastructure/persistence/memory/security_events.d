/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.infrastructure.persistence.repositories.security_events;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class MemorySecurityEventRepository : SecurityEventRepository {
    private SecurityEvent[] store;

    SecurityEvent[] findAll() { return store; }

    SecurityEvent* findById(SecurityEventId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    SecurityEvent[] findByTenant(TenantId tenantId) {
        SecurityEvent[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    SecurityEvent[] findBySeverity(EventSeverity severity) {
        SecurityEvent[] result;
        foreach (ref e; store)
            if (e.severity == severity) result ~= e;
        return result;
    }

    SecurityEvent[] findByStatus(EventStatus status) {
        SecurityEvent[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    SecurityEvent[] findByAsset(AssetId assetId) {
        SecurityEvent[] result;
        foreach (ref e; store)
            if (e.assetId == assetId) result ~= e;
        return result;
    }

    void save(SecurityEvent event) { store ~= event; }

    void update(SecurityEvent event) {
        foreach (ref e; store)
            if (e.id == event.id) { e = event; return; }
    }

    void remove(SecurityEventId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
