/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.application.usecases.manage.manage_maintenance_plans;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class ManageMaintenancePlansUseCase : UIMUseCase {
    private MaintenancePlanRepository repo;

    this(MaintenancePlanRepository repo) {
        this.repo = repo;
    }

    MaintenancePlan* get_(MaintenancePlanId id) {
        return repo.findById(id);
    }

    MaintenancePlan[] list() {
        return repo.findAll();
    }

    MaintenancePlan[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    MaintenancePlan[] listByStatus(PlanStatus status) {
        return repo.findByStatus(status);
    }

    MaintenancePlan[] listByCategory(PlanCategory category) {
        return repo.findByCategory(category);
    }

    CommandResult create(MaintenancePlanDTO dto) {
        MaintenancePlan p;
        p.id = dto.id;
        p.tenantId = dto.tenantId;
        p.name = dto.name;
        p.description = dto.description;
        p.cycleLength = dto.cycleLength;
        p.cycleUnit = dto.cycleUnit;
        p.leadTimeOffset = dto.leadTimeOffset;
        p.schedulingPeriod = dto.schedulingPeriod;
        p.lastScheduledDate = dto.lastScheduledDate;
        p.nextDueDate = dto.nextDueDate;
        p.createdBy = dto.createdBy;
        if (!MaintenanceValidator.isValidMaintenancePlan(p))
            return CommandResult(false, "", "Invalid maintenance plan data");
        repo.save(p);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(MaintenancePlanDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Maintenance plan not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.cycleLength.length > 0) existing.cycleLength = dto.cycleLength;
        if (dto.cycleUnit.length > 0) existing.cycleUnit = dto.cycleUnit;
        if (dto.nextDueDate.length > 0) existing.nextDueDate = dto.nextDueDate;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MaintenancePlanId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Maintenance plan not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
