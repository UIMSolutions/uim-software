module uim.platform.material_traceability.application.usecases.manage.manage_mt_objects;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.material_traceability.application.dto : CommandResult, MtObjectDTO;
import uim.platform.material_traceability.domain.entities.mt_object : MtObject, MtBusinessObjectType;
import uim.platform.material_traceability.domain.repositories.mt_repository : MtRepository;
import uim.platform.material_traceability.domain.services.mt_validator : MtValidator;

@safe:

class ManageMtObjectsUseCase {
    private MtRepository repository;

    this(MtRepository repository) {
        this.repository = repository;
    }

    MtObject[] list(string objectType) {
        return repository.listByType(objectType);
    }

    MtObject[] listByParent(string objectType, string parentId) {
        return repository.listByParent(objectType, parentId);
    }

    const(MtObject)* get_(string objectType, string id) {
        return repository.getByTypeAndId(objectType, id);
    }

    CommandResult create(MtObjectDTO dto) {
        MtObject value = toEntity(dto, true);
        value.id = dto.id.length ? dto.id : createCode(dto.objectType);

        if (!MtValidator.isValid(value)) {
            return CommandResult(false, "", "objectType and one of technicalName/businessName are required");
        }

        if (!repository.create(value)) {
            return CommandResult(false, "", "Object already exists");
        }

        if (value.objectType != MtBusinessObjectType.auditEntries) {
            repository.create(newAudit("CREATE", value));
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(MtObjectDTO dto) {
        auto current = repository.getByTypeAndId(dto.objectType, dto.id);
        if (current is null) {
            return CommandResult(false, "", "Object not found");
        }

        auto value = cloneObject(*current);
        if (dto.technicalName.length) value.technicalName = dto.technicalName;
        if (dto.businessName.length) value.businessName = dto.businessName;
        if (dto.traceabilityDomain.length) value.traceabilityDomain = dto.traceabilityDomain;
        if (dto.sourceSystem.length) value.sourceSystem = dto.sourceSystem;
        if (dto.lifecycleState.length) value.lifecycleState = dto.lifecycleState;
        if (dto.parentId.length) value.parentId = dto.parentId;
        if (dto.owner.length) value.owner = dto.owner;
        if (dto.description.length) value.description = dto.description;
        if (dto.externalReference.length) value.externalReference = dto.externalReference;
        if (dto.metadata.length) value.metadata = dto.metadata;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!repository.update(value)) {
            return CommandResult(false, "", "Object not found");
        }

        if (value.objectType != MtBusinessObjectType.auditEntries) {
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

        if (objectType != MtBusinessObjectType.auditEntries) {
            repository.create(newAudit("DELETE", snapshot));
        }

        return CommandResult(true, id, "");
    }

    private MtObject toEntity(MtObjectDTO dto, bool isCreate) {
        auto now = Clock.currTime().toISOExtString();

        MtObject value;
        value.id = dto.id;
        value.objectType = dto.objectType;
        value.tenantId = dto.tenantId;
        value.technicalName = dto.technicalName;
        value.businessName = dto.businessName;
        value.traceabilityDomain = dto.traceabilityDomain;
        value.sourceSystem = dto.sourceSystem;
        value.lifecycleState = dto.lifecycleState.length ? dto.lifecycleState : "active";
        value.parentId = dto.parentId;
        value.owner = dto.owner;
        value.description = dto.description;
        value.externalReference = dto.externalReference;
        value.createdBy = dto.createdBy;
        value.modifiedBy = dto.modifiedBy;
        value.createdAt = isCreate ? now : "";
        value.modifiedAt = now;
        value.metadata = dto.metadata;

        return value;
    }

    private MtObject newAudit(string action, in MtObject source) {
        MtObject audit;
        audit.id = createCode(MtBusinessObjectType.auditEntries);
        audit.objectType = MtBusinessObjectType.auditEntries;
        audit.tenantId = source.tenantId;
        audit.technicalName = action;
        audit.businessName = source.objectType ~ ":" ~ source.id;
        audit.lifecycleState = "done";
        audit.parentId = source.id;
        audit.owner = source.owner;
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

    private MtObject cloneObject(in MtObject source) {
        MtObject copy;
        copy.id = source.id;
        copy.objectType = source.objectType;
        copy.tenantId = source.tenantId;
        copy.technicalName = source.technicalName;
        copy.businessName = source.businessName;
        copy.traceabilityDomain = source.traceabilityDomain;
        copy.sourceSystem = source.sourceSystem;
        copy.lifecycleState = source.lifecycleState;
        copy.parentId = source.parentId;
        copy.owner = source.owner;
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
    import uim.platform.material_traceability.infrastructure.persistence.memory.mt_repository : MemoryMtRepository;

    auto repo = new MemoryMtRepository();
    auto useCase = new ManageMtObjectsUseCase(repo);

    MtObjectDTO dto;
    dto.objectType = MtBusinessObjectType.materials;
    dto.technicalName = "MAT_4711";
    dto.businessName = "Sample Material";
    dto.createdBy = "tester";

    auto created = useCase.create(dto);
    assert(created.success);

    auto found = useCase.get_(MtBusinessObjectType.materials, created.id);
    assert(found !is null);

    dto.id = created.id;
    dto.modifiedBy = "tester2";
    dto.description = "Updated";
    auto updated = useCase.update(dto);
    assert(updated.success);

    auto removed = useCase.remove(MtBusinessObjectType.materials, created.id);
    assert(removed.success);
}
