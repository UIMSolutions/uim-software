/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.usecases.manage.manage_monitoring_events;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

class ManageMonitoringEventsUseCase : UIMUseCase {
    private MonitoringEventRepository repo;

    this(MonitoringEventRepository repo) { this.repo = repo; }

    MonitoringEvent* get_(MonitoringEventId id) { return repo.findById(id); }
    MonitoringEvent[] list() { return repo.findAll(); }
    MonitoringEvent[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    MonitoringEvent[] listByStatus(EventStatus status) { return repo.findByStatus(status); }
    MonitoringEvent[] listBySeverity(EventSeverity severity) { return repo.findBySeverity(severity); }
    MonitoringEvent[] listByService(ITServiceId serviceId) { return repo.findByService(serviceId); }

    CommandResult create(MonitoringEventDTO dto) {
        MonitoringEvent e;
        e.id = dto.id;
        e.tenantId = dto.tenantId;
        e.title = dto.title;
        e.description = dto.description;
        e.sourceCI = dto.sourceCI;
        e.affectedServiceId = dto.affectedServiceId;
        e.detectedAt = dto.detectedAt;
        e.eventCode = dto.eventCode;
        e.eventSource = dto.eventSource;
        e.createdBy = dto.createdBy;
        if (!ITILValidator.isValidMonitoringEvent(e))
            return CommandResult(false, "", "Invalid monitoring event data");
        repo.save(e);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(MonitoringEventDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Monitoring event not found");
        if (dto.title.length > 0) existing.title = dto.title;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MonitoringEventId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Monitoring event not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
