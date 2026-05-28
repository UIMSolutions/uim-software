/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.infrastructure.persistence.memory.correlation_rules;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class MemoryCorrelationRuleRepository : CorrelationRuleRepository {
    private CorrelationRule[] store;

    CorrelationRule[] findAll() { return store; }

    CorrelationRule* findById(CorrelationRuleId id) {
        foreach (ref r; store)
            if (r.id == id) return &r;
        return null;
    }

    CorrelationRule[] findByTenant(TenantId tenantId) {
        CorrelationRule[] result;
        foreach (ref r; store)
            if (r.tenantId == tenantId) result ~= r;
        return result;
    }

    CorrelationRule[] findByStatus(RuleStatus status) {
        CorrelationRule[] result;
        foreach (ref r; store)
            if (r.status == status) result ~= r;
        return result;
    }

    CorrelationRule[] findByType(RuleType ruleType) {
        CorrelationRule[] result;
        foreach (ref r; store)
            if (r.ruleType == ruleType) result ~= r;
        return result;
    }

    void save(CorrelationRule rule) { store ~= rule; }

    void update(CorrelationRule rule) {
        foreach (ref r; store)
            if (r.id == rule.id) { r = rule; return; }
    }

    void remove(CorrelationRuleId id) {
        import std.algorithm : remove;
        store = store.remove!(r => r.id == id);
    }
}
