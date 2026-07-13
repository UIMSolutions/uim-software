module uim.platform.verinice.application.usecases.manage.assets;

import uim.platform.verinice;

@safe:

class ManageAssetsUseCase : UIMUseCase {
    private AssetRepository repo;

    this(AssetRepository repo) {
        this.repo = repo;
    }

    Asset[] list() {
        return repo.findAll();
    }

    Asset* get_(AssetId id) {
        return repo.findById(id);
    }

    CommandResult create(AssetDTO dto) {
        Asset value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.name = dto.name;
        value.description = dto.description;
        value.assetType = dto.assetType;
        value.confidentiality = dto.confidentiality;
        value.integrity = dto.integrity;
        value.availability = dto.availability;
        value.owner = dto.owner;
        value.createdBy = dto.createdBy;
        if (!VeriniceValidator.isValidAsset(value)) {
            return CommandResult(false, "", "Invalid asset data");
        }
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(AssetDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "Asset not found");
        }
        if (dto.name.length) existing.name = dto.name;
        if (dto.description.length) existing.description = dto.description;
        if (dto.assetType.length) existing.assetType = dto.assetType;
        if (dto.confidentiality.length) existing.confidentiality = dto.confidentiality;
        if (dto.integrity.length) existing.integrity = dto.integrity;
        if (dto.availability.length) existing.availability = dto.availability;
        if (dto.owner.length) existing.owner = dto.owner;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(AssetId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "Asset not found");
        }
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
