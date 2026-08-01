module uim.platform.mm.infrastructure.persistence.memory;

import std.algorithm : remove;
import uim.platform.mm;

@safe:

class MemoryMaterialRepository : MaterialRepository {
    private Material[] store;

    Material[] findAll() { return store; }
    @trusted Material* findById(MaterialId id) {
        foreach (idx, ref item; store) if (item.id == id) return &store[idx];
        return null;
    }
    void save(Material value) { store ~= value; }
    void update(Material value) { foreach (ref item; store) if (item.id == value.id) { item = value; return; } }
    void remove(MaterialId id) { store = store.remove!(item => item.id == id); }
}

class MemoryPlantRepository : PlantRepository {
    private Plant[] store;

    Plant[] findAll() { return store; }
    @trusted Plant* findById(PlantId id) {
        foreach (idx, ref item; store) if (item.id == id) return &store[idx];
        return null;
    }
    void save(Plant value) { store ~= value; }
    void update(Plant value) { foreach (ref item; store) if (item.id == value.id) { item = value; return; } }
    void remove(PlantId id) { store = store.remove!(item => item.id == id); }
}

class MemoryStorageLocationRepository : StorageLocationRepository {
    private StorageLocation[] store;

    StorageLocation[] findAll() { return store; }
    @trusted StorageLocation* findById(StorageLocationId id) {
        foreach (idx, ref item; store) if (item.id == id) return &store[idx];
        return null;
    }
    void save(StorageLocation value) { store ~= value; }
    void update(StorageLocation value) { foreach (ref item; store) if (item.id == value.id) { item = value; return; } }
    void remove(StorageLocationId id) { store = store.remove!(item => item.id == id); }
}

class MemoryVendorRepository : VendorRepository {
    private SupplierVendor[] store;

    SupplierVendor[] findAll() { return store; }
    @trusted SupplierVendor* findById(VendorId id) {
        foreach (idx, ref item; store) if (item.id == id) return &store[idx];
        return null;
    }
    void save(SupplierVendor value) { store ~= value; }
    void update(SupplierVendor value) { foreach (ref item; store) if (item.id == value.id) { item = value; return; } }
    void remove(VendorId id) { store = store.remove!(item => item.id == id); }
}

class MemoryPurchasingInfoRecordRepository : PurchasingInfoRecordRepository {
    private PurchasingInfoRecord[] store;

    PurchasingInfoRecord[] findAll() { return store; }
    @trusted PurchasingInfoRecord* findById(PurchasingInfoRecordId id) {
        foreach (idx, ref item; store) if (item.id == id) return &store[idx];
        return null;
    }
    void save(PurchasingInfoRecord value) { store ~= value; }
    void update(PurchasingInfoRecord value) { foreach (ref item; store) if (item.id == value.id) { item = value; return; } }
    void remove(PurchasingInfoRecordId id) { store = store.remove!(item => item.id == id); }
}

class MemoryPurchaseRequisitionRepository : PurchaseRequisitionRepository {
    private PurchaseRequisition[] store;

    PurchaseRequisition[] findAll() { return store; }
    @trusted PurchaseRequisition* findById(PurchaseRequisitionId id) {
        foreach (idx, ref item; store) if (item.id == id) return &store[idx];
        return null;
    }
    void save(PurchaseRequisition value) { store ~= value; }
    void update(PurchaseRequisition value) { foreach (ref item; store) if (item.id == value.id) { item = value; return; } }
    void remove(PurchaseRequisitionId id) { store = store.remove!(item => item.id == id); }
}

class MemoryPurchaseOrderRepository : PurchaseOrderRepository {
    private PurchaseOrder[] store;

    PurchaseOrder[] findAll() { return store; }
    @trusted PurchaseOrder* findById(PurchaseOrderId id) {
        foreach (idx, ref item; store) if (item.id == id) return &store[idx];
        return null;
    }
    void save(PurchaseOrder value) { store ~= value; }
    void update(PurchaseOrder value) { foreach (ref item; store) if (item.id == value.id) { item = value; return; } }
    void remove(PurchaseOrderId id) { store = store.remove!(item => item.id == id); }
}

class MemoryGoodsReceiptRepository : GoodsReceiptRepository {
    private GoodsReceipt[] store;

    GoodsReceipt[] findAll() { return store; }
    @trusted GoodsReceipt* findById(GoodsReceiptId id) {
        foreach (idx, ref item; store) if (item.id == id) return &store[idx];
        return null;
    }
    void save(GoodsReceipt value) { store ~= value; }
    void remove(GoodsReceiptId id) { store = store.remove!(item => item.id == id); }
}

class MemoryStockItemRepository : StockItemRepository {
    private StockItem[] store;

    StockItem[] findAll() { return store; }
    @trusted StockItem* findById(StockItemId id) {
        foreach (idx, ref item; store) if (item.id == id) return &store[idx];
        return null;
    }

    @trusted StockItem* findByMaterialLocation(MaterialId materialId, PlantId plantId, StorageLocationId storageLocationId) {
        foreach (idx, ref item; store) {
            if (item.materialId == materialId && item.plantId == plantId && item.storageLocationId == storageLocationId) {
                return &store[idx];
            }
        }
        return null;
    }

    void save(StockItem value) { store ~= value; }
    void update(StockItem value) { foreach (ref item; store) if (item.id == value.id) { item = value; return; } }
    void remove(StockItemId id) { store = store.remove!(item => item.id == id); }
}