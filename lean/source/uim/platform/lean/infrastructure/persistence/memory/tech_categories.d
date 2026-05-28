/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.persistence.memory.tech_categories;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class MemoryTechCategoryRepository : TechCategoryRepository {
    private TechCategory[] store;

    TechCategory[] findAll() { return store; }

    TechCategory* findById(TechCategoryId id) {
        foreach (ref tc; store) if (tc.id == id) return &tc;
        return null;
    }

    TechCategory[] findByTenant(TenantId tenantId) {
        TechCategory[] result;
        foreach (ref tc; store) if (tc.tenantId == tenantId) result ~= tc;
        return result;
    }

    TechCategory[] findByStatus(FactSheetStatus status) {
        TechCategory[] result;
        foreach (ref tc; store) if (tc.status == status) result ~= tc;
        return result;
    }

    TechCategory[] findByParent(TechCategoryId parentId) {
        TechCategory[] result;
        foreach (ref tc; store) if (tc.parentCategoryId == parentId) result ~= tc;
        return result;
    }

    void save(TechCategory category) { store ~= category; }

    void update(TechCategory category) {
        foreach (ref tc; store) if (tc.id == category.id) { tc = category; return; }
    }

    void remove(TechCategoryId id) {
        import std.algorithm : remove;
        store = store.remove!(tc => tc.id == id);
    }
}
