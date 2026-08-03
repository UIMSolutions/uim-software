module uim.platform.rpm.application.usecases.operations.manage_operations;

import std.datetime : Clock;
import uim.platform.rpm.application.dto : CommandResult, OperationRequestDTO, RpmObjectDTO;
import uim.platform.rpm.application.usecases.manage.manage_rpm_objects : ManageRpmObjectsUseCase;
import uim.platform.rpm.domain.entities.rpm_object : RpmBusinessObjectType, RpmOperationType;

@safe:

class ManageOperationsUseCase {
    private ManageRpmObjectsUseCase manage;

    this(ManageRpmObjectsUseCase manage) {
        this.manage = manage;
    }

    CommandResult execute(OperationRequestDTO request) {
        if (!request.operationType.length) {
            return CommandResult(false, "", "operationType is required");
        }

        if (request.quantity <= 0) {
            return CommandResult(false, "", "quantity must be > 0");
        }

        string orderType;
        string lifecycleState = "done";

        switch (request.operationType) {
        case RpmOperationType.checkOut:
            orderType = RpmBusinessObjectType.shipmentOrders;
            break;
        case RpmOperationType.checkIn:
            orderType = RpmBusinessObjectType.returnOrders;
            break;
        case RpmOperationType.transfer:
            orderType = RpmBusinessObjectType.transferOrders;
            break;
        case RpmOperationType.clean:
            orderType = RpmBusinessObjectType.cleaningOrders;
            lifecycleState = "sanitized";
            break;
        case RpmOperationType.repair:
            orderType = RpmBusinessObjectType.repairOrders;
            lifecycleState = "repaired";
            break;
        case RpmOperationType.inspect:
            orderType = RpmBusinessObjectType.qualityInspections;
            lifecycleState = "inspected";
            break;
        default:
            return CommandResult(false, "", "Unsupported operationType");
        }

        RpmObjectDTO order;
        order.objectType = orderType;
        order.tenantId = "default";
        order.technicalName = request.operationType;
        order.businessName = request.referenceId.length ? request.referenceId : "rpm-op";
        order.lifecycleState = lifecycleState;
        order.parentId = request.assetId;
        order.owner = request.executedBy;
        order.locationId = request.toLocationId.length ? request.toLocationId : request.fromLocationId;
        order.partnerId = request.partnerId;
        order.referenceId = request.referenceId;
        order.unitOfMeasure = "EA";
        order.quantity = request.quantity;
        order.description = request.notes;
        order.createdBy = request.executedBy;
        order.modifiedBy = request.executedBy;
        order.metadata["poolId"] = request.poolId;
        order.metadata["packagingMaterialId"] = request.packagingMaterialId;
        order.metadata["fromLocationId"] = request.fromLocationId;
        order.metadata["toLocationId"] = request.toLocationId;

        auto created = manage.create(order);
        if (!created.success) {
            return created;
        }

        createTelemetry(request, created.id);

        return created;
    }

    private void createTelemetry(OperationRequestDTO request, string parentOrderId) {
        RpmObjectDTO telemetry;
        telemetry.objectType = RpmBusinessObjectType.telemetryEvents;
        telemetry.tenantId = "default";
        telemetry.technicalName = request.operationType ~ "-event";
        telemetry.businessName = request.referenceId.length ? request.referenceId : request.operationType;
        telemetry.parentId = request.assetId.length ? request.assetId : parentOrderId;
        telemetry.owner = request.executedBy;
        telemetry.locationId = request.toLocationId.length ? request.toLocationId : request.fromLocationId;
        telemetry.partnerId = request.partnerId;
        telemetry.referenceId = request.referenceId;
        telemetry.quantity = request.quantity;
        telemetry.description = "Operation telemetry recorded at " ~ Clock.currTime().toISOExtString();
        telemetry.createdBy = request.executedBy;
        telemetry.modifiedBy = request.executedBy;
        telemetry.metadata["operationType"] = request.operationType;
        telemetry.metadata["poolId"] = request.poolId;
        telemetry.metadata["packagingMaterialId"] = request.packagingMaterialId;
        telemetry.metadata["orderId"] = parentOrderId;
        manage.create(telemetry);
    }
}

unittest {
    import uim.platform.rpm.infrastructure.persistence.memory.rpm_repository : MemoryRpmRepository;

    auto repo = new MemoryRpmRepository();
    auto manage = new ManageRpmObjectsUseCase(repo);
    auto operations = new ManageOperationsUseCase(manage);

    OperationRequestDTO req;
    req.operationType = RpmOperationType.transfer;
    req.poolId = "POOL-EU";
    req.packagingMaterialId = "MAT-PALLET";
    req.assetId = "SER-1000";
    req.fromLocationId = "LOC-HAM";
    req.toLocationId = "LOC-RTM";
    req.partnerId = "PARTNER-1";
    req.quantity = 12;
    req.referenceId = "TR-2026-0001";
    req.executedBy = "planner";

    auto result = operations.execute(req);
    assert(result.success);

    auto telemetry = manage.list(RpmBusinessObjectType.telemetryEvents);
    assert(telemetry.length == 1);
}
