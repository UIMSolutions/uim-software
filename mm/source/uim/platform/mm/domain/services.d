module uim.platform.mm.domain.services;

import std.conv : to;
import uim.platform.mm.domain.entities;

struct MaterialManagementValidator {
    static bool isValidMaterial(in Material value) {
        return value.id.length > 0 &&
            value.tenantId.length > 0 &&
            value.materialNumber.length > 0 &&
            value.description.length > 0 &&
            value.baseUnit.length > 0;
    }

    static bool isValidPlant(in Plant value) {
        return value.id.length > 0 &&
            value.tenantId.length > 0 &&
            value.plantCode.length > 0 &&
            value.name.length > 0;
    }

    static bool isValidStorageLocation(in StorageLocation value) {
        return value.id.length > 0 &&
            value.tenantId.length > 0 &&
            value.plantId.length > 0 &&
            value.storageLocationCode.length > 0;
    }

    static bool isValidVendor(in SupplierVendor value) {
        return value.id.length > 0 &&
            value.tenantId.length > 0 &&
            value.vendorNumber.length > 0 &&
            value.name.length > 0;
    }

    static bool isValidPurchasingInfoRecord(in PurchasingInfoRecord value) {
        return value.id.length > 0 &&
            value.tenantId.length > 0 &&
            value.materialId.length > 0 &&
            value.vendorId.length > 0 &&
            value.plantId.length > 0 &&
            parseNumber(value.netPrice, -1) >= 0 &&
            parseNumber(value.minimumOrderQuantity, 0) >= 0;
    }

    static bool isValidPurchaseRequisition(in PurchaseRequisition value) {
        return value.id.length > 0 &&
            value.tenantId.length > 0 &&
            value.materialId.length > 0 &&
            value.plantId.length > 0 &&
            value.storageLocationId.length > 0 &&
            parseNumber(value.quantity, -1) > 0 &&
            value.unit.length > 0;
    }

    static bool isValidPurchaseOrder(in PurchaseOrder value) {
        return value.id.length > 0 &&
            value.tenantId.length > 0 &&
            value.vendorId.length > 0 &&
            value.plantId.length > 0 &&
            value.lineMaterialId.length > 0 &&
            parseNumber(value.lineQuantity, -1) > 0 &&
            parseNumber(value.netPrice, -1) >= 0;
    }

    static bool isValidGoodsReceipt(in GoodsReceipt value) {
        return value.id.length > 0 &&
            value.tenantId.length > 0 &&
            value.purchaseOrderId.length > 0 &&
            value.materialId.length > 0 &&
            value.plantId.length > 0 &&
            value.storageLocationId.length > 0 &&
            parseNumber(value.quantity, -1) > 0;
    }

    static bool isValidStockItem(in StockItem value) {
        return value.id.length > 0 &&
            value.tenantId.length > 0 &&
            value.materialId.length > 0 &&
            value.plantId.length > 0 &&
            value.storageLocationId.length > 0;
    }

    static double parseNumber(string raw, double fallback = 0) {
        if (raw.length == 0) {
            return fallback;
        }

        try {
            return raw.to!double;
        } catch (Exception e) {
            return fallback;
        }
    }
}