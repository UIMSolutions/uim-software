/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.application.usecases.manage.manage_material_boms;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

class ManageMaterialBOMsUseCase : UIMUseCase {
    private MaterialBOMRepository repo;

    this(MaterialBOMRepository repo) {
        this.repo = repo;
    }

    MaterialBOM* get_(MaterialBOMId id) {
        return repo.findById(id);
    }

    MaterialBOM[] list() {
        return repo.findAll();
    }

    MaterialBOM[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    MaterialBOM[] listByEquipment(EquipmentId equipmentId) {
        return repo.findByEquipment(equipmentId);
    }

    CommandResult create(MaterialBOMDTO dto) {
        MaterialBOM bom;
        bom.id = dto.id;
        bom.tenantId = dto.tenantId;
        bom.name = dto.name;
        bom.description = dto.description;
        bom.equipmentId = dto.equipmentId;
        bom.materialNumber = dto.materialNumber;
        bom.materialDescription = dto.materialDescription;
        bom.quantity = dto.quantity;
        bom.unit = dto.unit;
        bom.storageLocation = dto.storageLocation;
        bom.supplier = dto.supplier;
        bom.unitPrice = dto.unitPrice;
        bom.currency = dto.currency;
        bom.createdBy = dto.createdBy;
        if (!MaintenanceValidator.isValidMaterialBOM(bom))
            return CommandResult(false, "", "Invalid material BOM data");
        repo.save(bom);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(MaterialBOMDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Material BOM not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.quantity.length > 0) existing.quantity = dto.quantity;
        if (dto.unitPrice.length > 0) existing.unitPrice = dto.unitPrice;
        if (dto.supplier.length > 0) existing.supplier = dto.supplier;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MaterialBOMId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Material BOM not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
