module uim.platform.ewm.application.usecases.manage.bill_of_materials;

import uim.platform.ewm;

@safe:

class ManageBillOfMaterialsUseCase : UIMUseCase {
    private BillOfMaterialRepository repo;
    this(BillOfMaterialRepository repo) { this.repo = repo; }
    BillOfMaterial[] list() { return repo.findAll(); }
    BillOfMaterial* get_(BillOfMaterialId id) { return repo.findById(id); }
    CommandResult create(BillOfMaterialDTO dto) {
        BillOfMaterial value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.warehouseId = dto.warehouseId;
        value.name = dto.name;
        value.description = dto.description;
        value.bomType = dto.bomType;
        value.revision = dto.revision;
        value.usage = dto.usage;
        value.plant = dto.plant;
        value.baseQuantity = dto.baseQuantity;
        value.baseUnit = dto.baseUnit;
        value.isActive = dto.isActive.length ? dto.isActive : value.isActive;
        value.createdBy = dto.createdBy;
        if (!EccValidator.isValidBillOfMaterial(value)) {
            return CommandResult(false, "", "Invalid BOM data");
        }
        repo.save(value); return CommandResult(true, dto.id, "");
    }
    CommandResult update(BillOfMaterialDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "BOM not found");
        }
        if (dto.name.length) existing.name = dto.name;
        if (dto.description.length) existing.description = dto.description;
        if (dto.bomType.length) existing.bomType = dto.bomType;
        if (dto.revision.length) existing.revision = dto.revision;
        if (dto.usage.length) existing.usage = dto.usage;
        if (dto.plant.length) existing.plant = dto.plant;
        if (dto.baseQuantity.length) existing.baseQuantity = dto.baseQuantity;
        if (dto.baseUnit.length) existing.baseUnit = dto.baseUnit;
        if (dto.isActive.length) existing.isActive = dto.isActive;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }
    CommandResult remove(BillOfMaterialId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "BOM not found");
        }
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
