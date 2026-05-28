/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.application.usecases.manage.manage_assets;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class ManageAssetsUseCase : UIMUseCase {
    private AssetRepository repo;

    this(AssetRepository repo) {
        this.repo = repo;
    }

    Asset* get_(AssetId id) {
        return repo.findById(id);
    }

    Asset[] list() {
        return repo.findAll();
    }

    Asset[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    Asset[] listByType(AssetType assetType) {
        return repo.findByType(assetType);
    }

    Asset[] listByCriticality(AssetCriticality criticality) {
        return repo.findByCriticality(criticality);
    }

    CommandResult create(AssetDTO dto) {
        Asset a;
        a.id = dto.id;
        a.tenantId = dto.tenantId;
        a.name = dto.name;
        a.description = dto.description;
        a.ipAddress = dto.ipAddress;
        a.macAddress = dto.macAddress;
        a.hostname = dto.hostname;
        a.operatingSystem = dto.operatingSystem;
        a.osVersion = dto.osVersion;
        a.owner = dto.owner;
        a.department = dto.department;
        a.location = dto.location;
        a.tags = dto.tags;
        a.lastSeenAt = dto.lastSeenAt;
        a.firstRegisteredAt = dto.firstRegisteredAt;
        a.createdBy = dto.createdBy;
        if (!SiemValidator.isValidAsset(a))
            return CommandResult(false, "", "Invalid asset data");
        repo.save(a);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(AssetDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Asset not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.ipAddress.length > 0) existing.ipAddress = dto.ipAddress;
        if (dto.operatingSystem.length > 0) existing.operatingSystem = dto.operatingSystem;
        if (dto.osVersion.length > 0) existing.osVersion = dto.osVersion;
        if (dto.owner.length > 0) existing.owner = dto.owner;
        if (dto.lastSeenAt.length > 0) existing.lastSeenAt = dto.lastSeenAt;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(AssetId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Asset not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
