module uim.platform.ps.application.usecases.manage.manage_project_costs;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class ManageProjectCostsUseCase : UIMUseCase {
    private ProjectCostRepository repo;

    this(ProjectCostRepository repo) {
        this.repo = repo;
    }

    ProjectCost* get_(ProjectCostId id) {
        return repo.findById(id);
    }

    ProjectCost[] list() {
        return repo.findAll();
    }

    ProjectCost[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    ProjectCost[] listByProject(ProjectId projectId) {
        return repo.findByProject(projectId);
    }

    CommandResult create(ProjectCostDTO dto) {
        ProjectCost c;
        c.id = dto.id;
        c.tenantId = dto.tenantId;
        c.projectId = dto.projectId;
        c.wbsElementId = dto.wbsElementId;
        c.activityId = dto.activityId;
        c.costElement = dto.costElement;
        c.plannedCost = dto.plannedCost;
        c.actualCost = dto.actualCost;
        c.committedCost = dto.committedCost;
        c.remainingCost = dto.remainingCost;
        c.currency = dto.currency;
        c.fiscalYear = dto.fiscalYear;
        c.period = dto.period;
        c.postingDate = dto.postingDate;
        c.documentNumber = dto.documentNumber;
        c.description = dto.description;
        c.costCategory = parseEnumValue!CostCategory(dto.costCategory, CostCategory.labor);
        c.createdBy = dto.createdBy;

        if (!PSValidator.isValidProjectCost(c))
            return CommandResult(false, "", "Invalid project cost data");

        repo.save(c);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ProjectCostDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Project cost not found");

        if (dto.costElement.length > 0) existing.costElement = dto.costElement;
        if (dto.plannedCost.length > 0) existing.plannedCost = dto.plannedCost;
        if (dto.actualCost.length > 0) existing.actualCost = dto.actualCost;
        if (dto.committedCost.length > 0) existing.committedCost = dto.committedCost;
        if (dto.remainingCost.length > 0) existing.remainingCost = dto.remainingCost;
        if (dto.currency.length > 0) existing.currency = dto.currency;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.costCategory.length > 0)
            existing.costCategory = parseEnumValue!CostCategory(dto.costCategory, existing.costCategory);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ProjectCostId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Project cost not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
