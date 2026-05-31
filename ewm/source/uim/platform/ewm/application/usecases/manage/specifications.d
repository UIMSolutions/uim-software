module uim.platform.ewm.application.usecases.manage.specifications;

import uim.platform.ewm;

@safe:

class ManageSpecificationsUseCase : UIMUseCase {
    private SpecificationRepository repo;
    this(SpecificationRepository repo) { this.repo = repo; }
    Specification[] list() { return repo.findAll(); }
    Specification* get_(SpecificationId id) { return repo.findById(id); }
    CommandResult create(SpecificationDTO dto) {
        Specification value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.warehouseId = dto.warehouseId;
        value.name = dto.name;
        value.description = dto.description;
        value.specificationType = dto.specificationType;
        value.status = dto.status.length ? dto.status : value.status;
        value.specificationNumber = dto.specificationNumber;
        value.property = dto.property;
        value.targetValue = dto.targetValue;
        value.unit = dto.unit;
        value.lowerLimit = dto.lowerLimit;
        value.upperLimit = dto.upperLimit;
        value.testMethod = dto.testMethod;
        value.complianceStandard = dto.complianceStandard;
        value.createdBy = dto.createdBy;
        if (!EccValidator.isValidSpecification(value)) {
            return CommandResult(false, "", "Invalid specification data");
        }
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }
    CommandResult update(SpecificationDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "Stock item not found");
        }
        if (dto.name.length) existing.name = dto.name;
        if (dto.description.length) existing.description = dto.description;
        if (dto.specificationType.length) existing.specificationType = dto.specificationType;
        if (dto.status.length) existing.status = dto.status;
        if (dto.specificationNumber.length) existing.specificationNumber = dto.specificationNumber;
        if (dto.property.length) existing.property = dto.property;
        if (dto.targetValue.length) existing.targetValue = dto.targetValue;
        if (dto.unit.length) existing.unit = dto.unit;
        if (dto.lowerLimit.length) existing.lowerLimit = dto.lowerLimit;
        if (dto.upperLimit.length) existing.upperLimit = dto.upperLimit;
        if (dto.testMethod.length) existing.testMethod = dto.testMethod;
        if (dto.complianceStandard.length) existing.complianceStandard = dto.complianceStandard;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }
    CommandResult remove(SpecificationId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "Stock item not found");
        }
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
