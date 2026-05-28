/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.application.usecases.manage.manage_objectives;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ManageObjectivesUseCase : UIMUseCase {
    private ObjectiveRepository repo;

    this(ObjectiveRepository repo) { this.repo = repo; }

    Objective* get_(ObjectiveId id) { return repo.findById(id); }
    Objective[] list() { return repo.findAll(); }
    Objective[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    Objective[] listByStatus(FactSheetStatus status) { return repo.findByStatus(status); }
    Objective[] listByType(ObjectiveType objectiveType) { return repo.findByType(objectiveType); }

    CommandResult create(ObjectiveDTO dto) {
        Objective o;
        o.id = dto.id;
        o.tenantId = dto.tenantId;
        o.name = dto.name;
        o.description = dto.description;
        o.targetDate = dto.targetDate;
        o.owner = dto.owner;
        o.owningOrgId = dto.owningOrgId;
        o.createdBy = dto.createdBy;
        if (!LeanValidator.isValidObjective(o))
            return CommandResult(false, "", "Invalid objective data");
        repo.save(o);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ObjectiveDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Objective not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.targetDate.length > 0) existing.targetDate = dto.targetDate;
        if (dto.owner.length > 0) existing.owner = dto.owner;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ObjectiveId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Objective not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
