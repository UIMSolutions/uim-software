/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.repositories.purchase_order_repository;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

interface PurchaseOrderRepository {
    PurchaseOrder[] findAll();
    PurchaseOrder* findById(PurchaseOrderId id);
    PurchaseOrder[] findByTenant(TenantId tenantId);
    PurchaseOrder[] findByStatus(PurchaseOrderStatus status);
    PurchaseOrder[] findBySupplier(string supplierId);
    void save(PurchaseOrder order);
    void update(PurchaseOrder order);
    void remove(PurchaseOrderId id);
}
