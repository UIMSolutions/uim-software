/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.usecases.manage.manage_improvement_items;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

class ManageImprovementItemsUseCase : UIMUseCase {
    private ImprovementItemRepository repo;

    this(ImprovementItemRepository repo) { this.repo = repo; }

    ImprovementItem* get_(ImprovementItemId id) { return repo.findById(id); }
    ImprovementItem[] list() { return repo.findAll(); }
    ImprovementItem[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    ImprovementItem[] listByStatus(ImprovementStatus status) { return repo.findByStatus(status); }
    ImprovementItem[] listByPriority(Priority priority) { return repo.findByPriority(priority); }
    ImprovementItem[] listByService(ITServiceId serviceId) { return repo.findByService(serviceId); }

    CommandResult create(ImprovementItemDTO dto) {
        ImprovementItem i;
        i.id = dto.id;
        i.tenantId = dto.tenantId;
        i.title = dto.title;
        i.description = dto.description;
        i.category = dto.category;
        i.proposedBy = dto.proposedBy;
        i.owner = dto.owner;
        i.targetDate = dto.targetDate;
        i.expectedBenefit = dto.expectedBenefit;
        i.relatedServiceId = dto.relatedServiceId;
        i.createdBy = dto.createdBy;
        if (!ITILValidator.isValidImprovementItem(i))
            return CommandResult(false, "", "Invalid improvement item data");
        repo.save(i);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ImprovementItemDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Improvement item not found");
        if (dto.title.length > 0) existing.title = dto.title;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.expectedBenefit.length > 0) existing.expectedBenefit = dto.expectedBenefit;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ImprovementItemId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Improvement item not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
