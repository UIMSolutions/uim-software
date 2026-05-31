module uim.platform.ps.application.usecases.manage.manage_project_budgets;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class ManageProjectBudgetsUseCase : UIMUseCase {
    private ProjectBudgetRepository repo;

    this(ProjectBudgetRepository repo) {
        this.repo = repo;
    }

    ProjectBudget* get_(ProjectBudgetId id) {
        return repo.findById(id);
    }

    ProjectBudget[] list() {
        return repo.findAll();
    }

    ProjectBudget[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    ProjectBudget[] listByProject(ProjectId projectId) {
        return repo.findByProject(projectId);
    }

    CommandResult create(ProjectBudgetDTO dto) {
        ProjectBudget b;
        b.id = dto.id;
        b.tenantId = dto.tenantId;
        b.projectId = dto.projectId;
        b.wbsElementId = dto.wbsElementId;
        b.originalBudget = dto.originalBudget;
        b.currentBudget = dto.currentBudget;
        b.supplementBudget = dto.supplementBudget;
        b.returnBudget = dto.returnBudget;
        b.transferBudget = dto.transferBudget;
        b.availableBudget = dto.availableBudget;
        b.assignedBudget = dto.assignedBudget;
        b.currency = dto.currency;
        b.fiscalYear = dto.fiscalYear;
        b.validFrom = dto.validFrom;
        b.validTo = dto.validTo;
        b.budgetStatus = parseEnumValue!BudgetStatus(dto.budgetStatus, BudgetStatus.planned);
        b.createdBy = dto.createdBy;

        if (!PSValidator.isValidProjectBudget(b))
            return CommandResult(false, "", "Invalid project budget data");

        repo.save(b);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ProjectBudgetDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Project budget not found");

        if (dto.originalBudget.length > 0) existing.originalBudget = dto.originalBudget;
        if (dto.currentBudget.length > 0) existing.currentBudget = dto.currentBudget;
        if (dto.supplementBudget.length > 0) existing.supplementBudget = dto.supplementBudget;
        if (dto.returnBudget.length > 0) existing.returnBudget = dto.returnBudget;
        if (dto.transferBudget.length > 0) existing.transferBudget = dto.transferBudget;
        if (dto.availableBudget.length > 0) existing.availableBudget = dto.availableBudget;
        if (dto.assignedBudget.length > 0) existing.assignedBudget = dto.assignedBudget;
        if (dto.currency.length > 0) existing.currency = dto.currency;
        if (dto.fiscalYear.length > 0) existing.fiscalYear = dto.fiscalYear;
        if (dto.budgetStatus.length > 0)
            existing.budgetStatus = parseEnumValue!BudgetStatus(dto.budgetStatus, existing.budgetStatus);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ProjectBudgetId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Project budget not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
