module uim.platform.mrp.application.usecases.manage.manage_mrp_runs_test;

import uim.platform.mrp;

@safe unittest {
    auto materialRepo = new MemoryMaterialRepository();
    auto bomRepo = new MemoryBillOfMaterialRepository();
    auto inventoryRepo = new MemoryInventoryPositionRepository();
    auto runRepo = new MemoryMrpRunRepository();
    auto proposalRepo = new MemoryProcurementProposalRepository();

    Material m;
    m.id = "MAT-LOT";
    m.tenantId = "T1";
    m.plantId = "P1";
    m.name = "Lot Sized Material";
    m.materialNumber = "MAT-LOT";
    m.independentDemand = "30";
    m.lotSizingProcedure = LotSizingProcedure.fixedLotSize;
    m.lotSize = "25";
    m.minimumLotSize = "0";
    m.safetyStock = "0";
    m.procurementType = ProcurementType.inHouse;
    m.status = MaterialStatus.active;
    materialRepo.save(m);

    InventoryPosition inv;
    inv.id = "INV-LOT";
    inv.tenantId = "T1";
    inv.plantId = "P1";
    inv.materialId = "MAT-LOT";
    inv.onHandQuantity = "10";
    inv.scheduledReceipts = "0";
    inv.reservedQuantity = "0";
    inventoryRepo.save(inv);

    auto uc = new ManageMrpRunsUseCase(runRepo, proposalRepo, materialRepo, bomRepo, inventoryRepo);

    MrpRunDTO run;
    run.id = "RUN-LOT";
    run.tenantId = "T1";
    run.plantId = "P1";
    run.name = "Lot Sizing Test";
    run.mode = "regenerative";
    run.planningDate = "2026-05-28";
    run.executedBy = "tester";
    run.executedAt = "2026-05-28T08:00:00Z";

    auto result = uc.create(run);
    assert(result.success);

    auto proposals = proposalRepo.findByRun("RUN-LOT");
    assert(proposals.length == 1);
    assert(proposals[0].proposalType == ProposalType.plannedOrder);

    import std.conv : to;
    auto qty = proposals[0].quantity.to!double;
    assert(qty == 25.0);
}

@safe unittest {
    auto materialRepo = new MemoryMaterialRepository();
    auto bomRepo = new MemoryBillOfMaterialRepository();
    auto inventoryRepo = new MemoryInventoryPositionRepository();
    auto runRepo = new MemoryMrpRunRepository();
    auto proposalRepo = new MemoryProcurementProposalRepository();

    Material parent;
    parent.id = "FG";
    parent.tenantId = "T1";
    parent.plantId = "P1";
    parent.name = "Finished Good";
    parent.materialNumber = "FG";
    parent.independentDemand = "10";
    parent.lotSizingProcedure = LotSizingProcedure.lotForLot;
    parent.procurementType = ProcurementType.inHouse;
    parent.status = MaterialStatus.active;
    materialRepo.save(parent);

    Material component;
    component.id = "COMP";
    component.tenantId = "T1";
    component.plantId = "P1";
    component.name = "Component";
    component.materialNumber = "COMP";
    component.independentDemand = "0";
    component.lotSizingProcedure = LotSizingProcedure.lotForLot;
    component.procurementType = ProcurementType.external;
    component.status = MaterialStatus.active;
    materialRepo.save(component);

    BillOfMaterial bom;
    bom.id = "BOM-1";
    bom.tenantId = "T1";
    bom.plantId = "P1";
    bom.parentMaterialId = "FG";
    bom.componentMaterialId = "COMP";
    bom.componentQuantity = "2";
    bom.baseQuantity = "1";
    bomRepo.save(bom);

    InventoryPosition fgInv;
    fgInv.id = "INV-FG";
    fgInv.tenantId = "T1";
    fgInv.plantId = "P1";
    fgInv.materialId = "FG";
    fgInv.onHandQuantity = "10";
    fgInv.scheduledReceipts = "0";
    fgInv.reservedQuantity = "0";
    inventoryRepo.save(fgInv);

    InventoryPosition compInv;
    compInv.id = "INV-COMP";
    compInv.tenantId = "T1";
    compInv.plantId = "P1";
    compInv.materialId = "COMP";
    compInv.onHandQuantity = "5";
    compInv.scheduledReceipts = "0";
    compInv.reservedQuantity = "0";
    inventoryRepo.save(compInv);

    auto uc = new ManageMrpRunsUseCase(runRepo, proposalRepo, materialRepo, bomRepo, inventoryRepo);

    MrpRunDTO run;
    run.id = "RUN-BOM";
    run.tenantId = "T1";
    run.plantId = "P1";
    run.name = "BOM Explosion Test";
    run.mode = "regenerative";
    run.planningDate = "2026-05-28";
    run.executedBy = "tester";
    run.executedAt = "2026-05-28T08:00:00Z";

    auto result = uc.create(run);
    assert(result.success);

    auto proposals = proposalRepo.findByRun("RUN-BOM");
    assert(proposals.length == 1);
    assert(proposals[0].materialId == "COMP");
    assert(proposals[0].proposalType == ProposalType.purchaseRequisition);

    import std.conv : to;
    auto qty = proposals[0].quantity.to!double;
    assert(qty == 15.0);
}
