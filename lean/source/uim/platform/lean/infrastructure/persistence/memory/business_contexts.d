/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.persistence.memory.business_contexts;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class MemoryBusinessContextRepository : BusinessContextRepository {
    private BusinessContext[] store;

    BusinessContext[] findAll() { return store; }

    BusinessContext* findById(BusinessContextId id) {
        foreach (ref bc; store) if (bc.id == id) return &bc;
        return null;
    }

    BusinessContext[] findByTenant(TenantId tenantId) {
        BusinessContext[] result;
        foreach (ref bc; store) if (bc.tenantId == tenantId) result ~= bc;
        return result;
    }

    BusinessContext[] findByStatus(FactSheetStatus status) {
        BusinessContext[] result;
        foreach (ref bc; store) if (bc.status == status) result ~= bc;
        return result;
    }

    BusinessContext[] findByCapability(BusinessCapabilityId capabilityId) {
        BusinessContext[] result;
        foreach (ref bc; store) if (bc.capabilityId == capabilityId) result ~= bc;
        return result;
    }

    void save(BusinessContext context) { store ~= context; }

    void update(BusinessContext context) {
        foreach (ref bc; store) if (bc.id == context.id) { bc = context; return; }
    }

    void remove(BusinessContextId id) {
        import std.algorithm : remove;
        store = store.remove!(bc => bc.id == id);
    }
}
