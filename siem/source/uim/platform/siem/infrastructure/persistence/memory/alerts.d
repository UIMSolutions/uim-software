/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.infrastructure.persistence.memory.alerts;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class MemoryAlertRepository : AlertRepository {
    private Alert[] store;

    Alert[] findAll() { return store; }

    Alert* findById(AlertId id) {
        foreach (ref a; store)
            if (a.id == id) return &a;
        return null;
    }

    Alert[] findByTenant(TenantId tenantId) {
        Alert[] result;
        foreach (ref a; store)
            if (a.tenantId == tenantId) result ~= a;
        return result;
    }

    Alert[] findBySeverity(AlertSeverity severity) {
        Alert[] result;
        foreach (ref a; store)
            if (a.severity == severity) result ~= a;
        return result;
    }

    Alert[] findByStatus(AlertStatus status) {
        Alert[] result;
        foreach (ref a; store)
            if (a.status == status) result ~= a;
        return result;
    }

    Alert[] findByCorrelationRule(CorrelationRuleId ruleId) {
        Alert[] result;
        foreach (ref a; store)
            if (a.correlationRuleId == ruleId) result ~= a;
        return result;
    }

    void save(Alert alert) { store ~= alert; }

    void update(Alert alert) {
        foreach (ref a; store)
            if (a.id == alert.id) { a = alert; return; }
    }

    void remove(AlertId id) {
        import std.algorithm : remove;
        store = store.remove!(a => a.id == id);
    }
}
