/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.mrp.domain.entities.material;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

struct Material {
    MaterialId id;
    TenantId tenantId;
    PlantId plantId;
    string name;
    string description;
    string materialNumber;
    string baseUnit;
    MRPProcedure mrpProcedure = MRPProcedure.materialRequirementsPlanning;
    LotSizingProcedure lotSizingProcedure = LotSizingProcedure.lotForLot;
    ProcurementType procurementType = ProcurementType.both;
    MaterialStatus status = MaterialStatus.active;
    string safetyStock;
    string reorderPoint;
    string lotSize;
    string minimumLotSize;
    string independentDemand;
    string planningTimeFenceDays;
    string inHouseProductionTimeDays;
    string plannedDeliveryTimeDays;
    string grProcessingTimeDays;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
