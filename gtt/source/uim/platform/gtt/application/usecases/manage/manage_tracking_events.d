/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.application.usecases.manage.manage_tracking_events;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class ManageTrackingEventsUseCase : UIMUseCase {
    private TrackingEventRepository repo;

    this(TrackingEventRepository repo) {
        this.repo = repo;
    }

    TrackingEvent* get_(TrackingEventId id) {
        return repo.findById(id);
    }

    TrackingEvent[] list() {
        return repo.findAll();
    }

    TrackingEvent[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    TrackingEvent[] listByTrackedObject(string trackedObjectId) {
        return repo.findByTrackedObject(trackedObjectId);
    }

    TrackingEvent[] listByEventType(EventType eventType) {
        return repo.findByEventType(eventType);
    }

    CommandResult create(TrackingEventDTO dto) {
        TrackingEvent te;
        te.id = dto.id;
        te.tenantId = dto.tenantId;
        te.name = dto.name;
        te.description = dto.description;
        te.trackedObjectId = dto.trackedObjectId;
        te.trackedObjectType = dto.trackedObjectType;
        te.locationId = dto.locationId;
        te.latitude = dto.latitude;
        te.longitude = dto.longitude;
        te.eventTimestamp = dto.eventTimestamp;
        te.reportedBy = dto.reportedBy;
        te.sensorData = dto.sensorData;
        te.milestone = dto.milestone;
        te.createdBy = dto.createdBy;
        if (!TrackingValidator.isValidTrackingEvent(te))
            return CommandResult(false, "", "Invalid tracking event data");
        repo.save(te);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(TrackingEventDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Tracking event not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.sensorData.length > 0) existing.sensorData = dto.sensorData;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(TrackingEventId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Tracking event not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
