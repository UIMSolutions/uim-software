/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.application.usecases.manage.manage_equipment;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class ManageEquipmentUseCase : UIMUseCase {
    private EquipmentRepository repo;

    this(EquipmentRepository repo) {
        this.repo = repo;
    }

    Equipment* get_(EquipmentId id) {
        return repo.findById(id);
    }

    Equipment[] list() {
        return repo.findAll();
    }

    Equipment[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    Equipment[] listByStatus(EquipmentStatus status) {
        return repo.findByStatus(status);
    }

    Equipment[] listByFunctionalLocation(FunctionalLocationId locationId) {
        return repo.findByFunctionalLocation(locationId);
    }

    CommandResult create(EquipmentDTO dto) {
        Equipment e;
        e.id = dto.id;
        e.tenantId = dto.tenantId;
        e.name = dto.name;
        e.description = dto.description;
        e.equipmentNumber = dto.equipmentNumber;
        e.functionalLocationId = dto.functionalLocationId;
        e.manufacturer = dto.manufacturer;
        e.modelNumber = dto.modelNumber;
        e.serialNumber = dto.serialNumber;
        e.installationDate = dto.installationDate;
        e.warrantyEndDate = dto.warrantyEndDate;
        e.acquisitionValue = dto.acquisitionValue;
        e.currency = dto.currency;
        e.createdBy = dto.createdBy;
        if (!MaintenanceValidator.isValidEquipment(e))
            return CommandResult(false, "", "Invalid equipment data");
        repo.save(e);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(EquipmentDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Equipment not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.manufacturer.length > 0) existing.manufacturer = dto.manufacturer;
        if (dto.modelNumber.length > 0) existing.modelNumber = dto.modelNumber;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(EquipmentId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Equipment not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
