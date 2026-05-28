module uim.platform.mrp.application.usecases.manage.manage_bills_of_material;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class ManageBillsOfMaterialUseCase : UIMUseCase {
    private BillOfMaterialRepository repo;

    this(BillOfMaterialRepository repo) {
        this.repo = repo;
    }

    BillOfMaterial* get_(BillOfMaterialId id) { return repo.findById(id); }
    BillOfMaterial[] list() { return repo.findAll(); }
    BillOfMaterial[] listByPlant(PlantId plantId) { return repo.findByPlant(plantId); }

    CommandResult create(BillOfMaterialDTO dto) {
        BillOfMaterial b;
        b.id = dto.id;
        b.tenantId = dto.tenantId;
        b.plantId = dto.plantId;
        b.name = dto.name;
        b.description = dto.description;
        b.parentMaterialId = dto.parentMaterialId;
        b.componentMaterialId = dto.componentMaterialId;
        b.componentQuantity = dto.componentQuantity;
        b.baseQuantity = dto.baseQuantity;
        b.scrapPercent = dto.scrapPercent;
        b.validFrom = dto.validFrom;
        b.validTo = dto.validTo;
        b.createdBy = dto.createdBy;

        if (!MRPValidator.isValidBillOfMaterial(b))
            return CommandResult(false, "", "Invalid bill of material data");

        repo.save(b);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(BillOfMaterialDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Bill of material not found");

        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.componentQuantity.length > 0) existing.componentQuantity = dto.componentQuantity;
        if (dto.baseQuantity.length > 0) existing.baseQuantity = dto.baseQuantity;
        if (dto.scrapPercent.length > 0) existing.scrapPercent = dto.scrapPercent;
        if (dto.validFrom.length > 0) existing.validFrom = dto.validFrom;
        if (dto.validTo.length > 0) existing.validTo = dto.validTo;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(BillOfMaterialId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Bill of material not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
