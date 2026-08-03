module uim.platform.ead.application.usecases.manage.manage_ead_objects;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.ead.application.dto : CommandResult, EadObjectDTO;
import uim.platform.ead.domain.entities.ead_object : EadObject, EadBusinessObjectType;
import uim.platform.ead.domain.repositories.ead_repository : EadRepository;
import uim.platform.ead.domain.services.ead_validator : EadValidator;

@safe:

class ManageEadObjectsUseCase {
    private EadRepository repository;

    this(EadRepository repository) {
        this.repository = repository;
    }

    EadObject[] list(string objectType) {
        return repository.listByType(objectType);
    }

    EadObject[] listByParent(string objectType, string parentId) {
        return repository.listByParent(objectType, parentId);
    }

    const(EadObject)* get_(string objectType, string id) {
        return repository.getByTypeAndId(objectType, id);
    }

    CommandResult create(EadObjectDTO dto) {
        EadObject value = toEntity(dto, true);
        value.id = dto.id.length ? dto.id : createCode(dto.objectType);

        if (!EadValidator.isValid(value)) {
            return CommandResult(false, "", "objectType and one of technicalName/businessName are required");
        }

        if (!repository.create(value)) {
            return CommandResult(false, "", "Object already exists");
        }

        if (value.objectType != EadBusinessObjectType.auditEntries) {
            repository.create(newAudit("CREATE", value));
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(EadObjectDTO dto) {
        auto current = repository.getByTypeAndId(dto.objectType, dto.id);
        if (current is null) {
            return CommandResult(false, "", "Object not found");
        }

        auto value = cloneObject(*current);
        if (dto.technicalName.length) value.technicalName = dto.technicalName;
        if (dto.businessName.length) value.businessName = dto.businessName;
        if (dto.architectureLayer.length) value.architectureLayer = dto.architectureLayer;
        if (dto.lifecycleState.length) value.lifecycleState = dto.lifecycleState;
        if (dto.parentId.length) value.parentId = dto.parentId;
        if (dto.sourceId.length) value.sourceId = dto.sourceId;
        if (dto.targetId.length) value.targetId = dto.targetId;
        if (dto.owner.length) value.owner = dto.owner;
        if (dto.description.length) value.description = dto.description;
        if (dto.externalReference.length) value.externalReference = dto.externalReference;
        if (dto.metadata.length) value.metadata = dto.metadata;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!repository.update(value)) {
            return CommandResult(false, "", "Object not found");
        }

        if (value.objectType != EadBusinessObjectType.auditEntries) {
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

        if (objectType != EadBusinessObjectType.auditEntries) {
            repository.create(newAudit("DELETE", snapshot));
        }

        return CommandResult(true, id, "");
    }

    private EadObject toEntity(EadObjectDTO dto, bool isCreate) {
        auto now = Clock.currTime().toISOExtString();

        EadObject value;
        value.id = dto.id;
        value.objectType = dto.objectType;
        value.tenantId = dto.tenantId;
        value.technicalName = dto.technicalName;
        value.businessName = dto.businessName;
        value.architectureLayer = dto.architectureLayer;
        value.lifecycleState = dto.lifecycleState.length ? dto.lifecycleState : "active";
        value.parentId = dto.parentId;
        value.sourceId = dto.sourceId;
        value.targetId = dto.targetId;
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

    private EadObject newAudit(string action, in EadObject source) {
        EadObject audit;
        audit.id = createCode(EadBusinessObjectType.auditEntries);
        audit.objectType = EadBusinessObjectType.auditEntries;
        audit.tenantId = source.tenantId;
        audit.technicalName = action;
        audit.businessName = source.objectType ~ ":" ~ source.id;
        audit.architectureLayer = source.architectureLayer;
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

    private EadObject cloneObject(in EadObject source) {
        EadObject copy;
        copy.id = source.id;
        copy.objectType = source.objectType;
        copy.tenantId = source.tenantId;
        copy.technicalName = source.technicalName;
        copy.businessName = source.businessName;
        copy.architectureLayer = source.architectureLayer;
        copy.lifecycleState = source.lifecycleState;
        copy.parentId = source.parentId;
        copy.sourceId = source.sourceId;
        copy.targetId = source.targetId;
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
    import uim.platform.ead.infrastructure.persistence.memory.ead_repository : MemoryEadRepository;

    auto repo = new MemoryEadRepository();
    auto useCase = new ManageEadObjectsUseCase(repo);

    EadObjectDTO dto;
    dto.objectType = EadBusinessObjectType.applicationComponents;
    dto.technicalName = "APP_FIN_AR";
    dto.businessName = "Accounts Receivable";
    dto.createdBy = "tester";

    auto created = useCase.create(dto);
    assert(created.success);

    auto found = useCase.get_(EadBusinessObjectType.applicationComponents, created.id);
    assert(found !is null);
    assert((*found).technicalName == "APP_FIN_AR");

    dto.id = created.id;
    dto.modifiedBy = "tester2";
    dto.description = "Updated description";
    auto updated = useCase.update(dto);
    assert(updated.success);

    auto removed = useCase.remove(EadBusinessObjectType.applicationComponents, created.id);
    assert(removed.success);
}
