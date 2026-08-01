module uim.platform.mm.domain.types;

alias MaterialId = string;
alias PlantId = string;
alias StorageLocationId = string;
alias VendorId = string;
alias PurchasingInfoRecordId = string;
alias PurchaseRequisitionId = string;
alias PurchaseOrderId = string;
alias GoodsReceiptId = string;
alias StockItemId = string;
alias TenantId = string;
alias UserId = string;

enum MaterialType {
    rawMaterial,
    semiFinished,
    finished,
    consumable,
    tradingGoods
}

enum MaterialStatus {
    active,
    blocked,
    discontinued
}

enum PurchaseRequisitionStatus {
    open,
    released,
    converted,
    closed,
    cancelled
}

enum PurchaseOrderStatus {
    created,
    released,
    partiallyReceived,
    received,
    closed,
    cancelled
}

enum MovementType {
    goodsReceipt,
    returnToVendor,
    transferPosting
}