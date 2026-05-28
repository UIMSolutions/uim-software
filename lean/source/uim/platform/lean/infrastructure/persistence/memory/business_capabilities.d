/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.persistence.memory.business_capabilities;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class MemoryBusinessCapabilityRepository : BusinessCapabilityRepository {
    private BusinessCapability[] store;

    BusinessCapability[] findAll() { return store; }

    BusinessCapability* findById(BusinessCapabilityId id) {
        foreach (ref bc; store) if (bc.id == id) return &bc;
        return null;
    }

    BusinessCapability[] findByTenant(TenantId tenantId) {
        BusinessCapability[] result;
        foreach (ref bc; store) if (bc.tenantId == tenantId) result ~= bc;
        return result;
    }

    BusinessCapability[] findByStatus(FactSheetStatus status) {
        BusinessCapability[] result;
        foreach (ref bc; store) if (bc.status == status) result ~= bc;
        return result;
    }

    BusinessCapability[] findByParent(BusinessCapabilityId parentId) {
        BusinessCapability[] result;
        foreach (ref bc; store) if (bc.parentCapabilityId == parentId) result ~= bc;
        return result;
    }

    BusinessCapability[] findByOrganization(OrganizationId orgId) {
        BusinessCapability[] result;
        foreach (ref bc; store) if (bc.owningOrgId == orgId) result ~= bc;
        return result;
    }

    void save(BusinessCapability capability) { store ~= capability; }

    void update(BusinessCapability capability) {
        foreach (ref bc; store) if (bc.id == capability.id) { bc = capability; return; }
    }

    void remove(BusinessCapabilityId id) {
        import std.algorithm : remove;
        store = store.remove!(bc => bc.id == id);
    }
}
