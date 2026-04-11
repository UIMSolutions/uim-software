/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.application.usecases.manage.manage_maintenance_orders;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class ManageMaintenanceOrdersUseCase : UIMUseCase {
    private MaintenanceOrderRepository repo;

    this(MaintenanceOrderRepository repo) {
        this.repo = repo;
    }

    MaintenanceOrder* get_(MaintenanceOrderId id) {
        return repo.findById(id);
    }

    MaintenanceOrder[] list() {
        return repo.findAll();
    }

    MaintenanceOrder[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    MaintenanceOrder[] listByStatus(OrderStatus status) {
        return repo.findByStatus(status);
    }

    MaintenanceOrder[] listByEquipment(EquipmentId equipmentId) {
        return repo.findByEquipment(equipmentId);
    }

    MaintenanceOrder[] listByType(OrderType orderType) {
        return repo.findByType(orderType);
    }

    CommandResult create(MaintenanceOrderDTO dto) {
        MaintenanceOrder o;
        o.id = dto.id;
        o.tenantId = dto.tenantId;
        o.name = dto.name;
        o.description = dto.description;
        o.orderNumber = dto.orderNumber;
        o.equipmentId = dto.equipmentId;
        o.functionalLocationId = dto.functionalLocationId;
        o.workCenterId = dto.workCenterId;
        o.notificationId = dto.notificationId;
        o.plannedStartDate = dto.plannedStartDate;
        o.plannedEndDate = dto.plannedEndDate;
        o.estimatedCost = dto.estimatedCost;
        o.assignedTo = dto.assignedTo;
        o.createdBy = dto.createdBy;
        if (!MaintenanceValidator.isValidMaintenanceOrder(o))
            return CommandResult(false, "", "Invalid maintenance order data");
        repo.save(o);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(MaintenanceOrderDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Maintenance order not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.actualStartDate.length > 0) existing.actualStartDate = dto.actualStartDate;
        if (dto.actualEndDate.length > 0) existing.actualEndDate = dto.actualEndDate;
        if (dto.actualCost.length > 0) existing.actualCost = dto.actualCost;
        if (dto.assignedTo.length > 0) existing.assignedTo = dto.assignedTo;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MaintenanceOrderId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Maintenance order not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
