/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.persistence.repositories.organizations;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class MemoryOrganizationRepository : OrganizationRepository {
    private Organization[] store;

    Organization[] findAll() { return store; }

    Organization* findById(OrganizationId id) {
        foreach (ref o; store) if (o.id == id) return &o;
        return null;
    }

    Organization[] findByTenant(TenantId tenantId) {
        Organization[] result;
        foreach (ref o; store) if (o.tenantId == tenantId) result ~= o;
        return result;
    }

    Organization[] findByStatus(FactSheetStatus status) {
        Organization[] result;
        foreach (ref o; store) if (o.status == status) result ~= o;
        return result;
    }

    Organization[] findByParent(OrganizationId parentOrgId) {
        Organization[] result;
        foreach (ref o; store) if (o.parentOrgId == parentOrgId) result ~= o;
        return result;
    }

    void save(Organization organization) { store ~= organization; }

    void update(Organization organization) {
        foreach (ref o; store) if (o.id == organization.id) { o = organization; return; }
    }

    void remove(OrganizationId id) {
        import std.algorithm : remove;
        store = store.remove!(o => o.id == id);
    }
}
