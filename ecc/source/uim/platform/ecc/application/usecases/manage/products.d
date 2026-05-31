module uim.platform.ecc.application.usecases.manage.products;

import std.conv : to;
import uim.platform.ecc;

@safe:

class ManageProductsUseCase : UIMUseCase {
    private ProductRepository repo;

    this(ProductRepository repo) { this.repo = repo; }

    Product[] list() { return repo.findAll(); }
    Product* get_(ProductId id) { return repo.findById(id); }

    CommandResult create(ProductDTO dto) {
        Product value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.name = dto.name;
        value.description = dto.description;
        value.productNumber = dto.productNumber;
        value.productType = dto.productType;
        value.lifecycleStatus = dto.lifecycleStatus.length ? dto.lifecycleStatus : value.lifecycleStatus;
        value.category = dto.category;
        value.baseUnit = dto.baseUnit;
        value.validFrom = dto.validFrom;
        value.validTo = dto.validTo;
        value.createdBy = dto.createdBy;
        if (!EccValidator.isValidProduct(value)) return CommandResult(false, "", "Invalid product data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ProductDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Product not found");
        if (dto.name.length) existing.name = dto.name;
        if (dto.description.length) existing.description = dto.description;
        if (dto.productNumber.length) existing.productNumber = dto.productNumber;
        if (dto.productType.length) existing.productType = dto.productType;
        if (dto.lifecycleStatus.length) existing.lifecycleStatus = dto.lifecycleStatus;
        if (dto.category.length) existing.category = dto.category;
        if (dto.baseUnit.length) existing.baseUnit = dto.baseUnit;
        if (dto.validFrom.length) existing.validFrom = dto.validFrom;
        if (dto.validTo.length) existing.validTo = dto.validTo;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ProductId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Product not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
