/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.usecases.manage.manage_problems;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

class ManageProblemsUseCase : UIMUseCase {
    private ProblemRepository repo;

    this(ProblemRepository repo) { this.repo = repo; }

    Problem* get_(ProblemId id) { return repo.findById(id); }
    Problem[] list() { return repo.findAll(); }
    Problem[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    Problem[] listByStatus(ProblemStatus status) { return repo.findByStatus(status); }
    Problem[] listByPriority(Priority priority) { return repo.findByPriority(priority); }
    Problem[] listByService(ITServiceId serviceId) { return repo.findByService(serviceId); }

    CommandResult create(ProblemDTO dto) {
        Problem p;
        p.id = dto.id;
        p.tenantId = dto.tenantId;
        p.title = dto.title;
        p.description = dto.description;
        p.rootCause = dto.rootCause;
        p.workaround = dto.workaround;
        p.affectedServiceId = dto.affectedServiceId;
        p.assignedTo = dto.assignedTo;
        p.assignedTeam = dto.assignedTeam;
        p.createdBy = dto.createdBy;
        if (!ITILValidator.isValidProblem(p))
            return CommandResult(false, "", "Invalid problem data");
        repo.save(p);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ProblemDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Problem not found");
        if (dto.title.length > 0) existing.title = dto.title;
        if (dto.rootCause.length > 0) existing.rootCause = dto.rootCause;
        if (dto.workaround.length > 0) existing.workaround = dto.workaround;
        if (dto.solution.length > 0) existing.solution = dto.solution;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ProblemId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Problem not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
