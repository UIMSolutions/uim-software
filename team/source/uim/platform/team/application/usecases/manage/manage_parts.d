module uim.platform.team.application.usecases.manage.manage_parts;

import std.conv : to;
import uim.platform.team;

@safe:

class ManagePartsUseCase : UIMUseCase {
    private PartRepository repo;

    this(PartRepository repo) { this.repo = repo; }

    Part[] listByTenant(TenantId tenantId) {
        if (tenantId.length == 0) return repo.findAll();
        return repo.findByTenant(tenantId);
    }

    Part* get_(PartId id) { return repo.findById(id); }

    CommandResult create(PartDTO dto) {
        if (dto.number.length == 0 || dto.name.length == 0)
            return CommandResult(false, "", "Part number and name are required");

        Part part;
        part.id = dto.id.length > 0 ? dto.id : "part-" ~ to!string(repo.findAll().length + 1);
        part.tenantId = dto.tenantId;
        part.number = dto.number;
        part.name = dto.name;
        part.description = dto.description;
        part.revision = dto.revision;
        part.lifecycleState = ChangePolicy.parsePartLifecycleState(dto.lifecycleState);
        part.owningOrganization = dto.owningOrganization;
        part.responsibleEngineer = dto.responsibleEngineer;
        part.materialClass = dto.materialClass;
        part.unitOfMeasure = dto.unitOfMeasure;
        part.createdBy = dto.createdBy;
        part.modifiedBy = dto.modifiedBy;
        part.createdAt = dto.createdAt;
        part.modifiedAt = dto.modifiedAt;

        repo.save(part);
        return CommandResult(true, part.id, "");
    }

    CommandResult update(PartDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Part not found");

        if (dto.number.length > 0) existing.number = dto.number;
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.revision.length > 0) existing.revision = dto.revision;
        if (dto.lifecycleState.length > 0)
            existing.lifecycleState = ChangePolicy.parsePartLifecycleState(dto.lifecycleState, existing.lifecycleState);
        if (dto.owningOrganization.length > 0) existing.owningOrganization = dto.owningOrganization;
        if (dto.responsibleEngineer.length > 0) existing.responsibleEngineer = dto.responsibleEngineer;
        if (dto.materialClass.length > 0) existing.materialClass = dto.materialClass;
        if (dto.unitOfMeasure.length > 0) existing.unitOfMeasure = dto.unitOfMeasure;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(PartId id) {
        if (repo.findById(id) is null)
            return CommandResult(false, "", "Part not found");

        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
