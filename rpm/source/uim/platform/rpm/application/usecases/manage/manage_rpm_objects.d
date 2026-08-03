module uim.platform.rpm.application.usecases.manage.manage_rpm_objects;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.rpm.application.dto : CommandResult, RpmObjectDTO;
import uim.platform.rpm.domain.entities.rpm_object : RpmObject, RpmBusinessObjectType;
import uim.platform.rpm.domain.repositories.rpm_repository : RpmRepository;
import uim.platform.rpm.domain.services.rpm_validator : RpmValidator;

@safe:

class ManageRpmObjectsUseCase {
    private RpmRepository repository;

    this(RpmRepository repository) {
        this.repository = repository;
    }

    RpmObject[] list(string objectType) {
        return repository.listByType(objectType);
    }

    RpmObject[] listByParent(string objectType, string parentId) {
        return repository.listByParent(objectType, parentId);
    }

    const(RpmObject)* get_(string objectType, string id) {
        return repository.getByTypeAndId(objectType, id);
    }

    CommandResult create(RpmObjectDTO dto) {
        auto entity = toEntity(dto, true);
        entity.id = dto.id.length ? dto.id : createCode(dto.objectType);

        if (!RpmValidator.isValid(entity)) {
            return CommandResult(false, "", "objectType and one of technicalName/businessName are required");
        }

        if (!repository.create(entity)) {
            return CommandResult(false, "", "Object already exists");
        }

        if (entity.objectType != RpmBusinessObjectType.auditEntries) {
            repository.create(newAudit("CREATE", entity));
        }

        return CommandResult(true, entity.id, "");
    }

    CommandResult update(RpmObjectDTO dto) {
        auto current = repository.getByTypeAndId(dto.objectType, dto.id);
        if (current is null) {
            return CommandResult(false, "", "Object not found");
        }

        auto value = cloneObject(*current);
        if (dto.technicalName.length) value.technicalName = dto.technicalName;
        if (dto.businessName.length) value.businessName = dto.businessName;
        if (dto.lifecycleState.length) value.lifecycleState = dto.lifecycleState;
        if (dto.parentId.length) value.parentId = dto.parentId;
        if (dto.owner.length) value.owner = dto.owner;
        if (dto.locationId.length) value.locationId = dto.locationId;
        if (dto.partnerId.length) value.partnerId = dto.partnerId;
        if (dto.referenceId.length) value.referenceId = dto.referenceId;
        if (dto.unitOfMeasure.length) value.unitOfMeasure = dto.unitOfMeasure;
        if (dto.quantity) value.quantity = dto.quantity;
        if (dto.description.length) value.description = dto.description;
        if (dto.externalReference.length) value.externalReference = dto.externalReference;
        if (dto.metadata.length) value.metadata = dto.metadata;

        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!repository.update(value)) {
            return CommandResult(false, "", "Object not found");
        }

        if (value.objectType != RpmBusinessObjectType.auditEntries) {
            repository.create(newAudit("UPDATE", value));
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult remove(string objectType, string id) {
        auto current = repository.getByTypeAndId(objectType, id);
        if (current is null) {
            return CommandResult(false, "", "Object not found");
        }

        auto snapshot = cloneObject(*current);
        if (!repository.remove(objectType, id)) {
            return CommandResult(false, "", "Object not found");
        }

        if (objectType != RpmBusinessObjectType.auditEntries) {
            repository.create(newAudit("DELETE", snapshot));
        }

        return CommandResult(true, id, "");
    }

    private RpmObject toEntity(RpmObjectDTO dto, bool isCreate) {
        auto now = Clock.currTime().toISOExtString();

        RpmObject value;
        value.id = dto.id;
        value.objectType = dto.objectType;
        value.tenantId = dto.tenantId;
        value.technicalName = dto.technicalName;
        value.businessName = dto.businessName;
        value.lifecycleState = dto.lifecycleState.length ? dto.lifecycleState : "active";
        value.parentId = dto.parentId;
        value.owner = dto.owner;
        value.locationId = dto.locationId;
        value.partnerId = dto.partnerId;
        value.referenceId = dto.referenceId;
        value.unitOfMeasure = dto.unitOfMeasure.length ? dto.unitOfMeasure : "EA";
        value.quantity = dto.quantity;
        value.description = dto.description;
        value.externalReference = dto.externalReference;
        value.createdBy = dto.createdBy;
        value.modifiedBy = dto.modifiedBy;
        value.createdAt = isCreate ? now : "";
        value.modifiedAt = now;
        value.metadata = dto.metadata;

        return value;
    }

    private RpmObject newAudit(string action, in RpmObject source) {
        RpmObject audit;
        audit.id = createCode(RpmBusinessObjectType.auditEntries);
        audit.objectType = RpmBusinessObjectType.auditEntries;
        audit.tenantId = source.tenantId;
        audit.technicalName = action;
        audit.businessName = source.objectType ~ ":" ~ source.id;
        audit.lifecycleState = "done";
        audit.parentId = source.id;
        audit.owner = source.owner;
        audit.locationId = source.locationId;
        audit.partnerId = source.partnerId;
        audit.referenceId = source.referenceId;
        audit.unitOfMeasure = source.unitOfMeasure;
        audit.quantity = source.quantity;
        audit.description = source.description;
        audit.externalReference = source.externalReference;
        audit.createdBy = source.modifiedBy.length ? source.modifiedBy : source.createdBy;
        audit.modifiedBy = source.modifiedBy;
        audit.createdAt = Clock.currTime().toISOExtString();
        audit.modifiedAt = audit.createdAt;
        audit.metadata["action"] = action;
        audit.metadata["objectType"] = source.objectType;
        return audit;
    }

    private RpmObject cloneObject(in RpmObject source) {
        RpmObject copy;
        copy.id = source.id;
        copy.objectType = source.objectType;
        copy.tenantId = source.tenantId;
        copy.technicalName = source.technicalName;
        copy.businessName = source.businessName;
        copy.lifecycleState = source.lifecycleState;
        copy.parentId = source.parentId;
        copy.owner = source.owner;
        copy.locationId = source.locationId;
        copy.partnerId = source.partnerId;
        copy.referenceId = source.referenceId;
        copy.unitOfMeasure = source.unitOfMeasure;
        copy.quantity = source.quantity;
        copy.description = source.description;
        copy.externalReference = source.externalReference;
        copy.createdBy = source.createdBy;
        copy.modifiedBy = source.modifiedBy;
        copy.createdAt = source.createdAt;
        copy.modifiedAt = source.modifiedAt;
        copy.metadata = source.metadata.dup;
        return copy;
    }

    private string createCode(string objectType) {
        auto prefix = objectType.length ? objectType[0 .. 1] : "X";
        return prefix ~ "-" ~ to!string(Clock.currTime().stdTime);
    }
}

unittest {
    import uim.platform.rpm.infrastructure.persistence.memory.rpm_repository : MemoryRpmRepository;

    auto repo = new MemoryRpmRepository();
    auto useCase = new ManageRpmObjectsUseCase(repo);

    RpmObjectDTO dto;
    dto.objectType = RpmBusinessObjectType.packagingMaterials;
    dto.technicalName = "PALLET-120x80";
    dto.businessName = "Euro Pallet";
    dto.createdBy = "tester";

    auto created = useCase.create(dto);
    assert(created.success);

    auto loaded = useCase.get_(RpmBusinessObjectType.packagingMaterials, created.id);
    assert(loaded !is null);

    dto.id = created.id;
    dto.modifiedBy = "tester2";
    dto.description = "Reusable wooden pallet";
    auto updated = useCase.update(dto);
    assert(updated.success);

    auto removed = useCase.remove(RpmBusinessObjectType.packagingMaterials, created.id);
    assert(removed.success);
}
