module uim.platform.mrp.application.usecases.manage.manage_plants;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class ManagePlantsUseCase : UIMUseCase {
    private PlantRepository repo;

    this(PlantRepository repo) {
        this.repo = repo;
    }

    Plant* get_(PlantId id) { return repo.findById(id); }
    Plant[] list() { return repo.findAll(); }
    Plant[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }

    CommandResult create(PlantDTO dto) {
        Plant p;
        p.id = dto.id;
        p.tenantId = dto.tenantId;
        p.name = dto.name;
        p.description = dto.description;
        p.plantCode = dto.plantCode;
        p.mrpAreas = dto.mrpAreas;
        p.companyCode = dto.companyCode;
        p.country = dto.country;
        p.timezone = dto.timezone;
        p.planningScope = parseEnumValue!PlanningScope(dto.planningScope, PlanningScope.plant);
        p.createdBy = dto.createdBy;

        if (!MRPValidator.isValidPlant(p))
            return CommandResult(false, "", "Invalid plant data");

        repo.save(p);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(PlantDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Plant not found");

        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.plantCode.length > 0) existing.plantCode = dto.plantCode;
        if (dto.mrpAreas.length > 0) existing.mrpAreas = dto.mrpAreas;
        if (dto.companyCode.length > 0) existing.companyCode = dto.companyCode;
        if (dto.country.length > 0) existing.country = dto.country;
        if (dto.timezone.length > 0) existing.timezone = dto.timezone;
        if (dto.planningScope.length > 0)
            existing.planningScope = parseEnumValue!PlanningScope(
                dto.planningScope,
                existing.planningScope
            );
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(PlantId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Plant not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }

    private static T parseEnumValue(T)(string raw, T fallback) {
        import std.conv : to;

        if (raw.length == 0) {
            return fallback;
        }

        try {
            return raw.to!T;
        } catch (Exception e) {
            return fallback;
        }
    }
}
