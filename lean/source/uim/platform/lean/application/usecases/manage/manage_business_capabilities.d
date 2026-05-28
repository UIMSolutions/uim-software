/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.usecases.manage.manage_business_capabilities;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ManageBusinessCapabilitiesUseCase : UIMUseCase {
    private BusinessCapabilityRepository repo;

    this(BusinessCapabilityRepository repo) { this.repo = repo; }

    BusinessCapability* get_(BusinessCapabilityId id) { return repo.findById(id); }
    BusinessCapability[] list() { return repo.findAll(); }
    BusinessCapability[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    BusinessCapability[] listByParent(BusinessCapabilityId parentId) { return repo.findByParent(parentId); }
    BusinessCapability[] listByOrganization(OrganizationId orgId) { return repo.findByOrganization(orgId); }

    CommandResult create(BusinessCapabilityDTO dto) {
        BusinessCapability bc;
        bc.id = dto.id;
        bc.tenantId = dto.tenantId;
        bc.name = dto.name;
        bc.description = dto.description;
        bc.parentCapabilityId = dto.parentCapabilityId;
        bc.owningOrgId = dto.owningOrgId;
        bc.createdBy = dto.createdBy;
        if (!LeanValidator.isValidBusinessCapability(bc))
            return CommandResult(false, "", "Invalid business capability data");
        repo.save(bc);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(BusinessCapabilityDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Business capability not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(BusinessCapabilityId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Business capability not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
