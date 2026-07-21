module uim.platform.defense.application.usecases.manage.maintenance_tasks;

import std.conv : to;
import uim.platform.defense;

@safe:

class ManageMaintenanceTasksUseCase : UIMUseCase {
    private MaintenanceTaskRepository repo;

    this(MaintenanceTaskRepository repo) {
        this.repo = repo;
    }

    MaintenanceTask[] list() {
        return repo.findAll();
    }

    MaintenanceTask* get_(MaintenanceTaskId id) {
        return repo.findById(id);
    }

    CommandResult create(MaintenanceTaskDTO dto) {
        MaintenanceTask value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.contingentId = dto.contingentId;
        value.equipmentId = dto.equipmentId;
        value.taskType = dto.taskType;
        value.priority = dto.priority;
        value.dueAt = dto.dueAt;
        if (dto.status.length > 0) value.status = dto.status.to!MaintenanceTaskStatus;
        value.locationId = dto.locationId;
        value.createdBy = dto.createdBy;
        if (!defenseValidator.isValidMaintenanceTask(value))
            return CommandResult(false, "", "Invalid maintenance task data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(MaintenanceTaskDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Maintenance task not found");
        if (dto.contingentId.length > 0) existing.contingentId = dto.contingentId;
        if (dto.equipmentId.length > 0) existing.equipmentId = dto.equipmentId;
        if (dto.taskType.length > 0) existing.taskType = dto.taskType;
        if (dto.priority.length > 0) existing.priority = dto.priority;
        if (dto.dueAt.length > 0) existing.dueAt = dto.dueAt;
        if (dto.status.length > 0) existing.status = dto.status.to!MaintenanceTaskStatus;
        if (dto.locationId.length > 0) existing.locationId = dto.locationId;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MaintenanceTaskId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Maintenance task not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}