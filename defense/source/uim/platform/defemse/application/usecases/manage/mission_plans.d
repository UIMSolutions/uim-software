module uim.platform.defense.application.usecases.manage.mission_plans;

import std.conv : to;
import uim.platform.defense;

@safe:

class ManageMissionPlansUseCase : UIMUseCase {
    private MissionPlanRepository repo;

    this(MissionPlanRepository repo) {
        this.repo = repo;
    }

    MissionPlan[] list() {
        return repo.findAll();
    }

    MissionPlan* get_(MissionPlanId id) {
        return repo.findById(id);
    }

    CommandResult create(MissionPlanDTO dto) {
        MissionPlan value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.reference = dto.reference;
        value.name = dto.name;
        value.objective = dto.objective;
        value.missionType = dto.missionType;
        value.region = dto.region;
        if (dto.status.length > 0) value.status = dto.status.to!MissionStatus;
        value.assignedContingentIds = dto.assignedContingentIds;
        value.locationId = dto.locationId;
        value.downstreamProcessState = dto.downstreamProcessState;
        value.createdBy = dto.createdBy;
        value.createdAt = dto.createdAt;
        if (!defenseValidator.isValidMissionPlan(value))
            return CommandResult(false, "", "Invalid mission plan data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(MissionPlanDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Mission plan not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.objective.length > 0) existing.objective = dto.objective;
        if (dto.missionType.length > 0) existing.missionType = dto.missionType;
        if (dto.region.length > 0) existing.region = dto.region;
        if (dto.status.length > 0) existing.status = dto.status.to!MissionStatus;
        if (dto.assignedContingentIds.length > 0) existing.assignedContingentIds = dto.assignedContingentIds;
        if (dto.locationId.length > 0) existing.locationId = dto.locationId;
        if (dto.downstreamProcessState.length > 0) existing.downstreamProcessState = dto.downstreamProcessState;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MissionPlanId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Mission plan not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}