module uim.platform.mrp.application.usecases.manage.manage_materials;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class ManageMaterialsUseCase : UIMUseCase {
    private MaterialRepository repo;

    this(MaterialRepository repo) {
        this.repo = repo;
    }

    Material* get_(MaterialId id) {
        return repo.findById(id);
    }

    Material[] list() {
        return repo.findAll();
    }

    Material[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    Material[] listByPlant(PlantId plantId) {
        return repo.findByPlant(plantId);
    }

    CommandResult create(MaterialDTO dto) {
        Material m;
        m.id = dto.id;
        m.tenantId = dto.tenantId;
        m.plantId = dto.plantId;
        m.name = dto.name;
        m.description = dto.description;
        m.materialNumber = dto.materialNumber;
        m.baseUnit = dto.baseUnit;
        m.safetyStock = dto.safetyStock;
        m.reorderPoint = dto.reorderPoint;
        m.lotSize = dto.lotSize;
        m.minimumLotSize = dto.minimumLotSize;
        m.independentDemand = dto.independentDemand;
        m.planningTimeFenceDays = dto.planningTimeFenceDays;
        m.inHouseProductionTimeDays = dto.inHouseProductionTimeDays;
        m.plannedDeliveryTimeDays = dto.plannedDeliveryTimeDays;
        m.grProcessingTimeDays = dto.grProcessingTimeDays;
        m.mrpProcedure = parseEnumValue!MRPProcedure(dto.mrpProcedure, MRPProcedure.materialRequirementsPlanning);
        m.lotSizingProcedure = parseEnumValue!LotSizingProcedure(dto.lotSizingProcedure, LotSizingProcedure.lotForLot);
        m.procurementType = parseEnumValue!ProcurementType(dto.procurementType, ProcurementType.both);
        m.status = parseEnumValue!MaterialStatus(dto.status, MaterialStatus.active);
        m.createdBy = dto.createdBy;

        if (!MRPValidator.isValidMaterial(m))
            return CommandResult(false, "", "Invalid material data");

        repo.save(m);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(MaterialDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Material not found");

        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.materialNumber.length > 0) existing.materialNumber = dto.materialNumber;
        if (dto.baseUnit.length > 0) existing.baseUnit = dto.baseUnit;
        if (dto.safetyStock.length > 0) existing.safetyStock = dto.safetyStock;
        if (dto.reorderPoint.length > 0) existing.reorderPoint = dto.reorderPoint;
        if (dto.lotSize.length > 0) existing.lotSize = dto.lotSize;
        if (dto.minimumLotSize.length > 0) existing.minimumLotSize = dto.minimumLotSize;
        if (dto.independentDemand.length > 0) existing.independentDemand = dto.independentDemand;
        if (dto.mrpProcedure.length > 0)
            existing.mrpProcedure = parseEnumValue!MRPProcedure(
                dto.mrpProcedure,
                existing.mrpProcedure
            );
        if (dto.lotSizingProcedure.length > 0)
            existing.lotSizingProcedure = parseEnumValue!LotSizingProcedure(
                dto.lotSizingProcedure,
                existing.lotSizingProcedure
            );
        if (dto.procurementType.length > 0)
            existing.procurementType = parseEnumValue!ProcurementType(
                dto.procurementType,
                existing.procurementType
            );
        if (dto.status.length > 0) existing.status = parseEnumValue!MaterialStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MaterialId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Material not found");
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
