/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.application.usecases.manage.manage_maintenance_items;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class ManageMaintenanceItemsUseCase : UIMUseCase {
    private MaintenanceItemRepository repo;

    this(MaintenanceItemRepository repo) {
        this.repo = repo;
    }

    MaintenanceItem* get_(MaintenanceItemId id) {
        return repo.findById(id);
    }

    MaintenanceItem[] list() {
        return repo.findAll();
    }

    MaintenanceItem[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    MaintenanceItem[] listByPlan(MaintenancePlanId planId) {
        return repo.findByPlan(planId);
    }

    MaintenanceItem[] listByEquipment(EquipmentId equipmentId) {
        return repo.findByEquipment(equipmentId);
    }

    CommandResult create(MaintenanceItemDTO dto) {
        MaintenanceItem mi;
        mi.id = dto.id;
        mi.tenantId = dto.tenantId;
        mi.name = dto.name;
        mi.description = dto.description;
        mi.maintenancePlanId = dto.maintenancePlanId;
        mi.equipmentId = dto.equipmentId;
        mi.functionalLocationId = dto.functionalLocationId;
        mi.taskListId = dto.taskListId;
        mi.taskListDescription = dto.taskListDescription;
        mi.workCenterId = dto.workCenterId;
        mi.orderType = dto.orderType;
        mi.cycle = dto.cycle;
        mi.cycleUnit = dto.cycleUnit;
        mi.createdBy = dto.createdBy;
        if (!MaintenanceValidator.isValidMaintenanceItem(mi))
            return CommandResult(false, "", "Invalid maintenance item data");
        repo.save(mi);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(MaintenanceItemDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Maintenance item not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.taskListDescription.length > 0) existing.taskListDescription = dto.taskListDescription;
        if (dto.cycle.length > 0) existing.cycle = dto.cycle;
        if (dto.cycleUnit.length > 0) existing.cycleUnit = dto.cycleUnit;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MaintenanceItemId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Maintenance item not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
