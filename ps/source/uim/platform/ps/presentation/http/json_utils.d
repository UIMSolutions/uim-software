module uim.platform.ps.presentation.http.json_utils;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

Json projectToJson(Project e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["projectDefinition"] = Json(e.projectDefinition);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["projectType"] = Json(e.projectType.to!string);
    j["status"] = Json(e.status.to!string);
    j["companyCode"] = Json(e.companyCode);
    j["controllingArea"] = Json(e.controllingArea);
    j["profitCenter"] = Json(e.profitCenter);
    j["responsiblePerson"] = Json(e.responsiblePerson);
    j["projectManager"] = Json(e.projectManager);
    j["plannedStartDate"] = Json(e.plannedStartDate);
    j["plannedFinishDate"] = Json(e.plannedFinishDate);
    j["actualStartDate"] = Json(e.actualStartDate);
    j["actualFinishDate"] = Json(e.actualFinishDate);
    j["billingType"] = Json(e.billingType.to!string);
    j["currency"] = Json(e.currency);
    j["totalPlannedCost"] = Json(e.totalPlannedCost);
    j["totalActualCost"] = Json(e.totalActualCost);
    j["totalBudget"] = Json(e.totalBudget);
    j["projectProfile"] = Json(e.projectProfile);
    j["network"] = Json(e.network);
    j["budgetControlActive"] = Json(e.budgetControlActive);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json wbsElementToJson(WBSElement e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["projectId"] = Json(e.projectId);
    j["parentId"] = Json(e.parentId);
    j["wbsCode"] = Json(e.wbsCode);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["elementType"] = Json(e.elementType.to!string);
    j["status"] = Json(e.status.to!string);
    j["level"] = Json(cast(long) e.level);
    j["isAccountAssignment"] = Json(e.isAccountAssignment);
    j["isPlanningElement"] = Json(e.isPlanningElement);
    j["isBillingElement"] = Json(e.isBillingElement);
    j["responsiblePerson"] = Json(e.responsiblePerson);
    j["workCenter"] = Json(e.workCenter);
    j["profitCenter"] = Json(e.profitCenter);
    j["costCenter"] = Json(e.costCenter);
    j["plannedStartDate"] = Json(e.plannedStartDate);
    j["plannedFinishDate"] = Json(e.plannedFinishDate);
    j["actualStartDate"] = Json(e.actualStartDate);
    j["actualFinishDate"] = Json(e.actualFinishDate);
    j["plannedCost"] = Json(e.plannedCost);
    j["actualCost"] = Json(e.actualCost);
    j["currency"] = Json(e.currency);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json networkActivityToJson(NetworkActivity e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["projectId"] = Json(e.projectId);
    j["wbsElementId"] = Json(e.wbsElementId);
    j["activityNumber"] = Json(e.activityNumber);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["activityType"] = Json(e.activityType.to!string);
    j["status"] = Json(e.status.to!string);
    j["workCenter"] = Json(e.workCenter);
    j["controlKey"] = Json(e.controlKey);
    j["plannedWork"] = Json(e.plannedWork);
    j["actualWork"] = Json(e.actualWork);
    j["remainingWork"] = Json(e.remainingWork);
    j["plannedStartDate"] = Json(e.plannedStartDate);
    j["plannedFinishDate"] = Json(e.plannedFinishDate);
    j["actualStartDate"] = Json(e.actualStartDate);
    j["actualFinishDate"] = Json(e.actualFinishDate);
    j["plannedCost"] = Json(e.plannedCost);
    j["actualCost"] = Json(e.actualCost);
    j["currency"] = Json(e.currency);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json milestoneToJson(Milestone e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["projectId"] = Json(e.projectId);
    j["wbsElementId"] = Json(e.wbsElementId);
    j["activityId"] = Json(e.activityId);
    j["milestoneNumber"] = Json(e.milestoneNumber);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["category"] = Json(e.category.to!string);
    j["isReached"] = Json(e.isReached);
    j["plannedDate"] = Json(e.plannedDate);
    j["actualDate"] = Json(e.actualDate);
    j["billingAmount"] = Json(e.billingAmount);
    j["currency"] = Json(e.currency);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json projectCostToJson(ProjectCost e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["projectId"] = Json(e.projectId);
    j["wbsElementId"] = Json(e.wbsElementId);
    j["activityId"] = Json(e.activityId);
    j["costCategory"] = Json(e.costCategory.to!string);
    j["costElement"] = Json(e.costElement);
    j["plannedCost"] = Json(e.plannedCost);
    j["actualCost"] = Json(e.actualCost);
    j["committedCost"] = Json(e.committedCost);
    j["remainingCost"] = Json(e.remainingCost);
    j["currency"] = Json(e.currency);
    j["fiscalYear"] = Json(e.fiscalYear);
    j["period"] = Json(e.period);
    j["postingDate"] = Json(e.postingDate);
    j["documentNumber"] = Json(e.documentNumber);
    j["description"] = Json(e.description);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json projectBudgetToJson(ProjectBudget e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["projectId"] = Json(e.projectId);
    j["wbsElementId"] = Json(e.wbsElementId);
    j["budgetStatus"] = Json(e.budgetStatus.to!string);
    j["originalBudget"] = Json(e.originalBudget);
    j["currentBudget"] = Json(e.currentBudget);
    j["supplementBudget"] = Json(e.supplementBudget);
    j["returnBudget"] = Json(e.returnBudget);
    j["transferBudget"] = Json(e.transferBudget);
    j["availableBudget"] = Json(e.availableBudget);
    j["assignedBudget"] = Json(e.assignedBudget);
    j["currency"] = Json(e.currency);
    j["fiscalYear"] = Json(e.fiscalYear);
    j["validFrom"] = Json(e.validFrom);
    j["validTo"] = Json(e.validTo);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}
