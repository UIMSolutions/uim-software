/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.repositories.shipment_repository;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

interface ShipmentRepository {
    Shipment[] findAll();
    Shipment* findById(ShipmentId id);
    Shipment[] findByTenant(TenantId tenantId);
    Shipment[] findByStatus(ShipmentStatus status);
    Shipment[] findByCarrier(string carrierName);
    void save(Shipment shipment);
    void update(Shipment shipment);
    void remove(ShipmentId id);
}
