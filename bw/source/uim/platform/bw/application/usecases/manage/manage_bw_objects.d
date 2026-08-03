module uim.platform.bw.application.usecases.manage.manage_bw_objects;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.bw.application.dto : CommandResult, BwObjectDTO;
import uim.platform.bw.domain.entities.bw_object : BwObject, BwBusinessObjectType;
import uim.platform.bw.domain.repositories.bw_repository : BwRepository;
import uim.platform.bw.domain.services.bw_validator : BwValidator;

@safe:

class ManageBwObjectsUseCase {
    private BwRepository repository;

    this(BwRepository repository) {
        this.repository = repository;
    }

    BwObject[] list(string objectType) {
        return repository.listByType(objectType);
    }

    BwObject[] listByParent(string objectType, string parentId) {
        return repository.listByParent(objectType, parentId);
    }

    const(BwObject)* get_(string objectType, string id) {
        return repository.getByTypeAndId(objectType, id);
    }

    CommandResult create(BwObjectDTO dto) {
        BwObject value = toEntity(dto, true);
        value.id = dto.id.length ? dto.id : createCode(dto.objectType);

        if (!BwValidator.isValid(value)) {
            return CommandResult(false, "", "objectType and one of technicalName/businessName are required");
        }

        if (!repository.create(value)) {
            return CommandResult(false, "", "Object already exists");
        }

        if (value.objectType != BwBusinessObjectType.auditEntries) {
            repository.create(newAudit("CREATE", value));
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(BwObjectDTO dto) {
        auto current = repository.getByTypeAndId(dto.objectType, dto.id);
        if (current is null) {
            return CommandResult(false, "", "Object not found");
        }

        auto value = cloneObject(*current);
        if (dto.technicalName.length) value.technicalName = dto.technicalName;
        if (dto.businessName.length) value.businessName = dto.businessName;
        if (dto.semanticLayer.length) value.semanticLayer = dto.semanticLayer;
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

        if (value.objectType != BwBusinessObjectType.auditEntries) {
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

        if (objectType != BwBusinessObjectType.auditEntries) {
            repository.create(newAudit("DELETE", snapshot));
        }

        return CommandResult(true, id, "");
    }

    private BwObject toEntity(BwObjectDTO dto, bool isCreate) {
        auto now = Clock.currTime().toISOExtString();

        BwObject value;
        value.id = dto.id;
        value.objectType = dto.objectType;
        value.tenantId = dto.tenantId;
        value.technicalName = dto.technicalName;
        value.businessName = dto.businessName;
        value.semanticLayer = dto.semanticLayer;
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

    private BwObject newAudit(string action, in BwObject source) {
        BwObject audit;
        audit.id = createCode(BwBusinessObjectType.auditEntries);
        audit.objectType = BwBusinessObjectType.auditEntries;
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

    private BwObject cloneObject(in BwObject source) {
        BwObject copy;
        copy.id = source.id;
        copy.objectType = source.objectType;
        copy.tenantId = source.tenantId;
        copy.technicalName = source.technicalName;
        copy.businessName = source.businessName;
        copy.semanticLayer = source.semanticLayer;
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
    import uim.platform.bw.infrastructure.persistence.memory.bw_repository : MemoryBwRepository;

    auto repo = new MemoryBwRepository();
    auto useCase = new ManageBwObjectsUseCase(repo);

    BwObjectDTO dto;
    dto.objectType = BwBusinessObjectType.infoObjects;
    dto.technicalName = "ZCUSTOMER";
    dto.businessName = "Customer";
    dto.createdBy = "tester";

    auto created = useCase.create(dto);
    assert(created.success);

    auto found = useCase.get_(BwBusinessObjectType.infoObjects, created.id);
    assert(found !is null);
    assert((*found).technicalName == "ZCUSTOMER");

    dto.id = created.id;
    dto.modifiedBy = "tester2";
    dto.description = "Updated description";
    auto updated = useCase.update(dto);
    assert(updated.success);

    auto removed = useCase.remove(BwBusinessObjectType.infoObjects, created.id);
    assert(removed.success);
}
