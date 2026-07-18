module uim.platform.dm.domain.services.dm_validator;

import uim.platform.dm.domain.entities.manufacturing_entities;

@safe:

struct DMValidator {
    static bool hasRequired(string id, string tenantId) {
        return id.length > 0 && tenantId.length > 0;
    }

    static bool valid(ProductionOrder value) {
        return hasRequired(value.id, value.tenantId)
            && value.orderNumber.length > 0
            && value.materialId.length > 0;
    }

    static bool valid(OperationActivity value) {
        return hasRequired(value.id, value.tenantId)
            && value.productionOrderId.length > 0
            && value.operationCode.length > 0;
    }

    static bool valid(WorkCenter value) {
        return hasRequired(value.id, value.tenantId) && value.centerCode.length > 0;
    }

    static bool valid(Resource value) {
        return hasRequired(value.id, value.tenantId) && value.resourceCode.length > 0;
    }

    static bool valid(Material value) {
        return hasRequired(value.id, value.tenantId) && value.materialNumber.length > 0;
    }

    static bool valid(ShopFloorControl value) {
        return hasRequired(value.id, value.tenantId) && value.productionOrderId.length > 0;
    }

    static bool valid(WorkInstruction value) {
        return hasRequired(value.id, value.tenantId)
            && value.operationActivityId.length > 0
            && value.title.length > 0;
    }

    static bool valid(QualityInspection value) {
        return hasRequired(value.id, value.tenantId)
            && value.productionOrderId.length > 0
            && value.characteristic.length > 0;
    }

    static bool valid(Nonconformance value) {
        return hasRequired(value.id, value.tenantId)
            && value.productionOrderId.length > 0
            && value.defectCode.length > 0;
    }

    static bool valid(GenealogyRecord value) {
        return hasRequired(value.id, value.tenantId)
            && value.productionOrderId.length > 0
            && value.parentSerial.length > 0
            && value.childSerial.length > 0;
    }
}
