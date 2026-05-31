module uim.platform.ecc.application.usecases.manage.product_structures;

import uim.platform.ecc;

@safe:

class ManageProductStructuresUseCase : UIMUseCase {
    private ProductStructureRepository repo;
    this(ProductStructureRepository repo) { this.repo = repo; }
    ProductStructure[] list() { return repo.findAll(); }
    ProductStructure* get_(ProductStructureId id) { return repo.findById(id); }
    CommandResult create(ProductStructureDTO dto) {
        ProductStructure value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.productId = dto.productId;
        value.name = dto.name;
        value.description = dto.description;
        value.nodeType = dto.nodeType;
        value.parentNodeId = dto.parentNodeId;
        value.childNodeIds = dto.childNodeIds;
        value.quantity = dto.quantity;
        value.mandatory = dto.mandatory;
        value.status = dto.status.length ? dto.status : value.status;
        value.createdBy = dto.createdBy;
        if (!EccValidator.isValidProductStructure(value)) {
            return CommandResult(false, "", "Invalid product structure data");
        }
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }
    CommandResult update(ProductStructureDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "Product structure not found");
        }
        if (dto.name.length) existing.name = dto.name;
        if (dto.description.length) existing.description = dto.description;
        if (dto.nodeType.length) existing.nodeType = dto.nodeType;
        if (dto.parentNodeId.length) existing.parentNodeId = dto.parentNodeId;
        if (dto.childNodeIds.length) existing.childNodeIds = dto.childNodeIds;
        if (dto.quantity.length) existing.quantity = dto.quantity;
        if (dto.mandatory.length) existing.mandatory = dto.mandatory;
        if (dto.status.length) existing.status = dto.status;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }
    CommandResult remove(ProductStructureId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "Product structure not found");
        }
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
