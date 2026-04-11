/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.entities.tracked_process;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

struct TrackedProcess {
    TrackedProcessId id;
    TenantId tenantId;
    string name;
    string description;
    ProcessType processType = ProcessType.endToEnd;
    ProcessStatus status = ProcessStatus.initiated;
    string trackingModelId;
    string shipmentIds;
    string deliveryIds;
    string purchaseOrderIds;
    string salesOrderIds;
    string currentMilestone;
    string completionPercent;
    string startDate;
    string endDate;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
