module uim.platform.mm.domain.repositories;

import uim.platform.mm.domain.entities;
import uim.platform.mm.domain.types;

@safe:

interface MaterialRepository {
    Material[] findAll();
    Material* findById(MaterialId id);
    void save(Material value);
    void update(Material value);
    void remove(MaterialId id);
}

interface PlantRepository {
    Plant[] findAll();
    Plant* findById(PlantId id);
    void save(Plant value);
    void update(Plant value);
    void remove(PlantId id);
}

interface StorageLocationRepository {
    StorageLocation[] findAll();
    StorageLocation* findById(StorageLocationId id);
    void save(StorageLocation value);
    void update(StorageLocation value);
    void remove(StorageLocationId id);
}

interface VendorRepository {
    SupplierVendor[] findAll();
    SupplierVendor* findById(VendorId id);
    void save(SupplierVendor value);
    void update(SupplierVendor value);
    void remove(VendorId id);
}

interface PurchasingInfoRecordRepository {
    PurchasingInfoRecord[] findAll();
    PurchasingInfoRecord* findById(PurchasingInfoRecordId id);
    void save(PurchasingInfoRecord value);
    void update(PurchasingInfoRecord value);
    void remove(PurchasingInfoRecordId id);
}

interface PurchaseRequisitionRepository {
    PurchaseRequisition[] findAll();
    PurchaseRequisition* findById(PurchaseRequisitionId id);
    void save(PurchaseRequisition value);
    void update(PurchaseRequisition value);
    void remove(PurchaseRequisitionId id);
}

interface PurchaseOrderRepository {
    PurchaseOrder[] findAll();
    PurchaseOrder* findById(PurchaseOrderId id);
    void save(PurchaseOrder value);
    void update(PurchaseOrder value);
    void remove(PurchaseOrderId id);
}

interface GoodsReceiptRepository {
    GoodsReceipt[] findAll();
    GoodsReceipt* findById(GoodsReceiptId id);
    void save(GoodsReceipt value);
    void remove(GoodsReceiptId id);
}

interface StockItemRepository {
    StockItem[] findAll();
    StockItem* findById(StockItemId id);
    StockItem* findByMaterialLocation(MaterialId materialId, PlantId plantId, StorageLocationId storageLocationId);
    void save(StockItem value);
    void update(StockItem value);
    void remove(StockItemId id);
}