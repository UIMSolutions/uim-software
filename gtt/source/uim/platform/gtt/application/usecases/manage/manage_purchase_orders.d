/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.application.usecases.manage.manage_purchase_orders;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class ManagePurchaseOrdersUseCase : UIMUseCase {
    private PurchaseOrderRepository repo;

    this(PurchaseOrderRepository repo) {
        this.repo = repo;
    }

    PurchaseOrder* get_(PurchaseOrderId id) {
        return repo.findById(id);
    }

    PurchaseOrder[] list() {
        return repo.findAll();
    }

    PurchaseOrder[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    PurchaseOrder[] listByStatus(PurchaseOrderStatus status) {
        return repo.findByStatus(status);
    }

    PurchaseOrder[] listBySupplier(string supplierId) {
        return repo.findBySupplier(supplierId);
    }

    CommandResult create(PurchaseOrderDTO dto) {
        PurchaseOrder po;
        po.id = dto.id;
        po.tenantId = dto.tenantId;
        po.name = dto.name;
        po.description = dto.description;
        po.orderNumber = dto.orderNumber;
        po.supplierId = dto.supplierId;
        po.buyerLocationId = dto.buyerLocationId;
        po.supplierLocationId = dto.supplierLocationId;
        po.items = dto.items;
        po.orderDate = dto.orderDate;
        po.expectedDeliveryDate = dto.expectedDeliveryDate;
        po.currency = dto.currency;
        po.totalAmount = dto.totalAmount;
        po.createdBy = dto.createdBy;
        if (!TrackingValidator.isValidPurchaseOrder(po))
            return CommandResult(false, "", "Invalid purchase order data");
        repo.save(po);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(PurchaseOrderDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Purchase order not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.actualDeliveryDate.length > 0) existing.actualDeliveryDate = dto.actualDeliveryDate;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(PurchaseOrderId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Purchase order not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
