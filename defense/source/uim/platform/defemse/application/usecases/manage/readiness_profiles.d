module uim.platform.defense.application.usecases.manage.readiness_profiles;

import std.conv : to;
import uim.platform.defense;

@safe:

class ManageReadinessUseCase : UIMUseCase {
    private ReadinessRepository repo;

    this(ReadinessRepository repo) {
        this.repo = repo;
    }

    ReadinessProfile[] list() {
        return repo.findAll();
    }

    ReadinessProfile* get_(ReadinessProfileId id) {
        return repo.findById(id);
    }

    CommandResult create(ReadinessProfileDTO dto) {
        ReadinessProfile value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.contingentId = dto.contingentId;
        value.missionPlanId = dto.missionPlanId;
        value.personnelReadyPercent = dto.personnelReadyPercent;
        value.equipmentReadyPercent = dto.equipmentReadyPercent;
        value.supplyReadyPercent = dto.supplyReadyPercent;
        value.maintenanceOpenCount = dto.maintenanceOpenCount;
        value.mobilityState = dto.mobilityState;
        value.communicationState = dto.communicationState;
        if (dto.status.length > 0) value.status = dto.status.to!ReadinessStatus;
        value.createdBy = dto.createdBy;
        if (!defenseValidator.isValidReadinessProfile(value))
            return CommandResult(false, "", "Invalid readiness profile data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ReadinessProfileDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Readiness profile not found");
        if (dto.personnelReadyPercent.length > 0) existing.personnelReadyPercent = dto.personnelReadyPercent;
        if (dto.equipmentReadyPercent.length > 0) existing.equipmentReadyPercent = dto.equipmentReadyPercent;
        if (dto.supplyReadyPercent.length > 0) existing.supplyReadyPercent = dto.supplyReadyPercent;
        if (dto.maintenanceOpenCount.length > 0) existing.maintenanceOpenCount = dto.maintenanceOpenCount;
        if (dto.mobilityState.length > 0) existing.mobilityState = dto.mobilityState;
        if (dto.communicationState.length > 0) existing.communicationState = dto.communicationState;
        if (dto.status.length > 0) existing.status = dto.status.to!ReadinessStatus;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ReadinessProfileId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Readiness profile not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}