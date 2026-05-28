/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.usecases.manage.manage_providers;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ManageProvidersUseCase : UIMUseCase {
    private ProviderRepository repo;

    this(ProviderRepository repo) { this.repo = repo; }

    Provider* get_(ProviderId id) { return repo.findById(id); }
    Provider[] list() { return repo.findAll(); }
    Provider[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    Provider[] listByStatus(FactSheetStatus status) { return repo.findByStatus(status); }

    CommandResult create(ProviderDTO dto) {
        Provider p;
        p.id = dto.id;
        p.tenantId = dto.tenantId;
        p.name = dto.name;
        p.description = dto.description;
        p.website = dto.website;
        p.contactEmail = dto.contactEmail;
        p.contractNumber = dto.contractNumber;
        p.contractStartDate = dto.contractStartDate;
        p.contractEndDate = dto.contractEndDate;
        p.annualCostUsd = dto.annualCostUsd;
        p.country = dto.country;
        p.createdBy = dto.createdBy;
        if (!LeanValidator.isValidProvider(p))
            return CommandResult(false, "", "Invalid provider data");
        repo.save(p);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ProviderDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Provider not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.website.length > 0) existing.website = dto.website;
        if (dto.contactEmail.length > 0) existing.contactEmail = dto.contactEmail;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ProviderId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Provider not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
