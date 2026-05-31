module uim.platform.ps.application.usecases.manage.manage_projects;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class ManageProjectsUseCase : UIMUseCase {
    private ProjectRepository repo;

    this(ProjectRepository repo) {
        this.repo = repo;
    }

    Project* get_(ProjectId id) {
        return repo.findById(id);
    }

    Project[] list() {
        return repo.findAll();
    }

    Project[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    CommandResult create(ProjectDTO dto) {
        Project p;
        p.id = dto.id;
        p.tenantId = dto.tenantId;
        p.projectDefinition = dto.projectDefinition;
        p.name = dto.name;
        p.description = dto.description;
        p.companyCode = dto.companyCode;
        p.controllingArea = dto.controllingArea;
        p.profitCenter = dto.profitCenter;
        p.responsiblePerson = dto.responsiblePerson;
        p.projectManager = dto.projectManager;
        p.plannedStartDate = dto.plannedStartDate;
        p.plannedFinishDate = dto.plannedFinishDate;
        p.currency = dto.currency;
        p.projectProfile = dto.projectProfile;
        p.network = dto.network;
        p.totalBudget = dto.totalBudget;
        p.projectType = parseEnumValue!ProjectType(dto.projectType, ProjectType.overheadCostProject);
        p.status = parseEnumValue!ProjectStatus(dto.status, ProjectStatus.created);
        p.billingType = parseEnumValue!BillingType(dto.billingType, BillingType.timeAndMaterial);
        p.budgetControlActive = dto.budgetControlActive == "true";
        p.createdBy = dto.createdBy;

        if (!PSValidator.isValidProject(p))
            return CommandResult(false, "", "Invalid project data");

        repo.save(p);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ProjectDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Project not found");

        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.projectDefinition.length > 0) existing.projectDefinition = dto.projectDefinition;
        if (dto.companyCode.length > 0) existing.companyCode = dto.companyCode;
        if (dto.controllingArea.length > 0) existing.controllingArea = dto.controllingArea;
        if (dto.profitCenter.length > 0) existing.profitCenter = dto.profitCenter;
        if (dto.responsiblePerson.length > 0) existing.responsiblePerson = dto.responsiblePerson;
        if (dto.projectManager.length > 0) existing.projectManager = dto.projectManager;
        if (dto.plannedStartDate.length > 0) existing.plannedStartDate = dto.plannedStartDate;
        if (dto.plannedFinishDate.length > 0) existing.plannedFinishDate = dto.plannedFinishDate;
        if (dto.actualStartDate.length > 0) existing.actualStartDate = dto.actualStartDate;
        if (dto.actualFinishDate.length > 0) existing.actualFinishDate = dto.actualFinishDate;
        if (dto.currency.length > 0) existing.currency = dto.currency;
        if (dto.totalBudget.length > 0) existing.totalBudget = dto.totalBudget;
        if (dto.totalPlannedCost.length > 0) existing.totalPlannedCost = dto.totalPlannedCost;
        if (dto.totalActualCost.length > 0) existing.totalActualCost = dto.totalActualCost;
        if (dto.projectType.length > 0)
            existing.projectType = parseEnumValue!ProjectType(dto.projectType, existing.projectType);
        if (dto.status.length > 0)
            existing.status = parseEnumValue!ProjectStatus(dto.status, existing.status);
        if (dto.billingType.length > 0)
            existing.billingType = parseEnumValue!BillingType(dto.billingType, existing.billingType);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ProjectId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Project not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
