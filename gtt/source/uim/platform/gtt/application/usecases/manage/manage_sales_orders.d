/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.application.usecases.manage.manage_sales_orders;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class ManageSalesOrdersUseCase : UIMUseCase {
    private SalesOrderRepository repo;

    this(SalesOrderRepository repo) {
        this.repo = repo;
    }

    SalesOrder* get_(SalesOrderId id) {
        return repo.findById(id);
    }

    SalesOrder[] list() {
        return repo.findAll();
    }

    SalesOrder[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    SalesOrder[] listByStatus(SalesOrderStatus status) {
        return repo.findByStatus(status);
    }

    SalesOrder[] listByCustomer(string customerId) {
        return repo.findByCustomer(customerId);
    }

    CommandResult create(SalesOrderDTO dto) {
        SalesOrder so;
        so.id = dto.id;
        so.tenantId = dto.tenantId;
        so.name = dto.name;
        so.description = dto.description;
        so.orderNumber = dto.orderNumber;
        so.customerId = dto.customerId;
        so.sellerLocationId = dto.sellerLocationId;
        so.customerLocationId = dto.customerLocationId;
        so.items = dto.items;
        so.orderDate = dto.orderDate;
        so.requestedDeliveryDate = dto.requestedDeliveryDate;
        so.currency = dto.currency;
        so.totalAmount = dto.totalAmount;
        so.createdBy = dto.createdBy;
        if (!TrackingValidator.isValidSalesOrder(so))
            return CommandResult(false, "", "Invalid sales order data");
        repo.save(so);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(SalesOrderDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Sales order not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.actualDeliveryDate.length > 0) existing.actualDeliveryDate = dto.actualDeliveryDate;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(SalesOrderId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Sales order not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
