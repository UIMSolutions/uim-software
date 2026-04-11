/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.application.usecases.manage.manage_tracking_models;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class ManageTrackingModelsUseCase : UIMUseCase {
    private TrackingModelRepository repo;

    this(TrackingModelRepository repo) {
        this.repo = repo;
    }

    TrackingModel* get_(TrackingModelId id) {
        return repo.findById(id);
    }

    TrackingModel[] list() {
        return repo.findAll();
    }

    TrackingModel[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    TrackingModel[] listByStatus(ModelStatus status) {
        return repo.findByStatus(status);
    }

    TrackingModel[] listByObjectType(string trackedObjectType) {
        return repo.findByObjectType(trackedObjectType);
    }

    CommandResult create(TrackingModelDTO dto) {
        TrackingModel tm;
        tm.id = dto.id;
        tm.tenantId = dto.tenantId;
        tm.name = dto.name;
        tm.description = dto.description;
        tm.trackedObjectType = dto.trackedObjectType;
        tm.expectedEvents = dto.expectedEvents;
        tm.milestones = dto.milestones;
        tm.correlationRules = dto.correlationRules;
        tm.exceptionRules = dto.exceptionRules;
        tm.version_ = dto.version_;
        tm.createdBy = dto.createdBy;
        if (!TrackingValidator.isValidTrackingModel(tm))
            return CommandResult(false, "", "Invalid tracking model data");
        repo.save(tm);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(TrackingModelDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Tracking model not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.expectedEvents.length > 0) existing.expectedEvents = dto.expectedEvents;
        if (dto.milestones.length > 0) existing.milestones = dto.milestones;
        if (dto.correlationRules.length > 0) existing.correlationRules = dto.correlationRules;
        if (dto.exceptionRules.length > 0) existing.exceptionRules = dto.exceptionRules;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(TrackingModelId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Tracking model not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
