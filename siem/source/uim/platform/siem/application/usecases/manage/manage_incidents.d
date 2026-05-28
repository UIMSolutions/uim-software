/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.application.usecases.manage.manage_incidents;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class ManageIncidentsUseCase : UIMUseCase {
    private IncidentRepository repo;

    this(IncidentRepository repo) {
        this.repo = repo;
    }

    Incident* get_(IncidentId id) {
        return repo.findById(id);
    }

    Incident[] list() {
        return repo.findAll();
    }

    Incident[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    Incident[] listBySeverity(IncidentSeverity severity) {
        return repo.findBySeverity(severity);
    }

    Incident[] listByStatus(IncidentStatus status) {
        return repo.findByStatus(status);
    }

    CommandResult create(IncidentDTO dto) {
        Incident i;
        i.id = dto.id;
        i.tenantId = dto.tenantId;
        i.name = dto.name;
        i.description = dto.description;
        i.alertIds = dto.alertIds;
        i.affectedAssetIds = dto.affectedAssetIds;
        i.leadAnalyst = dto.leadAnalyst;
        i.respondents = dto.respondents;
        i.attackVector = dto.attackVector;
        i.mitreTactics = dto.mitreTactics;
        i.mitreTechniques = dto.mitreTechniques;
        i.detectedAt = dto.detectedAt;
        i.createdBy = dto.createdBy;
        if (!SiemValidator.isValidIncident(i))
            return CommandResult(false, "", "Invalid incident data");
        repo.save(i);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(IncidentDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Incident not found");
        if (dto.status.length > 0) {
            import std.conv : to;
            existing.status = dto.status.to!IncidentStatus;
        }
        if (dto.severity.length > 0) {
            import std.conv : to;
            existing.severity = dto.severity.to!IncidentSeverity;
        }
        if (dto.leadAnalyst.length > 0) existing.leadAnalyst = dto.leadAnalyst;
        if (dto.containmentActions.length > 0) existing.containmentActions = dto.containmentActions;
        if (dto.eradicationActions.length > 0) existing.eradicationActions = dto.eradicationActions;
        if (dto.recoveryActions.length > 0) existing.recoveryActions = dto.recoveryActions;
        if (dto.lessonsLearned.length > 0) existing.lessonsLearned = dto.lessonsLearned;
        if (dto.containedAt.length > 0) existing.containedAt = dto.containedAt;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(IncidentId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Incident not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
