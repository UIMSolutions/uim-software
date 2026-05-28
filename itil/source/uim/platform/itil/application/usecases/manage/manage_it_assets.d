/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.usecases.manage.manage_it_assets;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

class ManageITAssetsUseCase : UIMUseCase {
    private ITAssetRepository repo;

    this(ITAssetRepository repo) { this.repo = repo; }

    ITAsset* get_(ITAssetId id) { return repo.findById(id); }
    ITAsset[] list() { return repo.findAll(); }
    ITAsset[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    ITAsset[] listByStatus(AssetStatus status) { return repo.findByStatus(status); }
    ITAsset[] listByType(AssetType assetType) { return repo.findByType(assetType); }
    ITAsset[] listByAssignee(string assignedTo) { return repo.findByAssignee(assignedTo); }

    CommandResult create(ITAssetDTO dto) {
        ITAsset a;
        a.id = dto.id;
        a.tenantId = dto.tenantId;
        a.name = dto.name;
        a.description = dto.description;
        a.serialNumber = dto.serialNumber;
        a.manufacturer = dto.manufacturer;
        a.model = dto.model;
        a.purchaseDate = dto.purchaseDate;
        a.warrantyExpiry = dto.warrantyExpiry;
        a.annualCostUsd = dto.annualCostUsd;
        a.location = dto.location;
        a.assignedTo = dto.assignedTo;
        a.linkedCIId = dto.linkedCIId;
        a.createdBy = dto.createdBy;
        if (!ITILValidator.isValidITAsset(a))
            return CommandResult(false, "", "Invalid IT asset data");
        repo.save(a);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ITAssetDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "IT asset not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.location.length > 0) existing.location = dto.location;
        if (dto.assignedTo.length > 0) existing.assignedTo = dto.assignedTo;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ITAssetId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "IT asset not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
