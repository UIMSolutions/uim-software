/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.usecases.manage.manage_platforms;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ManagePlatformsUseCase : UIMUseCase {
    private PlatformRepository repo;

    this(PlatformRepository repo) { this.repo = repo; }

    LeanPlatform* get_(PlatformId id) { return repo.findById(id); }
    LeanPlatform[] list() { return repo.findAll(); }
    LeanPlatform[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    LeanPlatform[] listByStatus(FactSheetStatus status) { return repo.findByStatus(status); }

    CommandResult create(LeanPlatformDTO dto) {
        LeanPlatform p;
        p.id = dto.id;
        p.tenantId = dto.tenantId;
        p.name = dto.name;
        p.description = dto.description;
        p.owner = dto.owner;
        p.owningOrgId = dto.owningOrgId;
        p.createdBy = dto.createdBy;
        if (!LeanValidator.isValidPlatform(p))
            return CommandResult(false, "", "Invalid platform data");
        repo.save(p);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(LeanPlatformDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Platform not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.owner.length > 0) existing.owner = dto.owner;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(PlatformId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Platform not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
