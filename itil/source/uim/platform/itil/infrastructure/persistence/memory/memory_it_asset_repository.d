/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.persistence.memory.memory_it_asset_repository;

import uim.platform.itil;
import std.algorithm : filter;
import std.array : array;

mixin(ShowModule!());

@safe:

class MemoryITAssetRepository : ITAssetRepository {
    private ITAsset[] store;

    ITAsset[] findAll() { return store.dup; }

    ITAsset* findById(ITAssetId id) {
        foreach (ref s; store) if (s.id == id) return &s;
        return null;
    }

    ITAsset[] findByTenant(TenantId tenantId) {
        return store.filter!(s => s.tenantId == tenantId).array;
    }

    ITAsset[] findByStatus(AssetStatus assetStatus) {
        return store.filter!(s => s.assetStatus == assetStatus).array;
    }

    ITAsset[] findByType(AssetType assetType) {
        return store.filter!(s => s.assetType == assetType).array;
    }

    ITAsset[] findByAssignee(string assignedTo) {
        return store.filter!(s => s.assignedTo == assignedTo).array;
    }

    void save(ITAsset s) { store ~= s; }

    void update(ITAsset s) {
        foreach (ref item; store) {
            if (item.id == s.id) { item = s; return; }
        }
    }

    void remove(ITAssetId id) {
        store = store.filter!(s => s.id != id).array;
    }
}
