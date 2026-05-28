/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.mrp.domain.types;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

alias MaterialId = string;
alias PlantId = string;
alias BillOfMaterialId = string;
alias InventoryPositionId = string;
alias MrpRunId = string;
alias ProcurementProposalId = string;
alias TenantId = string;
alias UserId = string;

enum PlanningScope {
    plant,
    mrpArea
}

enum MRPProcedure {
    materialRequirementsPlanning,
    consumptionBasedPlanning
}

enum LotSizingProcedure {
    lotForLot,
    fixedLotSize,
    periodic,
    minimumLotSize,
    optimumLotSize
}

enum ProcurementType {
    inHouse,
    external,
    both
}

enum MaterialStatus {
    active,
    blocked,
    discontinued
}

enum StockSegment {
    unrestricted,
    qualityInspection,
    blocked
}

enum ProposalType {
    plannedOrder,
    purchaseRequisition,
    scheduleLine
}

enum ProposalStatus {
    created,
    released,
    converted,
    cancelled
}

enum RunMode {
    regenerative,
    netChange
}

enum RunStatus {
    planned,
    running,
    completed,
    failed
}
