/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.application.usecases.manage.manage_alerts;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class ManageAlertsUseCase : UIMUseCase {
    private AlertRepository repo;

    this(AlertRepository repo) {
        this.repo = repo;
    }

    Alert* get_(AlertId id) {
        return repo.findById(id);
    }

    Alert[] list() {
        return repo.findAll();
    }

    Alert[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    Alert[] listBySeverity(AlertSeverity severity) {
        return repo.findBySeverity(severity);
    }

    Alert[] listByStatus(AlertStatus status) {
        return repo.findByStatus(status);
    }

    Alert[] listByCorrelationRule(CorrelationRuleId ruleId) {
        return repo.findByCorrelationRule(ruleId);
    }

    CommandResult create(AlertDTO dto) {
        Alert a;
        a.id = dto.id;
        a.tenantId = dto.tenantId;
        a.name = dto.name;
        a.description = dto.description;
        a.correlationRuleId = dto.correlationRuleId;
        a.ruleName = dto.ruleName;
        a.sourceEventIds = dto.sourceEventIds;
        a.affectedAssetId = dto.affectedAssetId;
        a.sourceIp = dto.sourceIp;
        a.destinationIp = dto.destinationIp;
        a.username = dto.username;
        a.mitreTactic = dto.mitreTactic;
        a.mitreTechnique = dto.mitreTechnique;
        a.assignedTo = dto.assignedTo;
        a.firstSeenAt = dto.firstSeenAt;
        a.lastSeenAt = dto.lastSeenAt;
        a.createdBy = dto.createdBy;
        if (!SiemValidator.isValidAlert(a))
            return CommandResult(false, "", "Invalid alert data");
        repo.save(a);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(AlertDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Alert not found");
        if (dto.status.length > 0) {
            import std.conv : to;
            existing.status = dto.status.to!AlertStatus;
        }
        if (dto.assignedTo.length > 0) existing.assignedTo = dto.assignedTo;
        if (dto.resolvedBy.length > 0) existing.resolvedBy = dto.resolvedBy;
        if (dto.resolutionNote.length > 0) existing.resolutionNote = dto.resolutionNote;
        if (dto.lastSeenAt.length > 0) existing.lastSeenAt = dto.lastSeenAt;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(AlertId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Alert not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
