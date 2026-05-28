/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.usecases.manage.manage_business_contexts;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ManageBusinessContextsUseCase : UIMUseCase {
    private BusinessContextRepository repo;

    this(BusinessContextRepository repo) { this.repo = repo; }

    BusinessContext* get_(BusinessContextId id) { return repo.findById(id); }
    BusinessContext[] list() { return repo.findAll(); }
    BusinessContext[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    BusinessContext[] listByCapability(BusinessCapabilityId capabilityId) { return repo.findByCapability(capabilityId); }

    CommandResult create(BusinessContextDTO dto) {
        BusinessContext bc;
        bc.id = dto.id;
        bc.tenantId = dto.tenantId;
        bc.name = dto.name;
        bc.description = dto.description;
        bc.capabilityId = dto.capabilityId;
        bc.owningOrgId = dto.owningOrgId;
        bc.processOwner = dto.processOwner;
        bc.frequency = dto.frequency;
        bc.createdBy = dto.createdBy;
        if (!LeanValidator.isValidBusinessContext(bc))
            return CommandResult(false, "", "Invalid business context data");
        repo.save(bc);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(BusinessContextDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Business context not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.processOwner.length > 0) existing.processOwner = dto.processOwner;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(BusinessContextId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Business context not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
