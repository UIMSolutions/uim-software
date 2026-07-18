module uim.platform.dm.application.usecases.manage.dm_feature_tests;

import uim.platform.dm;

@safe unittest {
    auto repo = new MemoryProductionOrderRepository();
    auto uc = new ManageProductionOrdersUseCase(repo);

    ProductionOrderDTO dto;
    dto.id = "PO-100";
    dto.tenantId = "TEN-1";
    dto.orderNumber = "1000001";
    dto.materialId = "MAT-100";
    dto.plant = "1000";
    dto.quantity = "10";
    dto.unit = "EA";
    dto.status = "released";
    dto.createdBy = "planner";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll().length == 1);
    assert(repo.findAll()[0].orderNumber == "1000001");
}

@safe unittest {
    auto repo = new MemoryOperationActivityRepository();
    auto uc = new ManageOperationActivitiesUseCase(repo);

    OperationActivityDTO dto;
    dto.id = "OP-1";
    dto.tenantId = "TEN-1";
    dto.productionOrderId = "PO-100";
    dto.operationCode = "0010";
    dto.workCenterId = "WC-1";
    dto.sequence = "10";
    dto.plannedDuration = "30m";
    dto.status = "started";
    dto.createdBy = "supervisor";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll()[0].status == OperationStatus.started);
}

@safe unittest {
    auto repo = new MemoryQualityInspectionRepository();
    auto uc = new ManageQualityInspectionsUseCase(repo);

    QualityInspectionDTO dto;
    dto.id = "QI-7";
    dto.tenantId = "TEN-1";
    dto.productionOrderId = "PO-100";
    dto.characteristic = "Length";
    dto.sampleSize = "5";
    dto.resultValue = "10.02";
    dto.status = "accepted";
    dto.inspector = "qa1";
    dto.createdBy = "qa1";

    auto result = uc.create(dto);
    assert(result.success);

    QualityInspectionDTO update;
    update.id = "QI-7";
    update.status = "rejected";
    update.modifiedBy = "qa2";

    auto up = uc.update(update);
    assert(up.success);
    assert(repo.findAll()[0].status == InspectionStatus.rejected);
}

@safe unittest {
    auto repo = new MemoryGenealogyRecordRepository();
    auto uc = new ManageGenealogyRecordsUseCase(repo);

    GenealogyRecordDTO dto;
    dto.id = "GEN-1";
    dto.tenantId = "TEN-1";
    dto.productionOrderId = "PO-100";
    dto.parentSerial = "PARENT-001";
    dto.childSerial = "CHILD-001";
    dto.componentMaterialId = "COMP-77";
    dto.assembledAt = "2026-07-18T12:00:00Z";
    dto.createdBy = "system";

    auto result = uc.create(dto);
    assert(result.success);

    auto removed = uc.remove("GEN-1");
    assert(removed.success);
    assert(repo.findAll().length == 0);
}
