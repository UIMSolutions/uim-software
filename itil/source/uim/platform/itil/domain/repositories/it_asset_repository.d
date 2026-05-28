/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.repositories.it_asset_repository;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

interface ITAssetRepository {
    ITAsset[] findAll();
    ITAsset* findById(ITAssetId id);
    ITAsset[] findByTenant(TenantId tenantId);
    ITAsset[] findByStatus(AssetStatus assetStatus);
    ITAsset[] findByType(AssetType assetType);
    ITAsset[] findByAssignee(string assignedTo);
    void save(ITAsset asset);
    void update(ITAsset asset);
    void remove(ITAssetId id);
}
