module uim.platform.defemse.application.usecases.manage.contingents;

import std.conv : to;
import uim.platform.defemse;

@safe:

class ManageContingentsUseCase : UIMUseCase {
    private ContingentRepository repo;

    this(ContingentRepository repo) {
        this.repo = repo;
    }

    Contingent[] list() {
        return repo.findAll();
    }

    Contingent* get_(ContingentId id) {
        return repo.findById(id);
    }

    CommandResult create(ContingentDTO dto) {
        Contingent value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.code = dto.code;
        value.name = dto.name;
        value.unitType = dto.unitType;
        value.personnelStrength = dto.personnelStrength;
        value.equipmentCount = dto.equipmentCount;
        if (dto.status.length > 0) value.status = dto.status.to!ContingentStatus;
        if (dto.readinessStatus.length > 0) value.readinessStatus = dto.readinessStatus.to!ReadinessStatus;
        value.currentLocationId = dto.currentLocationId;
        value.destinationLocationId = dto.destinationLocationId;
        value.transportMode = dto.transportMode;
        value.createdBy = dto.createdBy;
        if (!DefemseValidator.isValidContingent(value))
            return CommandResult(false, "", "Invalid contingent data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ContingentDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Contingent not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.unitType.length > 0) existing.unitType = dto.unitType;
        if (dto.personnelStrength.length > 0) existing.personnelStrength = dto.personnelStrength;
        if (dto.equipmentCount.length > 0) existing.equipmentCount = dto.equipmentCount;
        if (dto.status.length > 0) existing.status = dto.status.to!ContingentStatus;
        if (dto.readinessStatus.length > 0) existing.readinessStatus = dto.readinessStatus.to!ReadinessStatus;
        if (dto.currentLocationId.length > 0) existing.currentLocationId = dto.currentLocationId;
        if (dto.destinationLocationId.length > 0) existing.destinationLocationId = dto.destinationLocationId;
        if (dto.transportMode.length > 0) existing.transportMode = dto.transportMode;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ContingentId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Contingent not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}