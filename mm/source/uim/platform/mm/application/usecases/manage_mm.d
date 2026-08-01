module uim.platform.mm.application.usecases.manage_mm;

import std.conv : to;
import uim.platform.mm;

@safe:

class ManageMaterialsUseCase : UIMUseCase {
    private MaterialRepository repo;

    this(MaterialRepository repo) { this.repo = repo; }

    Material[] list() { return repo.findAll(); }
    Material* get_(MaterialId id) { return repo.findById(id); }

    CommandResult create(MaterialDTO dto) {
        Material value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.materialNumber = dto.materialNumber;
        value.description = dto.description;
        value.baseUnit = dto.baseUnit;
        value.materialType = parseEnumValue!MaterialType(dto.materialType, MaterialType.rawMaterial);
        value.materialGroup = dto.materialGroup;
        value.valuationClass = dto.valuationClass;
        value.status = parseEnumValue!MaterialStatus(dto.status, MaterialStatus.active);
        value.createdBy = dto.createdBy;
        value.modifiedBy = dto.modifiedBy;
        value.createdAt = dto.createdAt;
        value.modifiedAt = dto.modifiedAt;

        if (!MaterialManagementValidator.isValidMaterial(value)) {
            return CommandResult(false, "", "Invalid material data");
        }

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(MaterialDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Material not found");

        patchMaterial(*existing, dto);
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MaterialId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Material not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }

    private void patchMaterial(ref Material value, in MaterialDTO dto) {
        if (dto.materialNumber.length > 0) value.materialNumber = dto.materialNumber;
        if (dto.description.length > 0) value.description = dto.description;
        if (dto.baseUnit.length > 0) value.baseUnit = dto.baseUnit;
        if (dto.materialType.length > 0) value.materialType = parseEnumValue!MaterialType(dto.materialType, value.materialType);
        if (dto.materialGroup.length > 0) value.materialGroup = dto.materialGroup;
        if (dto.valuationClass.length > 0) value.valuationClass = dto.valuationClass;
        if (dto.status.length > 0) value.status = parseEnumValue!MaterialStatus(dto.status, value.status);
        if (dto.modifiedBy.length > 0) value.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) value.modifiedAt = dto.modifiedAt;
    }
}

class ManagePlantsUseCase : UIMUseCase {
    private PlantRepository repo;

    this(PlantRepository repo) { this.repo = repo; }

    Plant[] list() { return repo.findAll(); }
    Plant* get_(PlantId id) { return repo.findById(id); }

    CommandResult create(PlantDTO dto) {
        Plant value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.plantCode = dto.plantCode;
        value.name = dto.name;
        value.companyCode = dto.companyCode;
        value.country = dto.country;
        value.purchasingOrg = dto.purchasingOrg;
        value.createdBy = dto.createdBy;
        value.modifiedBy = dto.modifiedBy;
        value.createdAt = dto.createdAt;
        value.modifiedAt = dto.modifiedAt;

        if (!MaterialManagementValidator.isValidPlant(value)) {
            return CommandResult(false, "", "Invalid plant data");
        }

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(PlantDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Plant not found");

        if (dto.plantCode.length > 0) existing.plantCode = dto.plantCode;
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.companyCode.length > 0) existing.companyCode = dto.companyCode;
        if (dto.country.length > 0) existing.country = dto.country;
        if (dto.purchasingOrg.length > 0) existing.purchasingOrg = dto.purchasingOrg;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(PlantId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Plant not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageStorageLocationsUseCase : UIMUseCase {
    private StorageLocationRepository repo;

    this(StorageLocationRepository repo) { this.repo = repo; }

    StorageLocation[] list() { return repo.findAll(); }
    StorageLocation* get_(StorageLocationId id) { return repo.findById(id); }

    CommandResult create(StorageLocationDTO dto) {
        StorageLocation value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.plantId = dto.plantId;
        value.storageLocationCode = dto.storageLocationCode;
        value.name = dto.name;
        value.description = dto.description;
        value.createdBy = dto.createdBy;
        value.modifiedBy = dto.modifiedBy;
        value.createdAt = dto.createdAt;
        value.modifiedAt = dto.modifiedAt;

        if (!MaterialManagementValidator.isValidStorageLocation(value)) {
            return CommandResult(false, "", "Invalid storage location data");
        }

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(StorageLocationDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Storage location not found");

        if (dto.plantId.length > 0) existing.plantId = dto.plantId;
        if (dto.storageLocationCode.length > 0) existing.storageLocationCode = dto.storageLocationCode;
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(StorageLocationId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Storage location not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageVendorsUseCase : UIMUseCase {
    private VendorRepository repo;

    this(VendorRepository repo) { this.repo = repo; }

    SupplierVendor[] list() { return repo.findAll(); }
    SupplierVendor* get_(VendorId id) { return repo.findById(id); }

    CommandResult create(VendorDTO dto) {
        SupplierVendor value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.vendorNumber = dto.vendorNumber;
        value.name = dto.name;
        value.purchasingOrg = dto.purchasingOrg;
        value.currency = dto.currency;
        value.paymentTerms = dto.paymentTerms;
        value.incoterms = dto.incoterms;
        value.createdBy = dto.createdBy;
        value.modifiedBy = dto.modifiedBy;
        value.createdAt = dto.createdAt;
        value.modifiedAt = dto.modifiedAt;

        if (!MaterialManagementValidator.isValidVendor(value)) {
            return CommandResult(false, "", "Invalid vendor data");
        }

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(VendorDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Vendor not found");

        if (dto.vendorNumber.length > 0) existing.vendorNumber = dto.vendorNumber;
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.purchasingOrg.length > 0) existing.purchasingOrg = dto.purchasingOrg;
        if (dto.currency.length > 0) existing.currency = dto.currency;
        if (dto.paymentTerms.length > 0) existing.paymentTerms = dto.paymentTerms;
        if (dto.incoterms.length > 0) existing.incoterms = dto.incoterms;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(VendorId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Vendor not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManagePurchasingInfoRecordsUseCase : UIMUseCase {
    private PurchasingInfoRecordRepository repo;

    this(PurchasingInfoRecordRepository repo) { this.repo = repo; }

    PurchasingInfoRecord[] list() { return repo.findAll(); }
    PurchasingInfoRecord* get_(PurchasingInfoRecordId id) { return repo.findById(id); }

    CommandResult create(PurchasingInfoRecordDTO dto) {
        PurchasingInfoRecord value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.materialId = dto.materialId;
        value.vendorId = dto.vendorId;
        value.plantId = dto.plantId;
        value.purchasingOrg = dto.purchasingOrg;
        value.orderUnit = dto.orderUnit;
        value.netPrice = dto.netPrice;
        value.currency = dto.currency;
        value.leadTimeDays = dto.leadTimeDays;
        value.minimumOrderQuantity = dto.minimumOrderQuantity;
        value.sourceListNote = dto.sourceListNote;
        value.createdBy = dto.createdBy;
        value.modifiedBy = dto.modifiedBy;
        value.createdAt = dto.createdAt;
        value.modifiedAt = dto.modifiedAt;

        if (!MaterialManagementValidator.isValidPurchasingInfoRecord(value)) {
            return CommandResult(false, "", "Invalid purchasing info record data");
        }

        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(PurchasingInfoRecordDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Purchasing info record not found");

        if (dto.materialId.length > 0) existing.materialId = dto.materialId;
        if (dto.vendorId.length > 0) existing.vendorId = dto.vendorId;
        if (dto.plantId.length > 0) existing.plantId = dto.plantId;
        if (dto.purchasingOrg.length > 0) existing.purchasingOrg = dto.purchasingOrg;
        if (dto.orderUnit.length > 0) existing.orderUnit = dto.orderUnit;
        if (dto.netPrice.length > 0) existing.netPrice = dto.netPrice;
        if (dto.currency.length > 0) existing.currency = dto.currency;
        if (dto.leadTimeDays.length > 0) existing.leadTimeDays = dto.leadTimeDays;
        if (dto.minimumOrderQuantity.length > 0) existing.minimumOrderQuantity = dto.minimumOrderQuantity;
        if (dto.sourceListNote.length > 0) existing.sourceListNote = dto.sourceListNote;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(PurchasingInfoRecordId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Purchasing info record not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageProcurementUseCase : UIMUseCase {
    private PurchaseRequisitionRepository requisitionRepo;
    private PurchaseOrderRepository orderRepo;
    private VendorRepository vendorRepo;
    private PurchasingInfoRecordRepository infoRecordRepo;

    this(
        PurchaseRequisitionRepository requisitionRepo,
        PurchaseOrderRepository orderRepo,
        VendorRepository vendorRepo,
        PurchasingInfoRecordRepository infoRecordRepo
    ) {
        this.requisitionRepo = requisitionRepo;
        this.orderRepo = orderRepo;
        this.vendorRepo = vendorRepo;
        this.infoRecordRepo = infoRecordRepo;
    }

    PurchaseRequisition[] listRequisitions() { return requisitionRepo.findAll(); }
    PurchaseRequisition* getRequisition(PurchaseRequisitionId id) { return requisitionRepo.findById(id); }
    PurchaseOrder[] listOrders() { return orderRepo.findAll(); }
    PurchaseOrder* getOrder(PurchaseOrderId id) { return orderRepo.findById(id); }

    CommandResult createRequisition(PurchaseRequisitionDTO dto) {
        PurchaseRequisition value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.materialId = dto.materialId;
        value.plantId = dto.plantId;
        value.storageLocationId = dto.storageLocationId;
        value.quantity = dto.quantity;
        value.unit = dto.unit;
        value.requiredDate = dto.requiredDate;
        value.accountAssignment = dto.accountAssignment;
        value.status = parseEnumValue!PurchaseRequisitionStatus(dto.status, PurchaseRequisitionStatus.open);
        value.requestedBy = dto.requestedBy;
        value.sourceVendorId = dto.sourceVendorId;
        value.createdAt = dto.createdAt;
        value.modifiedAt = dto.modifiedAt;

        if (!MaterialManagementValidator.isValidPurchaseRequisition(value)) {
            return CommandResult(false, "", "Invalid purchase requisition data");
        }

        requisitionRepo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult updateRequisition(PurchaseRequisitionDTO dto) {
        auto existing = requisitionRepo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Purchase requisition not found");

        if (dto.materialId.length > 0) existing.materialId = dto.materialId;
        if (dto.plantId.length > 0) existing.plantId = dto.plantId;
        if (dto.storageLocationId.length > 0) existing.storageLocationId = dto.storageLocationId;
        if (dto.quantity.length > 0) existing.quantity = dto.quantity;
        if (dto.unit.length > 0) existing.unit = dto.unit;
        if (dto.requiredDate.length > 0) existing.requiredDate = dto.requiredDate;
        if (dto.accountAssignment.length > 0) existing.accountAssignment = dto.accountAssignment;
        if (dto.status.length > 0) existing.status = parseEnumValue!PurchaseRequisitionStatus(dto.status, existing.status);
        if (dto.requestedBy.length > 0) existing.requestedBy = dto.requestedBy;
        if (dto.sourceVendorId.length > 0) existing.sourceVendorId = dto.sourceVendorId;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        requisitionRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult removeRequisition(PurchaseRequisitionId id) {
        auto existing = requisitionRepo.findById(id);
        if (existing is null) return CommandResult(false, "", "Purchase requisition not found");
        requisitionRepo.remove(id);
        return CommandResult(true, id, "");
    }

    CommandResult createOrder(PurchaseOrderDTO dto) {
        PurchaseOrder value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.vendorId = dto.vendorId;
        value.plantId = dto.plantId;
        value.purchasingOrg = dto.purchasingOrg;
        value.currency = dto.currency;
        value.status = parseEnumValue!PurchaseOrderStatus(dto.status, PurchaseOrderStatus.created);
        value.referenceRequisitionId = dto.referenceRequisitionId;
        value.orderedBy = dto.orderedBy;
        value.lineMaterialId = dto.lineMaterialId;
        value.lineQuantity = dto.lineQuantity;
        value.receivedQuantity = dto.receivedQuantity.length > 0 ? dto.receivedQuantity : "0";
        value.unit = dto.unit;
        value.netPrice = dto.netPrice;
        value.deliveryDate = dto.deliveryDate;
        value.createdAt = dto.createdAt;
        value.modifiedAt = dto.modifiedAt;

        if (!MaterialManagementValidator.isValidPurchaseOrder(value)) {
            return CommandResult(false, "", "Invalid purchase order data");
        }

        if (vendorRepo.findById(value.vendorId) is null) {
            return CommandResult(false, "", "Vendor not found");
        }

        orderRepo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult updateOrder(PurchaseOrderDTO dto) {
        auto existing = orderRepo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Purchase order not found");

        if (dto.vendorId.length > 0) existing.vendorId = dto.vendorId;
        if (dto.plantId.length > 0) existing.plantId = dto.plantId;
        if (dto.purchasingOrg.length > 0) existing.purchasingOrg = dto.purchasingOrg;
        if (dto.currency.length > 0) existing.currency = dto.currency;
        if (dto.status.length > 0) existing.status = parseEnumValue!PurchaseOrderStatus(dto.status, existing.status);
        if (dto.referenceRequisitionId.length > 0) existing.referenceRequisitionId = dto.referenceRequisitionId;
        if (dto.orderedBy.length > 0) existing.orderedBy = dto.orderedBy;
        if (dto.lineMaterialId.length > 0) existing.lineMaterialId = dto.lineMaterialId;
        if (dto.lineQuantity.length > 0) existing.lineQuantity = dto.lineQuantity;
        if (dto.receivedQuantity.length > 0) existing.receivedQuantity = dto.receivedQuantity;
        if (dto.unit.length > 0) existing.unit = dto.unit;
        if (dto.netPrice.length > 0) existing.netPrice = dto.netPrice;
        if (dto.deliveryDate.length > 0) existing.deliveryDate = dto.deliveryDate;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        orderRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult removeOrder(PurchaseOrderId id) {
        auto existing = orderRepo.findById(id);
        if (existing is null) return CommandResult(false, "", "Purchase order not found");
        orderRepo.remove(id);
        return CommandResult(true, id, "");
    }

    CommandResult convertRequisitionToOrder(PurchaseRequisitionId requisitionId, PurchaseOrderDTO dto) {
        auto requisition = requisitionRepo.findById(requisitionId);
        if (requisition is null) {
            return CommandResult(false, "", "Purchase requisition not found");
        }

        if (requisition.status == PurchaseRequisitionStatus.converted) {
            return CommandResult(false, "", "Purchase requisition already converted");
        }

        auto vendorId = dto.vendorId.length > 0 ? dto.vendorId : requisition.sourceVendorId;
        if (vendorId.length == 0 || vendorRepo.findById(vendorId) is null) {
            return CommandResult(false, "", "Vendor not found");
        }

        auto infoRecord = findInfoRecord(requisition.materialId, vendorId, requisition.plantId);
        PurchaseOrder value;
        value.id = dto.id;
        value.tenantId = dto.tenantId.length > 0 ? dto.tenantId : requisition.tenantId;
        value.vendorId = vendorId;
        value.plantId = requisition.plantId;
        value.purchasingOrg = dto.purchasingOrg.length > 0 ? dto.purchasingOrg : inferPurchasingOrg(infoRecord);
        value.currency = dto.currency.length > 0 ? dto.currency : inferCurrency(infoRecord);
        value.status = PurchaseOrderStatus.created;
        value.referenceRequisitionId = requisition.id;
        value.orderedBy = dto.orderedBy;
        value.lineMaterialId = requisition.materialId;
        value.lineQuantity = requisition.quantity;
        value.receivedQuantity = "0";
        value.unit = requisition.unit;
        value.netPrice = dto.netPrice.length > 0 ? dto.netPrice : inferNetPrice(infoRecord);
        value.deliveryDate = dto.deliveryDate.length > 0 ? dto.deliveryDate : requisition.requiredDate;
        value.createdAt = dto.createdAt;
        value.modifiedAt = dto.modifiedAt;

        if (!MaterialManagementValidator.isValidPurchaseOrder(value)) {
            return CommandResult(false, "", "Invalid purchase order data");
        }

        orderRepo.save(value);
        requisition.status = PurchaseRequisitionStatus.converted;
        requisition.modifiedAt = dto.modifiedAt;
        requisitionRepo.update(*requisition);
        return CommandResult(true, value.id, "");
    }

    private PurchasingInfoRecord* findInfoRecord(MaterialId materialId, VendorId vendorId, PlantId plantId) {
        auto items = infoRecordRepo.findAll();
        foreach (item; items) {
            if (item.materialId == materialId && item.vendorId == vendorId && item.plantId == plantId) {
                return infoRecordRepo.findById(item.id);
            }
        }
        return null;
    }

    private string inferPurchasingOrg(PurchasingInfoRecord* infoRecord) {
        return infoRecord is null ? "" : infoRecord.purchasingOrg;
    }

    private string inferCurrency(PurchasingInfoRecord* infoRecord) {
        return infoRecord is null ? "EUR" : infoRecord.currency;
    }

    private string inferNetPrice(PurchasingInfoRecord* infoRecord) {
        return infoRecord is null ? "0" : infoRecord.netPrice;
    }
}

class ManageInventoryUseCase : UIMUseCase {
    private GoodsReceiptRepository receiptRepo;
    private StockItemRepository stockRepo;
    private PurchaseOrderRepository orderRepo;

    this(
        GoodsReceiptRepository receiptRepo,
        StockItemRepository stockRepo,
        PurchaseOrderRepository orderRepo
    ) {
        this.receiptRepo = receiptRepo;
        this.stockRepo = stockRepo;
        this.orderRepo = orderRepo;
    }

    GoodsReceipt[] listReceipts() { return receiptRepo.findAll(); }
    GoodsReceipt* getReceipt(GoodsReceiptId id) { return receiptRepo.findById(id); }
    StockItem[] listStock() { return stockRepo.findAll(); }
    StockItem* getStock(StockItemId id) { return stockRepo.findById(id); }

    CommandResult createStockItem(StockItemDTO dto) {
        StockItem value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.materialId = dto.materialId;
        value.plantId = dto.plantId;
        value.storageLocationId = dto.storageLocationId;
        value.unrestrictedUseQty = defaultZero(dto.unrestrictedUseQty);
        value.qualityInspectionQty = defaultZero(dto.qualityInspectionQty);
        value.blockedQty = defaultZero(dto.blockedQty);
        value.openInboundQty = defaultZero(dto.openInboundQty);
        value.lastMovementAt = dto.lastMovementAt;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = dto.modifiedAt;

        if (!MaterialManagementValidator.isValidStockItem(value)) {
            return CommandResult(false, "", "Invalid stock item data");
        }

        stockRepo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult updateStockItem(StockItemDTO dto) {
        auto existing = stockRepo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Stock item not found");

        if (dto.materialId.length > 0) existing.materialId = dto.materialId;
        if (dto.plantId.length > 0) existing.plantId = dto.plantId;
        if (dto.storageLocationId.length > 0) existing.storageLocationId = dto.storageLocationId;
        if (dto.unrestrictedUseQty.length > 0) existing.unrestrictedUseQty = dto.unrestrictedUseQty;
        if (dto.qualityInspectionQty.length > 0) existing.qualityInspectionQty = dto.qualityInspectionQty;
        if (dto.blockedQty.length > 0) existing.blockedQty = dto.blockedQty;
        if (dto.openInboundQty.length > 0) existing.openInboundQty = dto.openInboundQty;
        if (dto.lastMovementAt.length > 0) existing.lastMovementAt = dto.lastMovementAt;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        stockRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult removeStockItem(StockItemId id) {
        auto existing = stockRepo.findById(id);
        if (existing is null) return CommandResult(false, "", "Stock item not found");
        stockRepo.remove(id);
        return CommandResult(true, id, "");
    }

    CommandResult createGoodsReceipt(GoodsReceiptDTO dto) {
        GoodsReceipt value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.purchaseOrderId = dto.purchaseOrderId;
        value.plantId = dto.plantId;
        value.storageLocationId = dto.storageLocationId;
        value.materialId = dto.materialId;
        value.movementType = parseEnumValue!MovementType(dto.movementType, MovementType.goodsReceipt);
        value.quantity = dto.quantity;
        value.postedBy = dto.postedBy;
        value.postingDate = dto.postingDate;
        value.documentDate = dto.documentDate;
        value.createdAt = dto.createdAt;
        value.modifiedAt = dto.modifiedAt;

        if (!MaterialManagementValidator.isValidGoodsReceipt(value)) {
            return CommandResult(false, "", "Invalid goods receipt data");
        }

        auto order = orderRepo.findById(value.purchaseOrderId);
        if (order is null) {
            return CommandResult(false, "", "Purchase order not found");
        }

        auto receiptQty = MaterialManagementValidator.parseNumber(value.quantity, -1);
        auto orderedQty = MaterialManagementValidator.parseNumber(order.lineQuantity, 0);
        auto currentReceived = MaterialManagementValidator.parseNumber(order.receivedQuantity, 0);
        auto totalReceived = currentReceived + receiptQty;

        order.receivedQuantity = quantityToString(totalReceived);
        order.status = totalReceived >= orderedQty ? PurchaseOrderStatus.received : PurchaseOrderStatus.partiallyReceived;
        order.modifiedAt = value.modifiedAt;
        orderRepo.update(*order);

        auto stock = stockRepo.findByMaterialLocation(value.materialId, value.plantId, value.storageLocationId);
        if (stock is null) {
            StockItem created;
            created.id = "STOCK-" ~ value.materialId ~ "-" ~ value.storageLocationId;
            created.tenantId = value.tenantId;
            created.materialId = value.materialId;
            created.plantId = value.plantId;
            created.storageLocationId = value.storageLocationId;
            created.unrestrictedUseQty = quantityToString(receiptQty);
            created.qualityInspectionQty = "0";
            created.blockedQty = "0";
            created.openInboundQty = "0";
            created.lastMovementAt = value.postingDate;
            created.modifiedBy = value.postedBy;
            created.modifiedAt = value.modifiedAt;
            stockRepo.save(created);
        } else {
            auto currentStock = MaterialManagementValidator.parseNumber(stock.unrestrictedUseQty, 0);
            stock.unrestrictedUseQty = quantityToString(currentStock + receiptQty);
            stock.lastMovementAt = value.postingDate;
            stock.modifiedBy = value.postedBy;
            stock.modifiedAt = value.modifiedAt;
            stockRepo.update(*stock);
        }

        receiptRepo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult removeGoodsReceipt(GoodsReceiptId id) {
        auto existing = receiptRepo.findById(id);
        if (existing is null) return CommandResult(false, "", "Goods receipt not found");
        receiptRepo.remove(id);
        return CommandResult(true, id, "");
    }

    private string defaultZero(string value) {
        return value.length > 0 ? value : "0";
    }
}

private T parseEnumValue(T)(string raw, T fallback) {
    if (raw.length == 0) {
        return fallback;
    }

    try {
        return raw.to!T;
    } catch (Exception e) {
        return fallback;
    }
}

private string quantityToString(double value) {
    auto integral = cast(long) value;
    if (value == integral) {
        return integral.to!string;
    }
    return value.to!string;
}

@safe unittest {
    auto vendorRepo = new MemoryVendorRepository();
    auto infoRepo = new MemoryPurchasingInfoRecordRepository();
    auto requisitionRepo = new MemoryPurchaseRequisitionRepository();
    auto orderRepo = new MemoryPurchaseOrderRepository();
    auto uc = new ManageProcurementUseCase(requisitionRepo, orderRepo, vendorRepo, infoRepo);

    SupplierVendor vendor;
    vendor.id = "VEN-1000";
    vendor.tenantId = "TEN-1";
    vendor.vendorNumber = "100000";
    vendor.name = "Fast Supply";
    vendorRepo.save(vendor);

    PurchasingInfoRecord info;
    info.id = "PIR-1";
    info.tenantId = "TEN-1";
    info.materialId = "MAT-1";
    info.vendorId = "VEN-1000";
    info.plantId = "PLANT-1";
    info.purchasingOrg = "P100";
    info.currency = "EUR";
    info.netPrice = "19.95";
    info.minimumOrderQuantity = "1";
    infoRepo.save(info);

    PurchaseRequisitionDTO requisition;
    requisition.id = "PR-1";
    requisition.tenantId = "TEN-1";
    requisition.materialId = "MAT-1";
    requisition.plantId = "PLANT-1";
    requisition.storageLocationId = "SL-1";
    requisition.quantity = "25";
    requisition.unit = "EA";
    requisition.requiredDate = "2026-08-15";
    requisition.requestedBy = "buyer";
    requisition.sourceVendorId = "VEN-1000";
    assert(uc.createRequisition(requisition).success);

    PurchaseOrderDTO order;
    order.id = "PO-1";
    order.tenantId = "TEN-1";
    order.orderedBy = "buyer";
    auto result = uc.convertRequisitionToOrder("PR-1", order);
    assert(result.success);

    auto savedOrder = uc.getOrder("PO-1");
    assert(savedOrder !is null);
    assert(savedOrder.vendorId == "VEN-1000");
    assert(savedOrder.lineQuantity == "25");
    assert(savedOrder.netPrice == "19.95");

    auto savedReq = uc.getRequisition("PR-1");
    assert(savedReq !is null);
    assert(savedReq.status == PurchaseRequisitionStatus.converted);
}

@safe unittest {
    auto orderRepo = new MemoryPurchaseOrderRepository();
    auto stockRepo = new MemoryStockItemRepository();
    auto receiptRepo = new MemoryGoodsReceiptRepository();
    auto uc = new ManageInventoryUseCase(receiptRepo, stockRepo, orderRepo);

    PurchaseOrder order;
    order.id = "PO-2";
    order.tenantId = "TEN-1";
    order.vendorId = "VEN-2";
    order.plantId = "PLANT-1";
    order.lineMaterialId = "MAT-2";
    order.lineQuantity = "100";
    order.receivedQuantity = "0";
    order.unit = "EA";
    order.netPrice = "10";
    orderRepo.save(order);

    GoodsReceiptDTO receipt;
    receipt.id = "GR-1";
    receipt.tenantId = "TEN-1";
    receipt.purchaseOrderId = "PO-2";
    receipt.plantId = "PLANT-1";
    receipt.storageLocationId = "SL-1";
    receipt.materialId = "MAT-2";
    receipt.quantity = "40";
    receipt.postedBy = "warehouse";
    receipt.postingDate = "2026-08-01";
    assert(uc.createGoodsReceipt(receipt).success);

    auto savedOrder = orderRepo.findById("PO-2");
    assert(savedOrder !is null);
    assert(savedOrder.status == PurchaseOrderStatus.partiallyReceived);
    assert(savedOrder.receivedQuantity == "40");

    auto stock = stockRepo.findByMaterialLocation("MAT-2", "PLANT-1", "SL-1");
    assert(stock !is null);
    assert(stock.unrestrictedUseQty == "40");
}

@safe unittest {
    auto materialRepo = new MemoryMaterialRepository();
    auto uc = new ManageMaterialsUseCase(materialRepo);

    MaterialDTO dto;
    dto.id = "MAT-BAD";
    dto.tenantId = "TEN-1";
    dto.materialNumber = "";
    dto.description = "Broken";
    dto.baseUnit = "EA";

    auto result = uc.create(dto);
    assert(!result.success);
    assert(result.error == "Invalid material data");
}