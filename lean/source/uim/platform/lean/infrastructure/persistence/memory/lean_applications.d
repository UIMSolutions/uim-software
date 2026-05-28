/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.persistence.memory.lean_applications;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class MemoryLeanApplicationRepository : LeanApplicationRepository {
    private LeanApplication[] store;

    LeanApplication[] findAll() { return store; }

    LeanApplication* findById(LeanApplicationId id) {
        foreach (ref a; store) if (a.id == id) return &a;
        return null;
    }

    LeanApplication[] findByTenant(TenantId tenantId) {
        LeanApplication[] result;
        foreach (ref a; store) if (a.tenantId == tenantId) result ~= a;
        return result;
    }

    LeanApplication[] findByStatus(FactSheetStatus status) {
        LeanApplication[] result;
        foreach (ref a; store) if (a.status == status) result ~= a;
        return result;
    }

    LeanApplication[] findByLifecycleStatus(ApplicationLifecycleStatus lifecycleStatus) {
        LeanApplication[] result;
        foreach (ref a; store) if (a.lifecycleStatus == lifecycleStatus) result ~= a;
        return result;
    }

    LeanApplication[] findByType(ApplicationType applicationType) {
        LeanApplication[] result;
        foreach (ref a; store) if (a.applicationType == applicationType) result ~= a;
        return result;
    }

    LeanApplication[] findByOrganization(OrganizationId orgId) {
        LeanApplication[] result;
        foreach (ref a; store) if (a.owningOrgId == orgId) result ~= a;
        return result;
    }

    void save(LeanApplication app) { store ~= app; }

    void update(LeanApplication app) {
        foreach (ref a; store) if (a.id == app.id) { a = app; return; }
    }

    void remove(LeanApplicationId id) {
        import std.algorithm : remove;
        store = store.remove!(a => a.id == id);
    }
}
