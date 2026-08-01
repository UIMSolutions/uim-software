module uim.platform.pp.application.usecases.manage.manage_pp_objects;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.pp.application.dto : CommandResult, PPObjectDTO;
import uim.platform.pp.domain.entities.pp_object : PPObject;
import uim.platform.pp.domain.repositories.pp_repository : PPRepository;
import uim.platform.pp.domain.services.pp_validator : PPValidator;

@safe:

class ManagePPObjectsUseCase {
    private PPRepository repository;

    this(PPRepository repository) {
        this.repository = repository;
    }

    PPObject[] list(string objectType) {
        return repository.listByType(objectType);
    }

    PPObject[] listByMaterial(string objectType, string materialId) {
        return repository.listByMaterial(objectType, materialId);
    }

    const(PPObject)* get_(string objectType, string id) {
        return repository.getByTypeAndId(objectType, id);
    }

    CommandResult create(PPObjectDTO dto) {
        PPObject value = toEntity(dto, true);
        value.id = dto.id.length ? dto.id : createCode(dto.objectType);

        if (!PPValidator.isValid(value)) {
            return CommandResult(false, "", "objectType and one of name/materialId are required");
        }

        if (!repository.create(value)) {
            return CommandResult(false, "", "Object already exists");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(PPObjectDTO dto) {
        auto current = repository.getByTypeAndId(dto.objectType, dto.id);
        if (current is null) {
            return CommandResult(false, "", "Object not found");
        }

        PPObject value = cloneObject(*current);
        if (dto.plantId.length) value.plantId = dto.plantId;
        if (dto.materialId.length) value.materialId = dto.materialId;
        if (dto.orderId.length) value.orderId = dto.orderId;
        if (dto.name.length) value.name = dto.name;
        if (dto.status.length) value.status = dto.status;
        if (dto.description.length) value.description = dto.description;
        if (dto.startDate.length) value.startDate = dto.startDate;
        if (dto.endDate.length) value.endDate = dto.endDate;
        if (dto.quantity.length) value.quantity = dto.quantity;
        if (dto.uom.length) value.uom = dto.uom;
        if (dto.priority.length) value.priority = dto.priority;
        if (dto.attributes.length) value.attributes = dto.attributes;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!repository.update(value)) {
            return CommandResult(false, "", "Object not found");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult remove(string objectType, string id) {
        if (!repository.remove(objectType, id)) {
            return CommandResult(false, "", "Object not found");
        }
        return CommandResult(true, id, "");
    }

    private PPObject toEntity(PPObjectDTO dto, bool isCreate) {
        auto now = Clock.currTime().toISOExtString();

        PPObject value;
        value.id = dto.id;
        value.objectType = dto.objectType;
        value.tenantId = dto.tenantId;
        value.plantId = dto.plantId;
        value.materialId = dto.materialId;
        value.orderId = dto.orderId;
        value.name = dto.name;
        value.status = dto.status.length ? dto.status : "active";
        value.description = dto.description;
        value.startDate = dto.startDate;
        value.endDate = dto.endDate;
        value.quantity = dto.quantity;
        value.uom = dto.uom;
        value.priority = dto.priority;
        value.createdBy = dto.createdBy;
        value.modifiedBy = dto.modifiedBy;
        value.createdAt = isCreate ? now : "";
        value.modifiedAt = now;
        value.attributes = dto.attributes;
        return value;
    }

    private PPObject cloneObject(in PPObject source) {
        PPObject copy;
        copy.id = source.id;
        copy.objectType = source.objectType;
        copy.tenantId = source.tenantId;
        copy.plantId = source.plantId;
        copy.materialId = source.materialId;
        copy.orderId = source.orderId;
        copy.name = source.name;
        copy.status = source.status;
        copy.description = source.description;
        copy.startDate = source.startDate;
        copy.endDate = source.endDate;
        copy.quantity = source.quantity;
        copy.uom = source.uom;
        copy.priority = source.priority;
        copy.createdBy = source.createdBy;
        copy.modifiedBy = source.modifiedBy;
        copy.createdAt = source.createdAt;
        copy.modifiedAt = source.modifiedAt;
        copy.attributes = source.attributes.dup;
        return copy;
    }

    private string createCode(string objectType) {
        auto prefix = objectType.length ? objectType[0 .. 1] : "P";
        return prefix ~ "-" ~ to!string(Clock.currTime().stdTime);
    }
}

unittest {
    import uim.platform.pp.infrastructure.persistence.memory.pp_repository : MemoryPPRepository;

    auto repo = new MemoryPPRepository();
    auto uc = new ManagePPObjectsUseCase(repo);

    PPObjectDTO dto;
    dto.objectType = "materials";
    dto.name = "MAT-100";
    dto.plantId = "PL01";
    dto.createdBy = "planner";

    auto created = uc.create(dto);
    assert(created.success);

    auto loaded = uc.get_("materials", created.id);
    assert(loaded !is null);

    dto.id = created.id;
    dto.objectType = "materials";
    dto.description = "Updated";
    auto updated = uc.update(dto);
    assert(updated.success);

    auto deleted = uc.remove("materials", created.id);
    assert(deleted.success);
}
