module uim.platform.verinice.domain.repositories.asset_repository;

import uim.platform.verinice.domain.entities.asset;
import uim.platform.verinice.domain.types;

@safe:

interface AssetRepository {
    Asset[] findAll();
    Asset* findById(AssetId id);
    void save(Asset value);
    void update(Asset value);
    void remove(AssetId id);
}
