module uim.platform.mrp.application.usecases.manage.manage_inventory_positions;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class ManageInventoryPositionsUseCase : UIMUseCase {
    private InventoryPositionRepository repo;

    this(InventoryPositionRepository repo) {
        this.repo = repo;
    }

    InventoryPosition* get_(InventoryPositionId id) { return repo.findById(id); }
    InventoryPosition[] list() { return repo.findAll(); }
    InventoryPosition[] listByPlant(PlantId plantId) { return repo.findByPlant(plantId); }

    CommandResult create(InventoryPositionDTO dto) {
        InventoryPosition i;
        i.id = dto.id;
        i.tenantId = dto.tenantId;
        i.plantId = dto.plantId;
        i.materialId = dto.materialId;
        i.stockSegment = parseEnumValue!StockSegment(dto.stockSegment, StockSegment.unrestricted);
        i.storageLocation = dto.storageLocation;
        i.onHandQuantity = dto.onHandQuantity;
        i.scheduledReceipts = dto.scheduledReceipts;
        i.reservedQuantity = dto.reservedQuantity;
        i.openPurchaseOrders = dto.openPurchaseOrders;
        i.openProductionOrders = dto.openProductionOrders;
        i.snapshotDate = dto.snapshotDate;
        i.createdBy = dto.createdBy;

        if (!MRPValidator.isValidInventoryPosition(i))
            return CommandResult(false, "", "Invalid inventory position data");

        repo.save(i);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(InventoryPositionDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Inventory position not found");

        if (dto.storageLocation.length > 0) existing.storageLocation = dto.storageLocation;
        if (dto.onHandQuantity.length > 0) existing.onHandQuantity = dto.onHandQuantity;
        if (dto.scheduledReceipts.length > 0) existing.scheduledReceipts = dto.scheduledReceipts;
        if (dto.reservedQuantity.length > 0) existing.reservedQuantity = dto.reservedQuantity;
        if (dto.openPurchaseOrders.length > 0) existing.openPurchaseOrders = dto.openPurchaseOrders;
        if (dto.openProductionOrders.length > 0) existing.openProductionOrders = dto.openProductionOrders;
        if (dto.snapshotDate.length > 0) existing.snapshotDate = dto.snapshotDate;
        if (dto.stockSegment.length > 0)
            existing.stockSegment = parseEnumValue!StockSegment(
                dto.stockSegment,
                existing.stockSegment
            );
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(InventoryPositionId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Inventory position not found");
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
