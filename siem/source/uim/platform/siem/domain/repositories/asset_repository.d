/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.repositories.asset_repository;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

interface AssetRepository {
    Asset[] findAll();
    Asset* findById(AssetId id);
    Asset[] findByTenant(TenantId tenantId);
    Asset[] findByType(AssetType assetType);
    Asset[] findByCriticality(AssetCriticality criticality);
    void save(Asset asset);
    void update(Asset asset);
    void remove(AssetId id);
}
