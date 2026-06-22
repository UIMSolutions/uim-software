module uim.platform.ppm.application.usecases.manage.projects;

import uim.platform.ppm;

@safe:

class ManageProjectsUseCase : UIMUseCase {
    private ProjectRepository repo;

    this(ProjectRepository repo) { this.repo = repo; }

    Project[] list() { return repo.findAll(); }
    Project* get_(ProjectId id) { return repo.findById(id); }

    CommandResult create(ProjectDTO dto) {
        Project value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.programId = dto.programId;
        value.name = dto.name;
        value.description = dto.description;
        value.projectType = dto.projectType;
        value.status = dto.status.length ? dto.status : value.status;
        value.startDate = dto.startDate;
        value.endDate = dto.endDate;
        value.projectManager = dto.projectManager;
        value.budgetAmount = dto.budgetAmount;
        value.currency = dto.currency;
        value.createdBy = dto.createdBy;
        if (!PpmValidator.isValidProject(value)) return CommandResult(false, "", "Invalid project data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ProjectDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Project not found");
        if (dto.programId.length) existing.programId = dto.programId;
        if (dto.name.length) existing.name = dto.name;
        if (dto.description.length) existing.description = dto.description;
        if (dto.projectType.length) existing.projectType = dto.projectType;
        if (dto.status.length) existing.status = dto.status;
        if (dto.startDate.length) existing.startDate = dto.startDate;
        if (dto.endDate.length) existing.endDate = dto.endDate;
        if (dto.projectManager.length) existing.projectManager = dto.projectManager;
        if (dto.budgetAmount.length) existing.budgetAmount = dto.budgetAmount;
        if (dto.currency.length) existing.currency = dto.currency;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ProjectId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Project not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
