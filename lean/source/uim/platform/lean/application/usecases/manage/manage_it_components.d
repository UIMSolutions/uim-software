/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.usecases.manage.manage_it_components;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ManageITComponentsUseCase : UIMUseCase {
    private ITComponentRepository repo;

    this(ITComponentRepository repo) { this.repo = repo; }

    ITComponent* get_(ITComponentId id) { return repo.findById(id); }
    ITComponent[] list() { return repo.findAll(); }
    ITComponent[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    ITComponent[] listByLifecycleStatus(ITComponentLifecycleStatus s) { return repo.findByLifecycleStatus(s); }
    ITComponent[] listByType(ITComponentType t) { return repo.findByType(t); }
    ITComponent[] listByProvider(ProviderId providerId) { return repo.findByProvider(providerId); }
    ITComponent[] listByTechCategory(TechCategoryId categoryId) { return repo.findByTechCategory(categoryId); }

    CommandResult create(ITComponentDTO dto) {
        ITComponent c;
        c.id = dto.id;
        c.tenantId = dto.tenantId;
        c.name = dto.name;
        c.description = dto.description;
        c.techCategoryId = dto.techCategoryId;
        c.providerId = dto.providerId;
        c.version_ = dto.version_;
        c.releaseDate = dto.releaseDate;
        c.endOfLifeDate = dto.endOfLifeDate;
        c.licenseModel = dto.licenseModel;
        c.annualCostUsd = dto.annualCostUsd;
        c.createdBy = dto.createdBy;
        if (!LeanValidator.isValidITComponent(c))
            return CommandResult(false, "", "Invalid IT component data");
        repo.save(c);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ITComponentDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "IT component not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.version_.length > 0) existing.version_ = dto.version_;
        if (dto.endOfLifeDate.length > 0) existing.endOfLifeDate = dto.endOfLifeDate;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ITComponentId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "IT component not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
