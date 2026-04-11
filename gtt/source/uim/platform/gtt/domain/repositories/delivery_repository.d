/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.repositories.delivery_repository;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

interface DeliveryRepository {
    Delivery[] findAll();
    Delivery* findById(DeliveryId id);
    Delivery[] findByTenant(TenantId tenantId);
    Delivery[] findByStatus(DeliveryStatus status);
    Delivery[] findByShipment(ShipmentId shipmentId);
    void save(Delivery delivery);
    void update(Delivery delivery);
    void remove(DeliveryId id);
}
