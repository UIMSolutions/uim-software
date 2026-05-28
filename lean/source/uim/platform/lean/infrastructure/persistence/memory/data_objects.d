/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.persistence.memory.data_objects;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class MemoryDataObjectRepository : DataObjectRepository {
    private DataObject[] store;

    DataObject[] findAll() { return store; }

    DataObject* findById(DataObjectId id) {
        foreach (ref d; store) if (d.id == id) return &d;
        return null;
    }

    DataObject[] findByTenant(TenantId tenantId) {
        DataObject[] result;
        foreach (ref d; store) if (d.tenantId == tenantId) result ~= d;
        return result;
    }

    DataObject[] findByStatus(FactSheetStatus status) {
        DataObject[] result;
        foreach (ref d; store) if (d.status == status) result ~= d;
        return result;
    }

    DataObject[] findByClassification(DataClassification classification) {
        DataObject[] result;
        foreach (ref d; store) if (d.classification == classification) result ~= d;
        return result;
    }

    DataObject[] findByApplication(LeanApplicationId appId) {
        DataObject[] result;
        foreach (ref d; store) if (d.owningApplicationId == appId) result ~= d;
        return result;
    }

    void save(DataObject dataObject) { store ~= dataObject; }

    void update(DataObject dataObject) {
        foreach (ref d; store) if (d.id == dataObject.id) { d = dataObject; return; }
    }

    void remove(DataObjectId id) {
        import std.algorithm : remove;
        store = store.remove!(d => d.id == id);
    }
}
