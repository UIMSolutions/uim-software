/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.application.usecases.manage.manage_deliveries;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class ManageDeliveriesUseCase : UIMUseCase {
    private DeliveryRepository repo;

    this(DeliveryRepository repo) {
        this.repo = repo;
    }

    Delivery* get_(DeliveryId id) {
        return repo.findById(id);
    }

    Delivery[] list() {
        return repo.findAll();
    }

    Delivery[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    Delivery[] listByStatus(DeliveryStatus status) {
        return repo.findByStatus(status);
    }

    Delivery[] listByShipment(ShipmentId shipmentId) {
        return repo.findByShipment(shipmentId);
    }

    CommandResult create(DeliveryDTO dto) {
        Delivery d;
        d.id = dto.id;
        d.tenantId = dto.tenantId;
        d.name = dto.name;
        d.description = dto.description;
        d.deliveryNumber = dto.deliveryNumber;
        d.shipmentId = dto.shipmentId;
        d.purchaseOrderId = dto.purchaseOrderId;
        d.salesOrderId = dto.salesOrderId;
        d.originLocationId = dto.originLocationId;
        d.destinationLocationId = dto.destinationLocationId;
        d.carrierReference = dto.carrierReference;
        d.items = dto.items;
        d.plannedDate = dto.plannedDate;
        d.createdBy = dto.createdBy;
        if (!TrackingValidator.isValidDelivery(d))
            return CommandResult(false, "", "Invalid delivery data");
        repo.save(d);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(DeliveryDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Delivery not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.actualDate.length > 0) existing.actualDate = dto.actualDate;
        if (dto.proofOfDelivery.length > 0) existing.proofOfDelivery = dto.proofOfDelivery;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(DeliveryId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Delivery not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
