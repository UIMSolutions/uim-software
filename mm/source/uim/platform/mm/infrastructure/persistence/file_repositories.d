module uim.platform.mm.infrastructure.persistence.file_repositories;

import std.file : exists, mkdirRecurse, readText, rmdirRecurse, write;
import std.path : buildPath, dirName;

import vibe.data.json : deserializeJson, parseJsonString, serializeToJsonString;

import uim.platform.mm;

@safe:

private T[] loadStore(T)(string path) {
    if (!exists(path)) {
        return [];
    }

    try {
        auto raw = readText(path);
        if (raw.length == 0) {
            return [];
        }

        auto parsed = parseJsonString(raw);
        return deserializeJson!(T[])(parsed);
    } catch (Exception ex) {
        return [];
    }
}

private void saveStore(T)(string path, T[] data) {
    auto parent = dirName(path);
    if (parent.length > 0 && !exists(parent)) {
        mkdirRecurse(parent);
    }

    write(path, serializeToJsonString(data));
}

class FilePurchaseRequisitionRepository : PurchaseRequisitionRepository {
    private PurchaseRequisition[] store;
    private string dbPath;

    this(string basePath) {
        dbPath = buildPath(basePath, "purchase_requisitions.json");
        store = loadStore!PurchaseRequisition(dbPath);
    }

    PurchaseRequisition[] findAll() { return store; }

    private @trusted PurchaseRequisition* ptr(PurchaseRequisitionId id) {
        foreach (idx, ref value; store) if (value.id == id) return &store[idx];
        return null;
    }

    PurchaseRequisition* findById(PurchaseRequisitionId id) { return ptr(id); }

    void save(PurchaseRequisition value) {
        store ~= value;
        saveStore(dbPath, store);
    }

    void update(PurchaseRequisition value) {
        auto current = ptr(value.id);
        if (current !is null) {
            *current = value;
            saveStore(dbPath, store);
        }
    }

    void remove(PurchaseRequisitionId id) {
        foreach (idx, ref value; store) {
            if (value.id == id) {
                store = store[0 .. idx] ~ store[idx + 1 .. $];
                saveStore(dbPath, store);
                break;
            }
        }
    }
}

class FilePurchaseOrderRepository : PurchaseOrderRepository {
    private PurchaseOrder[] store;
    private string dbPath;

    this(string basePath) {
        dbPath = buildPath(basePath, "purchase_orders.json");
        store = loadStore!PurchaseOrder(dbPath);
    }

    PurchaseOrder[] findAll() { return store; }

    private @trusted PurchaseOrder* ptr(PurchaseOrderId id) {
        foreach (idx, ref value; store) if (value.id == id) return &store[idx];
        return null;
    }

    PurchaseOrder* findById(PurchaseOrderId id) { return ptr(id); }

    void save(PurchaseOrder value) {
        store ~= value;
        saveStore(dbPath, store);
    }

    void update(PurchaseOrder value) {
        auto current = ptr(value.id);
        if (current !is null) {
            *current = value;
            saveStore(dbPath, store);
        }
    }

    void remove(PurchaseOrderId id) {
        foreach (idx, ref value; store) {
            if (value.id == id) {
                store = store[0 .. idx] ~ store[idx + 1 .. $];
                saveStore(dbPath, store);
                break;
            }
        }
    }
}

class FileGoodsReceiptRepository : GoodsReceiptRepository {
    private GoodsReceipt[] store;
    private string dbPath;

    this(string basePath) {
        dbPath = buildPath(basePath, "goods_receipts.json");
        store = loadStore!GoodsReceipt(dbPath);
    }

    GoodsReceipt[] findAll() { return store; }

    private @trusted GoodsReceipt* ptr(GoodsReceiptId id) {
        foreach (idx, ref value; store) if (value.id == id) return &store[idx];
        return null;
    }

    GoodsReceipt* findById(GoodsReceiptId id) { return ptr(id); }

    void save(GoodsReceipt value) {
        store ~= value;
        saveStore(dbPath, store);
    }

    void remove(GoodsReceiptId id) {
        foreach (idx, ref value; store) {
            if (value.id == id) {
                store = store[0 .. idx] ~ store[idx + 1 .. $];
                saveStore(dbPath, store);
                break;
            }
        }
    }
}

class FileStockItemRepository : StockItemRepository {
    private StockItem[] store;
    private string dbPath;

    this(string basePath) {
        dbPath = buildPath(basePath, "stock_items.json");
        store = loadStore!StockItem(dbPath);
    }

    StockItem[] findAll() { return store; }

    private @trusted StockItem* ptr(StockItemId id) {
        foreach (idx, ref value; store) if (value.id == id) return &store[idx];
        return null;
    }

    StockItem* findById(StockItemId id) { return ptr(id); }

    @trusted StockItem* findByMaterialLocation(
        MaterialId materialId,
        PlantId plantId,
        StorageLocationId storageLocationId
    ) {
        foreach (idx, ref value; store) {
            if (
                value.materialId == materialId &&
                value.plantId == plantId &&
                value.storageLocationId == storageLocationId
            ) {
                return &store[idx];
            }
        }
        return null;
    }

    void save(StockItem value) {
        store ~= value;
        saveStore(dbPath, store);
    }

    void update(StockItem value) {
        auto current = ptr(value.id);
        if (current !is null) {
            *current = value;
            saveStore(dbPath, store);
        }
    }

    void remove(StockItemId id) {
        foreach (idx, ref value; store) {
            if (value.id == id) {
                store = store[0 .. idx] ~ store[idx + 1 .. $];
                saveStore(dbPath, store);
                break;
            }
        }
    }
}

unittest {
    auto basePath = ".tmp/mm-file-repo-test";
    if (exists(basePath)) {
        rmdirRecurse(basePath);
    }

    auto orderRepo = new FilePurchaseOrderRepository(basePath);
    auto receiptRepo = new FileGoodsReceiptRepository(basePath);
    auto stockRepo = new FileStockItemRepository(basePath);

    PurchaseOrder order;
    order.id = "PO-FILE-1";
    order.tenantId = "TEN-1";
    order.vendorId = "VEN-1";
    order.plantId = "PLANT-1";
    order.lineMaterialId = "MAT-1";
    order.lineQuantity = "12";
    order.receivedQuantity = "3";
    order.unit = "EA";
    order.netPrice = "42";
    orderRepo.save(order);

    GoodsReceipt receipt;
    receipt.id = "GR-FILE-1";
    receipt.tenantId = "TEN-1";
    receipt.purchaseOrderId = "PO-FILE-1";
    receipt.materialId = "MAT-1";
    receipt.plantId = "PLANT-1";
    receipt.storageLocationId = "SL-1";
    receipt.quantity = "9";
    receiptRepo.save(receipt);

    StockItem stock;
    stock.id = "STOCK-1";
    stock.tenantId = "TEN-1";
    stock.materialId = "MAT-1";
    stock.plantId = "PLANT-1";
    stock.storageLocationId = "SL-1";
    stock.unrestrictedUseQty = "9";
    stock.qualityInspectionQty = "0";
    stock.blockedQty = "0";
    stock.openInboundQty = "0";
    stockRepo.save(stock);

    auto orderReloaded = new FilePurchaseOrderRepository(basePath);
    auto receiptReloaded = new FileGoodsReceiptRepository(basePath);
    auto stockReloaded = new FileStockItemRepository(basePath);

    assert(orderReloaded.findById("PO-FILE-1") !is null);
    assert(orderReloaded.findById("PO-FILE-1").receivedQuantity == "3");
    assert(receiptReloaded.findById("GR-FILE-1") !is null);
    assert(stockReloaded.findByMaterialLocation("MAT-1", "PLANT-1", "SL-1") !is null);

    if (exists(basePath)) {
        rmdirRecurse(basePath);
    }
}