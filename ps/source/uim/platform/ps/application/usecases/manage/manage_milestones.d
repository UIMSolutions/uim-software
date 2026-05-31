module uim.platform.ps.application.usecases.manage.manage_milestones;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class ManageMilestonesUseCase : UIMUseCase {
    private MilestoneRepository repo;

    this(MilestoneRepository repo) {
        this.repo = repo;
    }

    Milestone* get_(MilestoneId id) {
        return repo.findById(id);
    }

    Milestone[] list() {
        return repo.findAll();
    }

    Milestone[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    Milestone[] listByProject(ProjectId projectId) {
        return repo.findByProject(projectId);
    }

    CommandResult create(MilestoneDTO dto) {
        Milestone m;
        m.id = dto.id;
        m.tenantId = dto.tenantId;
        m.projectId = dto.projectId;
        m.wbsElementId = dto.wbsElementId;
        m.activityId = dto.activityId;
        m.milestoneNumber = dto.milestoneNumber;
        m.name = dto.name;
        m.description = dto.description;
        m.plannedDate = dto.plannedDate;
        m.actualDate = dto.actualDate;
        m.billingAmount = dto.billingAmount;
        m.currency = dto.currency;
        m.category = parseEnumValue!MilestoneCategory(dto.category, MilestoneCategory.project_);
        m.isReached = dto.isReached == "true";
        m.createdBy = dto.createdBy;

        if (!PSValidator.isValidMilestone(m))
            return CommandResult(false, "", "Invalid milestone data");

        repo.save(m);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(MilestoneDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Milestone not found");

        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.plannedDate.length > 0) existing.plannedDate = dto.plannedDate;
        if (dto.actualDate.length > 0) existing.actualDate = dto.actualDate;
        if (dto.billingAmount.length > 0) existing.billingAmount = dto.billingAmount;
        if (dto.currency.length > 0) existing.currency = dto.currency;
        if (dto.category.length > 0)
            existing.category = parseEnumValue!MilestoneCategory(dto.category, existing.category);
        if (dto.isReached.length > 0) existing.isReached = dto.isReached == "true";
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MilestoneId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Milestone not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
