module uim.platform.team.application.usecases.manage.manage_boms;

import std.conv : to;
import uim.platform.team;

@safe:

class ManageBomsUseCase : UIMUseCase {
    private BomRepository repo;
    private PartRepository partRepo;

    this(BomRepository repo, PartRepository partRepo) {
        this.repo = repo;
        this.partRepo = partRepo;
    }

    Bom[] listByTenant(TenantId tenantId) {
        if (tenantId.length == 0) return repo.findAll();
        return repo.findByTenant(tenantId);
    }

    Bom* get_(BomId id) { return repo.findById(id); }

    CommandResult create(BomDTO dto) {
        if (partRepo.findById(dto.parentPartId) is null)
            return CommandResult(false, "", "Parent part not found");

        Bom bom;
        bom.id = dto.id.length > 0 ? dto.id : "bom-" ~ to!string(repo.findAll().length + 1);
        bom.tenantId = dto.tenantId;
        bom.parentPartId = dto.parentPartId;
        bom.name = dto.name;
        bom.revision = dto.revision;
        foreach (lineDto; dto.lines) {
            BomLine line;
            line.childPartId = lineDto.childPartId;
            line.quantity = lineDto.quantity.length > 0 ? to!long(lineDto.quantity) : 1;
            line.unitOfMeasure = lineDto.unitOfMeasure;
            line.findNumber = lineDto.findNumber;
            line.effectivity = lineDto.effectivity;
            bom.lines ~= line;
        }
        bom.createdBy = dto.createdBy;
        bom.modifiedBy = dto.modifiedBy;
        bom.createdAt = dto.createdAt;
        bom.modifiedAt = dto.modifiedAt;

        repo.save(bom);
        return CommandResult(true, bom.id, "");
    }

    CommandResult update(BomDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "BOM not found");

        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.revision.length > 0) existing.revision = dto.revision;
        if (dto.lines.length > 0) {
            existing.lines.length = 0;
            foreach (lineDto; dto.lines) {
                BomLine line;
                line.childPartId = lineDto.childPartId;
                line.quantity = lineDto.quantity.length > 0 ? to!long(lineDto.quantity) : 1;
                line.unitOfMeasure = lineDto.unitOfMeasure;
                line.findNumber = lineDto.findNumber;
                line.effectivity = lineDto.effectivity;
                existing.lines ~= line;
            }
        }
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(BomId id) {
        if (repo.findById(id) is null)
            return CommandResult(false, "", "BOM not found");

        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
