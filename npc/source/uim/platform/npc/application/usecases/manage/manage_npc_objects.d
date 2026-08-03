module uim.platform.npc.application.usecases.manage.manage_npc_objects;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.npc.application.dto : CommandResult, NpcObjectDTO;
import uim.platform.npc.domain.entities.npc_object : NpcObject, NpcBusinessObjectType;
import uim.platform.npc.domain.repositories.npc_repository : NpcRepository;
import uim.platform.npc.domain.services.npc_validator : NpcValidator;

@safe:

class ManageNpcObjectsUseCase {
    private NpcRepository repository;

    this(NpcRepository repository) {
        this.repository = repository;
    }

    NpcObject[] list(string objectType) {
        return repository.listByType(objectType);
    }

    NpcObject[] listByParent(string objectType, string parentId) {
        return repository.listByParent(objectType, parentId);
    }

    const(NpcObject)* get_(string objectType, string id) {
        return repository.getByTypeAndId(objectType, id);
    }

    CommandResult create(NpcObjectDTO dto) {
        NpcObject value = toEntity(dto, true);
        value.id = dto.id.length ? dto.id : createCode(dto.objectType);

        if (!NpcValidator.isValid(value)) {
            return CommandResult(false, "", "objectType and one of technicalName/businessName are required");
        }

        if (!repository.create(value)) {
            return CommandResult(false, "", "Object already exists");
        }

        if (value.objectType != NpcBusinessObjectType.auditEntries) {
            repository.create(newAudit("CREATE", value));
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(NpcObjectDTO dto) {
        auto current = repository.getByTypeAndId(dto.objectType, dto.id);
        if (current is null) {
            return CommandResult(false, "", "Object not found");
        }

        auto value = cloneObject(*current);
        if (dto.technicalName.length) value.technicalName = dto.technicalName;
        if (dto.businessName.length) value.businessName = dto.businessName;
        if (dto.planningDomain.length) value.planningDomain = dto.planningDomain;
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

        if (value.objectType != NpcBusinessObjectType.auditEntries) {
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

        if (objectType != NpcBusinessObjectType.auditEntries) {
            repository.create(newAudit("DELETE", snapshot));
        }

        return CommandResult(true, id, "");
    }

    private NpcObject toEntity(NpcObjectDTO dto, bool isCreate) {
        auto now = Clock.currTime().toISOExtString();

        NpcObject value;
        value.id = dto.id;
        value.objectType = dto.objectType;
        value.tenantId = dto.tenantId;
        value.technicalName = dto.technicalName;
        value.businessName = dto.businessName;
        value.planningDomain = dto.planningDomain;
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

    private NpcObject newAudit(string action, in NpcObject source) {
        NpcObject audit;
        audit.id = createCode(NpcBusinessObjectType.auditEntries);
        audit.objectType = NpcBusinessObjectType.auditEntries;
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

    private NpcObject cloneObject(in NpcObject source) {
        NpcObject copy;
        copy.id = source.id;
        copy.objectType = source.objectType;
        copy.tenantId = source.tenantId;
        copy.technicalName = source.technicalName;
        copy.businessName = source.businessName;
        copy.planningDomain = source.planningDomain;
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
    import uim.platform.npc.infrastructure.persistence.memory.npc_repository : MemoryNpcRepository;

    auto repo = new MemoryNpcRepository();
    auto useCase = new ManageNpcObjectsUseCase(repo);

    NpcObjectDTO dto;
    dto.objectType = NpcBusinessObjectType.demandPlans;
    dto.technicalName = "DP_2026_W01";
    dto.businessName = "Demand Week 1";
    dto.createdBy = "tester";

    auto created = useCase.create(dto);
    assert(created.success);

    auto found = useCase.get_(NpcBusinessObjectType.demandPlans, created.id);
    assert(found !is null);

    dto.id = created.id;
    dto.modifiedBy = "tester2";
    dto.description = "Updated";
    auto updated = useCase.update(dto);
    assert(updated.success);

    auto removed = useCase.remove(NpcBusinessObjectType.demandPlans, created.id);
    assert(removed.success);
}
