/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.application.usecases.manage.manage_shipments;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class ManageShipmentsUseCase : UIMUseCase {
    private ShipmentRepository repo;

    this(ShipmentRepository repo) {
        this.repo = repo;
    }

    Shipment* get_(ShipmentId id) {
        return repo.findById(id);
    }

    Shipment[] list() {
        return repo.findAll();
    }

    Shipment[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    Shipment[] listByStatus(ShipmentStatus status) {
        return repo.findByStatus(status);
    }

    Shipment[] listByCarrier(string carrierName) {
        return repo.findByCarrier(carrierName);
    }

    CommandResult create(ShipmentDTO dto) {
        Shipment s;
        s.id = dto.id;
        s.tenantId = dto.tenantId;
        s.name = dto.name;
        s.description = dto.description;
        s.shipmentNumber = dto.shipmentNumber;
        s.carrierName = dto.carrierName;
        s.carrierTrackingId = dto.carrierTrackingId;
        s.originLocationId = dto.originLocationId;
        s.destinationLocationId = dto.destinationLocationId;
        s.plannedDeparture = dto.plannedDeparture;
        s.plannedArrival = dto.plannedArrival;
        s.waypoints = dto.waypoints;
        s.trackingModelId = dto.trackingModelId;
        s.createdBy = dto.createdBy;
        if (!TrackingValidator.isValidShipment(s))
            return CommandResult(false, "", "Invalid shipment data");
        repo.save(s);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ShipmentDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Shipment not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.actualDeparture.length > 0) existing.actualDeparture = dto.actualDeparture;
        if (dto.actualArrival.length > 0) existing.actualArrival = dto.actualArrival;
        if (dto.waypoints.length > 0) existing.waypoints = dto.waypoints;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ShipmentId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Shipment not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
