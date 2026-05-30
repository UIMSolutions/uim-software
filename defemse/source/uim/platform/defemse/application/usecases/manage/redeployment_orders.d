module uim.platform.defemse.application.usecases.manage.redeployment_orders;

import std.conv : to;
import uim.platform.defemse;

@safe:

class ManageRedeploymentOrdersUseCase : UIMUseCase {
    private RedeploymentOrderRepository repo;

    this(RedeploymentOrderRepository repo) {
        this.repo = repo;
    }

    RedeploymentOrder[] list() {
        return repo.findAll();
    }

    RedeploymentOrder* get_(RedeploymentOrderId id) {
        return repo.findById(id);
    }

    CommandResult create(RedeploymentOrderDTO dto) {
        RedeploymentOrder value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.missionPlanId = dto.missionPlanId;
        value.contingentId = dto.contingentId;
        value.originLocationId = dto.originLocationId;
        value.destinationLocationId = dto.destinationLocationId;
        value.transportType = dto.transportType;
        value.priority = dto.priority;
        value.executionWindow = dto.executionWindow;
        if (dto.status.length > 0) value.status = dto.status.to!RedeploymentStatus;
        value.reason = dto.reason;
        value.createdBy = dto.createdBy;
        if (!DefemseValidator.isValidRedeploymentOrder(value))
            return CommandResult(false, "", "Invalid redeployment order data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(RedeploymentOrderDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Redeployment order not found");
        if (dto.missionPlanId.length > 0) existing.missionPlanId = dto.missionPlanId;
        if (dto.contingentId.length > 0) existing.contingentId = dto.contingentId;
        if (dto.originLocationId.length > 0) existing.originLocationId = dto.originLocationId;
        if (dto.destinationLocationId.length > 0) existing.destinationLocationId = dto.destinationLocationId;
        if (dto.transportType.length > 0) existing.transportType = dto.transportType;
        if (dto.priority.length > 0) existing.priority = dto.priority;
        if (dto.executionWindow.length > 0) existing.executionWindow = dto.executionWindow;
        if (dto.status.length > 0) existing.status = dto.status.to!RedeploymentStatus;
        if (dto.reason.length > 0) existing.reason = dto.reason;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(RedeploymentOrderId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Redeployment order not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}