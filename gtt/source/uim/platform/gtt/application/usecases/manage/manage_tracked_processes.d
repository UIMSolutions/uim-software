/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.application.usecases.manage.manage_tracked_processes;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class ManageTrackedProcessesUseCase : UIMUseCase {
    private TrackedProcessRepository repo;

    this(TrackedProcessRepository repo) {
        this.repo = repo;
    }

    TrackedProcess* get_(TrackedProcessId id) {
        return repo.findById(id);
    }

    TrackedProcess[] list() {
        return repo.findAll();
    }

    TrackedProcess[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    TrackedProcess[] listByStatus(ProcessStatus status) {
        return repo.findByStatus(status);
    }

    TrackedProcess[] listByProcessType(ProcessType processType) {
        return repo.findByProcessType(processType);
    }

    CommandResult create(TrackedProcessDTO dto) {
        TrackedProcess tp;
        tp.id = dto.id;
        tp.tenantId = dto.tenantId;
        tp.name = dto.name;
        tp.description = dto.description;
        tp.trackingModelId = dto.trackingModelId;
        tp.shipmentIds = dto.shipmentIds;
        tp.deliveryIds = dto.deliveryIds;
        tp.purchaseOrderIds = dto.purchaseOrderIds;
        tp.salesOrderIds = dto.salesOrderIds;
        tp.currentMilestone = dto.currentMilestone;
        tp.completionPercent = dto.completionPercent;
        tp.startDate = dto.startDate;
        tp.createdBy = dto.createdBy;
        if (!TrackingValidator.isValidTrackedProcess(tp))
            return CommandResult(false, "", "Invalid tracked process data");
        repo.save(tp);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(TrackedProcessDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Tracked process not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.currentMilestone.length > 0) existing.currentMilestone = dto.currentMilestone;
        if (dto.completionPercent.length > 0) existing.completionPercent = dto.completionPercent;
        if (dto.endDate.length > 0) existing.endDate = dto.endDate;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(TrackedProcessId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Tracked process not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
