/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.infrastructure.persistence.repositories.assets;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class MemoryAssetRepository : AssetRepository {
    private Asset[] store;

    Asset[] findAll() { return store; }

    Asset* findById(AssetId id) {
        foreach (ref a; store)
            if (a.id == id) return &a;
        return null;
    }

    Asset[] findByTenant(TenantId tenantId) {
        Asset[] result;
        foreach (ref a; store)
            if (a.tenantId == tenantId) result ~= a;
        return result;
    }

    Asset[] findByType(AssetType assetType) {
        Asset[] result;
        foreach (ref a; store)
            if (a.assetType == assetType) result ~= a;
        return result;
    }

    Asset[] findByCriticality(AssetCriticality criticality) {
        Asset[] result;
        foreach (ref a; store)
            if (a.criticality == criticality) result ~= a;
        return result;
    }

    void save(Asset asset) { store ~= asset; }

    void update(Asset asset) {
        foreach (ref a; store)
            if (a.id == asset.id) { a = asset; return; }
    }

    void remove(AssetId id) {
        import std.algorithm : remove;
        store = store.remove!(a => a.id == id);
    }
}
