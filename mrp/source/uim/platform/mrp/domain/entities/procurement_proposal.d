/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.mrp.domain.entities.procurement_proposal;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

struct ProcurementProposal {
    ProcurementProposalId id;
    TenantId tenantId;
    MrpRunId mrpRunId;
    PlantId plantId;
    MaterialId materialId;
    ProposalType proposalType = ProposalType.plannedOrder;
    ProposalStatus status = ProposalStatus.created;
    string quantity;
    string dueDate;
    string source;
    string exceptionMessage;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
