/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.usecases.manage.manage_incidents;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

class ManageIncidentsUseCase : UIMUseCase {
    private IncidentRepository repo;

    this(IncidentRepository repo) { this.repo = repo; }

    Incident* get_(IncidentId id) { return repo.findById(id); }
    Incident[] list() { return repo.findAll(); }
    Incident[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    Incident[] listByStatus(RecordStatus status) { return repo.findByStatus(status); }
    Incident[] listByPriority(Priority priority) { return repo.findByPriority(priority); }
    Incident[] listByService(ITServiceId serviceId) { return repo.findByService(serviceId); }

    CommandResult create(IncidentDTO dto) {
        Incident i;
        i.id = dto.id;
        i.tenantId = dto.tenantId;
        i.title = dto.title;
        i.description = dto.description;
        i.reportedById = dto.reportedById;
        i.assignedTo = dto.assignedTo;
        i.assignedTeam = dto.assignedTeam;
        i.affectedServiceId = dto.affectedServiceId;
        i.affectedCIId = dto.affectedCIId;
        i.linkedProblemId = dto.linkedProblemId;
        i.reportedAt = dto.reportedAt;
        i.createdBy = dto.createdBy;
        if (!ITILValidator.isValidIncident(i))
            return CommandResult(false, "", "Invalid incident data");
        repo.save(i);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(IncidentDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Incident not found");
        if (dto.title.length > 0) existing.title = dto.title;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.assignedTo.length > 0) existing.assignedTo = dto.assignedTo;
        if (dto.resolutionNotes.length > 0) existing.resolutionNotes = dto.resolutionNotes;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(IncidentId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Incident not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
