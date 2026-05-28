/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.usecases.manage.manage_tech_categories;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ManageTechCategoriesUseCase : UIMUseCase {
    private TechCategoryRepository repo;

    this(TechCategoryRepository repo) { this.repo = repo; }

    TechCategory* get_(TechCategoryId id) { return repo.findById(id); }
    TechCategory[] list() { return repo.findAll(); }
    TechCategory[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    TechCategory[] listByParent(TechCategoryId parentId) { return repo.findByParent(parentId); }

    CommandResult create(TechCategoryDTO dto) {
        TechCategory tc;
        tc.id = dto.id;
        tc.tenantId = dto.tenantId;
        tc.name = dto.name;
        tc.description = dto.description;
        tc.parentCategoryId = dto.parentCategoryId;
        tc.createdBy = dto.createdBy;
        if (!LeanValidator.isValidTechCategory(tc))
            return CommandResult(false, "", "Invalid tech category data");
        repo.save(tc);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(TechCategoryDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Tech category not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(TechCategoryId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Tech category not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
