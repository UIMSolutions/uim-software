/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.persistence.repositories.app_interfaces;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class MemoryAppInterfaceRepository : AppInterfaceRepository {
    private AppInterface[] store;

    AppInterface[] findAll() { return store; }

    AppInterface* findById(AppInterfaceId id) {
        foreach (ref ai; store) if (ai.id == id) return &ai;
        return null;
    }

    AppInterface[] findByTenant(TenantId tenantId) {
        AppInterface[] result;
        foreach (ref ai; store) if (ai.tenantId == tenantId) result ~= ai;
        return result;
    }

    AppInterface[] findByStatus(FactSheetStatus status) {
        AppInterface[] result;
        foreach (ref ai; store) if (ai.status == status) result ~= ai;
        return result;
    }

    AppInterface[] findBySourceApplication(LeanApplicationId appId) {
        AppInterface[] result;
        foreach (ref ai; store) if (ai.sourceApplicationId == appId) result ~= ai;
        return result;
    }

    AppInterface[] findByTargetApplication(LeanApplicationId appId) {
        AppInterface[] result;
        foreach (ref ai; store) if (ai.targetApplicationId == appId) result ~= ai;
        return result;
    }

    void save(AppInterface appInterface) { store ~= appInterface; }

    void update(AppInterface appInterface) {
        foreach (ref ai; store) if (ai.id == appInterface.id) { ai = appInterface; return; }
    }

    void remove(AppInterfaceId id) {
        import std.algorithm : remove;
        store = store.remove!(ai => ai.id == id);
    }
}
