module uim.platform.freight_collaboration.application.usecases.manage.freight_orders;

import uim.platform.freight_collaboration;

@safe:

class ManageFreightOrdersUseCase : UIMUseCase {
    private FreightOrderRepository repo;

    this(FreightOrderRepository repo) {
        this.repo = repo;
    }

    FreightOrder[] list() {
        return repo.findAll();
    }

    FreightOrder* get_(FreightOrderId id) {
        return repo.findById(id);
    }

    CommandResult create(FreightOrderDTO dto) {
        FreightOrder value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.orderNumber = dto.orderNumber;
        value.shipperId = dto.shipperId;
        value.carrierId = dto.carrierId;
        value.transportMode = dto.transportMode;
        value.status = dto.status.length ? dto.status : value.status;
        value.originLocation = dto.originLocation;
        value.destinationLocation = dto.destinationLocation;
        value.plannedPickup = dto.plannedPickup;
        value.plannedDelivery = dto.plannedDelivery;
        value.createdBy = dto.createdBy;

        if (!FreightCollaborationValidator.isValidFreightOrder(value)) {
            return CommandResult(false, "", "Invalid freight order data");
        }

        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(FreightOrderDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "Freight order not found");
        }

        if (dto.orderNumber.length) existing.orderNumber = dto.orderNumber;
        if (dto.shipperId.length) existing.shipperId = dto.shipperId;
        if (dto.carrierId.length) existing.carrierId = dto.carrierId;
        if (dto.transportMode.length) existing.transportMode = dto.transportMode;
        if (dto.status.length) existing.status = dto.status;
        if (dto.originLocation.length) existing.originLocation = dto.originLocation;
        if (dto.destinationLocation.length) existing.destinationLocation = dto.destinationLocation;
        if (dto.plannedPickup.length) existing.plannedPickup = dto.plannedPickup;
        if (dto.plannedDelivery.length) existing.plannedDelivery = dto.plannedDelivery;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(FreightOrderId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "Freight order not found");
        }

        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
