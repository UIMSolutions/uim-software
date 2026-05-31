module uim.platform.ps.application.usecases.manage.manage_wbs_elements;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class ManageWBSElementsUseCase : UIMUseCase {
    private WBSElementRepository repo;

    this(WBSElementRepository repo) {
        this.repo = repo;
    }

    WBSElement* get_(WBSElementId id) {
        return repo.findById(id);
    }

    WBSElement[] list() {
        return repo.findAll();
    }

    WBSElement[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    WBSElement[] listByProject(ProjectId projectId) {
        return repo.findByProject(projectId);
    }

    CommandResult create(WBSElementDTO dto) {
        WBSElement e;
        e.id = dto.id;
        e.tenantId = dto.tenantId;
        e.projectId = dto.projectId;
        e.parentId = dto.parentId;
        e.wbsCode = dto.wbsCode;
        e.name = dto.name;
        e.description = dto.description;
        e.responsiblePerson = dto.responsiblePerson;
        e.workCenter = dto.workCenter;
        e.profitCenter = dto.profitCenter;
        e.costCenter = dto.costCenter;
        e.plannedStartDate = dto.plannedStartDate;
        e.plannedFinishDate = dto.plannedFinishDate;
        e.plannedCost = dto.plannedCost;
        e.currency = dto.currency;
        e.elementType = parseEnumValue!WBSElementType(dto.elementType, WBSElementType.planningElement);
        e.status = parseEnumValue!WBSElementStatus(dto.status, WBSElementStatus.created);
        e.isAccountAssignment = dto.isAccountAssignment == "true";
        e.isPlanningElement = dto.isPlanningElement != "false";
        e.isBillingElement = dto.isBillingElement == "true";
        e.createdBy = dto.createdBy;

        if (!PSValidator.isValidWBSElement(e))
            return CommandResult(false, "", "Invalid WBS element data");

        repo.save(e);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(WBSElementDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "WBS element not found");

        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.wbsCode.length > 0) existing.wbsCode = dto.wbsCode;
        if (dto.responsiblePerson.length > 0) existing.responsiblePerson = dto.responsiblePerson;
        if (dto.workCenter.length > 0) existing.workCenter = dto.workCenter;
        if (dto.plannedStartDate.length > 0) existing.plannedStartDate = dto.plannedStartDate;
        if (dto.plannedFinishDate.length > 0) existing.plannedFinishDate = dto.plannedFinishDate;
        if (dto.plannedCost.length > 0) existing.plannedCost = dto.plannedCost;
        if (dto.actualCost.length > 0) existing.actualCost = dto.actualCost;
        if (dto.elementType.length > 0)
            existing.elementType = parseEnumValue!WBSElementType(dto.elementType, existing.elementType);
        if (dto.status.length > 0)
            existing.status = parseEnumValue!WBSElementStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(WBSElementId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "WBS element not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
