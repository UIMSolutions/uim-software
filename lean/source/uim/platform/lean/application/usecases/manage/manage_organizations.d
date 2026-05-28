/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.usecases.manage.manage_organizations;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ManageOrganizationsUseCase : UIMUseCase {
    private OrganizationRepository repo;

    this(OrganizationRepository repo) { this.repo = repo; }

    Organization* get_(OrganizationId id) { return repo.findById(id); }
    Organization[] list() { return repo.findAll(); }
    Organization[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    Organization[] listByParent(OrganizationId parentId) { return repo.findByParent(parentId); }

    CommandResult create(OrganizationDTO dto) {
        Organization o;
        o.id = dto.id;
        o.tenantId = dto.tenantId;
        o.name = dto.name;
        o.description = dto.description;
        o.parentOrgId = dto.parentOrgId;
        o.orgCode = dto.orgCode;
        o.costCenter = dto.costCenter;
        o.headCount = dto.headCount;
        o.location = dto.location;
        o.orgHead = dto.orgHead;
        o.createdBy = dto.createdBy;
        if (!LeanValidator.isValidOrganization(o))
            return CommandResult(false, "", "Invalid organization data");
        repo.save(o);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(OrganizationDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Organization not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.orgHead.length > 0) existing.orgHead = dto.orgHead;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(OrganizationId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Organization not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
