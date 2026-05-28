/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.application.usecases.manage.manage_security_events;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class ManageSecurityEventsUseCase : UIMUseCase {
    private SecurityEventRepository repo;

    this(SecurityEventRepository repo) {
        this.repo = repo;
    }

    SecurityEvent* get_(SecurityEventId id) {
        return repo.findById(id);
    }

    SecurityEvent[] list() {
        return repo.findAll();
    }

    SecurityEvent[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    SecurityEvent[] listBySeverity(EventSeverity severity) {
        return repo.findBySeverity(severity);
    }

    SecurityEvent[] listByStatus(EventStatus status) {
        return repo.findByStatus(status);
    }

    SecurityEvent[] listByAsset(AssetId assetId) {
        return repo.findByAsset(assetId);
    }

    CommandResult create(SecurityEventDTO dto) {
        SecurityEvent e;
        e.id = dto.id;
        e.tenantId = dto.tenantId;
        e.name = dto.name;
        e.description = dto.description;
        e.sourceIp = dto.sourceIp;
        e.destinationIp = dto.destinationIp;
        e.sourcePort = dto.sourcePort;
        e.destinationPort = dto.destinationPort;
        e.protocol = dto.protocol;
        e.username = dto.username;
        e.hostname = dto.hostname;
        e.rawLog = dto.rawLog;
        e.eventType = dto.eventType;
        e.category = dto.category;
        e.action = dto.action;
        e.outcome = dto.outcome;
        e.assetId = dto.assetId;
        e.correlationRuleId = dto.correlationRuleId;
        e.alertId = dto.alertId;
        e.timestamp = dto.timestamp;
        e.receivedAt = dto.receivedAt;
        e.createdBy = dto.createdBy;
        if (!SiemValidator.isValidSecurityEvent(e))
            return CommandResult(false, "", "Invalid security event data");
        repo.save(e);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(SecurityEventDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Security event not found");
        if (dto.status.length > 0) {
            import std.conv : to;
            existing.status = dto.status.to!EventStatus;
        }
        if (dto.alertId.length > 0) existing.alertId = dto.alertId;
        if (dto.correlationRuleId.length > 0) existing.correlationRuleId = dto.correlationRuleId;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(SecurityEventId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Security event not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
