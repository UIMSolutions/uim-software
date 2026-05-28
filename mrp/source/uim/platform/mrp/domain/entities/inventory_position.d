/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.mrp.domain.entities.inventory_position;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

struct InventoryPosition {
    InventoryPositionId id;
    TenantId tenantId;
    PlantId plantId;
    MaterialId materialId;
    StockSegment stockSegment = StockSegment.unrestricted;
    string storageLocation;
    string onHandQuantity;
    string scheduledReceipts;
    string reservedQuantity;
    string openPurchaseOrders;
    string openProductionOrders;
    string snapshotDate;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
