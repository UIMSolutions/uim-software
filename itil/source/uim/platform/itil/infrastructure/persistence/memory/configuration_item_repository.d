/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.persistence.memory.memory_configuration_item_repository;

import uim.platform.itil;
import std.algorithm : filter;
import std.array : array;

mixin(ShowModule!());

@safe:

class MemoryConfigurationItemRepository : ConfigurationItemRepository {
    private ConfigurationItem[] store;

    ConfigurationItem[] findAll() { return store.dup; }

    ConfigurationItem* findById(ConfigurationItemId id) {
        foreach (ref s; store) if (s.id == id) return &s;
        return null;
    }

    ConfigurationItem[] findByTenant(TenantId tenantId) {
        return store.filter!(s => s.tenantId == tenantId).array;
    }

    ConfigurationItem[] findByStatus(CIStatus ciStatus) {
        return store.filter!(s => s.ciStatus == ciStatus).array;
    }

    ConfigurationItem[] findByType(CIType ciType) {
        return store.filter!(s => s.ciType == ciType).array;
    }

    ConfigurationItem[] findByOwner(string ownerId) {
        return store.filter!(s => s.ownerId == ownerId).array;
    }

    void save(ConfigurationItem s) { store ~= s; }

    void update(ConfigurationItem s) {
        foreach (ref item; store) {
            if (item.id == s.id) { item = s; return; }
        }
    }

    void remove(ConfigurationItemId id) {
        store = store.filter!(s => s.id != id).array;
    }
}
