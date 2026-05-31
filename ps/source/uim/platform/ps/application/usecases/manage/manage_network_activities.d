module uim.platform.ps.application.usecases.manage.manage_network_activities;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class ManageNetworkActivitiesUseCase : UIMUseCase {
    private NetworkActivityRepository repo;

    this(NetworkActivityRepository repo) {
        this.repo = repo;
    }

    NetworkActivity* get_(NetworkActivityId id) {
        return repo.findById(id);
    }

    NetworkActivity[] list() {
        return repo.findAll();
    }

    NetworkActivity[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    NetworkActivity[] listByProject(ProjectId projectId) {
        return repo.findByProject(projectId);
    }

    CommandResult create(NetworkActivityDTO dto) {
        NetworkActivity a;
        a.id = dto.id;
        a.tenantId = dto.tenantId;
        a.projectId = dto.projectId;
        a.wbsElementId = dto.wbsElementId;
        a.activityNumber = dto.activityNumber;
        a.name = dto.name;
        a.description = dto.description;
        a.workCenter = dto.workCenter;
        a.controlKey = dto.controlKey;
        a.plannedWork = dto.plannedWork;
        a.plannedStartDate = dto.plannedStartDate;
        a.plannedFinishDate = dto.plannedFinishDate;
        a.plannedCost = dto.plannedCost;
        a.currency = dto.currency;
        a.activityType = parseEnumValue!ActivityType(dto.activityType, ActivityType.internalProcessing);
        a.status = parseEnumValue!ActivityStatus(dto.status, ActivityStatus.created);
        a.createdBy = dto.createdBy;

        if (!PSValidator.isValidNetworkActivity(a))
            return CommandResult(false, "", "Invalid network activity data");

        repo.save(a);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(NetworkActivityDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Network activity not found");

        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.workCenter.length > 0) existing.workCenter = dto.workCenter;
        if (dto.controlKey.length > 0) existing.controlKey = dto.controlKey;
        if (dto.plannedWork.length > 0) existing.plannedWork = dto.plannedWork;
        if (dto.actualWork.length > 0) existing.actualWork = dto.actualWork;
        if (dto.remainingWork.length > 0) existing.remainingWork = dto.remainingWork;
        if (dto.plannedStartDate.length > 0) existing.plannedStartDate = dto.plannedStartDate;
        if (dto.plannedFinishDate.length > 0) existing.plannedFinishDate = dto.plannedFinishDate;
        if (dto.actualStartDate.length > 0) existing.actualStartDate = dto.actualStartDate;
        if (dto.actualFinishDate.length > 0) existing.actualFinishDate = dto.actualFinishDate;
        if (dto.plannedCost.length > 0) existing.plannedCost = dto.plannedCost;
        if (dto.actualCost.length > 0) existing.actualCost = dto.actualCost;
        if (dto.activityType.length > 0)
            existing.activityType = parseEnumValue!ActivityType(dto.activityType, existing.activityType);
        if (dto.status.length > 0)
            existing.status = parseEnumValue!ActivityStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(NetworkActivityId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Network activity not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
