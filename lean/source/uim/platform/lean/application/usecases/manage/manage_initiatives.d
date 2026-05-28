/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.usecases.manage.manage_initiatives;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ManageInitiativesUseCase : UIMUseCase {
    private InitiativeRepository repo;

    this(InitiativeRepository repo) { this.repo = repo; }

    Initiative* get_(InitiativeId id) { return repo.findById(id); }
    Initiative[] list() { return repo.findAll(); }
    Initiative[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    Initiative[] listByStatus(FactSheetStatus status) { return repo.findByStatus(status); }
    Initiative[] listByInitiativeStatus(InitiativeStatus s) { return repo.findByInitiativeStatus(s); }
    Initiative[] listByPhase(InitiativePhase phase) { return repo.findByPhase(phase); }

    CommandResult create(InitiativeDTO dto) {
        Initiative i;
        i.id = dto.id;
        i.tenantId = dto.tenantId;
        i.name = dto.name;
        i.description = dto.description;
        i.budgetUsd = dto.budgetUsd;
        i.startDate = dto.startDate;
        i.endDate = dto.endDate;
        i.responsiblePerson = dto.responsiblePerson;
        i.responsibleOrgId = dto.responsibleOrgId;
        i.createdBy = dto.createdBy;
        if (!LeanValidator.isValidInitiative(i))
            return CommandResult(false, "", "Invalid initiative data");
        repo.save(i);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(InitiativeDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Initiative not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.budgetUsd.length > 0) existing.budgetUsd = dto.budgetUsd;
        if (dto.endDate.length > 0) existing.endDate = dto.endDate;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(InitiativeId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Initiative not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
