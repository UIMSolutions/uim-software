module uim.platform.verinice.application.usecases.manage.safeguards;

import uim.platform.verinice;

@safe:

class ManageSafeguardsUseCase : UIMUseCase {
    private SafeguardRepository repo;

    this(SafeguardRepository repo) {
        this.repo = repo;
    }

    Safeguard[] list() {
        return repo.findAll();
    }

    Safeguard* get_(SafeguardId id) {
        return repo.findById(id);
    }

    CommandResult create(SafeguardDTO dto) {
        Safeguard value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.assetId = dto.assetId;
        value.code = dto.code;
        value.title = dto.title;
        value.description = dto.description;
        value.implementationStatus = dto.implementationStatus.length ? dto.implementationStatus : value.implementationStatus;
        value.maturityLevel = dto.maturityLevel;
        value.owner = dto.owner;
        value.createdBy = dto.createdBy;
        if (!VeriniceValidator.isValidSafeguard(value)) {
            return CommandResult(false, "", "Invalid safeguard data");
        }
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(SafeguardDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "Safeguard not found");
        }
        if (dto.assetId.length) existing.assetId = dto.assetId;
        if (dto.code.length) existing.code = dto.code;
        if (dto.title.length) existing.title = dto.title;
        if (dto.description.length) existing.description = dto.description;
        if (dto.implementationStatus.length) existing.implementationStatus = dto.implementationStatus;
        if (dto.maturityLevel.length) existing.maturityLevel = dto.maturityLevel;
        if (dto.owner.length) existing.owner = dto.owner;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(SafeguardId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "Safeguard not found");
        }
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
