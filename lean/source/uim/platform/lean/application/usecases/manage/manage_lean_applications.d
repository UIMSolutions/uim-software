/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.usecases.manage.manage_lean_applications;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ManageLeanApplicationsUseCase : UIMUseCase {
    private LeanApplicationRepository repo;

    this(LeanApplicationRepository repo) { this.repo = repo; }

    LeanApplication* get_(LeanApplicationId id) { return repo.findById(id); }
    LeanApplication[] list() { return repo.findAll(); }
    LeanApplication[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    LeanApplication[] listByLifecycleStatus(ApplicationLifecycleStatus s) { return repo.findByLifecycleStatus(s); }
    LeanApplication[] listByType(ApplicationType t) { return repo.findByType(t); }
    LeanApplication[] listByOrganization(OrganizationId orgId) { return repo.findByOrganization(orgId); }

    CommandResult create(LeanApplicationDTO dto) {
        LeanApplication a;
        a.id = dto.id;
        a.tenantId = dto.tenantId;
        a.name = dto.name;
        a.description = dto.description;
        a.owningOrgId = dto.owningOrgId;
        a.itOwner = dto.itOwner;
        a.businessOwner = dto.businessOwner;
        a.vendor = dto.vendor;
        a.version_ = dto.version_;
        a.deploymentDate = dto.deploymentDate;
        a.retirementDate = dto.retirementDate;
        a.annualCostUsd = dto.annualCostUsd;
        a.createdBy = dto.createdBy;
        if (!LeanValidator.isValidLeanApplication(a))
            return CommandResult(false, "", "Invalid application data");
        repo.save(a);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(LeanApplicationDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Application not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.itOwner.length > 0) existing.itOwner = dto.itOwner;
        if (dto.businessOwner.length > 0) existing.businessOwner = dto.businessOwner;
        if (dto.annualCostUsd.length > 0) existing.annualCostUsd = dto.annualCostUsd;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(LeanApplicationId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Application not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
