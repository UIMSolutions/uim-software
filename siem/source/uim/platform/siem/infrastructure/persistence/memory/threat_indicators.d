/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.infrastructure.persistence.memory.threat_indicators;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class MemoryThreatIndicatorRepository : ThreatIndicatorRepository {
    private ThreatIndicator[] store;

    ThreatIndicator[] findAll() { return store; }

    ThreatIndicator* findById(ThreatIndicatorId id) {
        foreach (ref t; store)
            if (t.id == id) return &t;
        return null;
    }

    ThreatIndicator[] findByTenant(TenantId tenantId) {
        ThreatIndicator[] result;
        foreach (ref t; store)
            if (t.tenantId == tenantId) result ~= t;
        return result;
    }

    ThreatIndicator[] findByType(ThreatIndicatorType indicatorType) {
        ThreatIndicator[] result;
        foreach (ref t; store)
            if (t.indicatorType == indicatorType) result ~= t;
        return result;
    }

    ThreatIndicator[] findByConfidence(ThreatIndicatorConfidence confidence) {
        ThreatIndicator[] result;
        foreach (ref t; store)
            if (t.confidence == confidence) result ~= t;
        return result;
    }

    void save(ThreatIndicator indicator) { store ~= indicator; }

    void update(ThreatIndicator indicator) {
        foreach (ref t; store)
            if (t.id == indicator.id) { t = indicator; return; }
    }

    void remove(ThreatIndicatorId id) {
        import std.algorithm : remove;
        store = store.remove!(t => t.id == id);
    }
}
