module uim.platform.ewm.presentation.http.json_utils;

import std.conv : to;
import uim.platform.ewm;
import vibe.http.server : HTTPServerResponse;

@safe:

void writeJsonBody(scope HTTPServerResponse res, Json body, int status = 200) {
    res.writeJsonBody(body, status);
}

Json productToJson(Product value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["productNumber"] = Json(value.productNumber);
    j["productType"] = Json(value.productType);
    j["lifecycleStatus"] = Json(value.lifecycleStatus);
    j["category"] = Json(value.category);
    j["baseUnit"] = Json(value.baseUnit);
    j["validFrom"] = Json(value.validFrom);
    j["validTo"] = Json(value.validTo);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json billOfMaterialToJson(BillOfMaterial value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["warehouseId"] = Json(value.warehouseId);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["bomType"] = Json(value.bomType);
    j["revision"] = Json(value.revision);
    j["usage"] = Json(value.usage);
    j["plant"] = Json(value.plant);
    j["baseQuantity"] = Json(value.baseQuantity);
    j["baseUnit"] = Json(value.baseUnit);
    j["isActive"] = Json(value.isActive);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json changeRequestToJson(ChangeRequest value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["warehouseId"] = Json(value.warehouseId);
    j["title"] = Json(value.title);
    j["description"] = Json(value.description);
    j["priority"] = Json(value.priority);
    j["status"] = Json(value.status);
    j["reason"] = Json(value.reason);
    j["impact"] = Json(value.impact);
    j["requestedBy"] = Json(value.requestedBy);
    j["assignedTo"] = Json(value.assignedTo);
    j["approvedBy"] = Json(value.approvedBy);
    j["affectedDocumentIds"] = Json(value.affectedDocumentIds);
    j["affectedBomIds"] = Json(value.affectedBomIds);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json documentToJson(Document value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["warehouseId"] = Json(value.warehouseId);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["documentType"] = Json(value.documentType);
    j["status"] = Json(value.status);
    j["documentNumber"] = Json(value.documentNumber);
    j["fileName"] = Json(value.fileName);
    j["mimeType"] = Json(value.mimeType);
    j["language"] = Json(value.language);
    j["author"] = Json(value.author);
    j["approvedBy"] = Json(value.approvedBy);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json specificationToJson(Specification value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["warehouseId"] = Json(value.warehouseId);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["specificationType"] = Json(value.specificationType);
    j["status"] = Json(value.status);
    j["specificationNumber"] = Json(value.specificationNumber);
    j["property"] = Json(value.property);
    j["targetValue"] = Json(value.targetValue);
    j["unit"] = Json(value.unit);
    j["lowerLimit"] = Json(value.lowerLimit);
    j["upperLimit"] = Json(value.upperLimit);
    j["testMethod"] = Json(value.testMethod);
    j["complianceStandard"] = Json(value.complianceStandard);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json recipeToJson(Recipe value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["warehouseId"] = Json(value.warehouseId);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["recipeType"] = Json(value.recipeType);
    j["status"] = Json(value.status);
    j["recipeNumber"] = Json(value.recipeNumber);
    j["yieldValue"] = Json(value.yieldValue);
    j["yieldUnit"] = Json(value.yieldUnit);
    j["batchSize"] = Json(value.batchSize);
    j["batchUnit"] = Json(value.batchUnit);
    j["shelfLife"] = Json(value.shelfLife);
    j["storageConditions"] = Json(value.storageConditions);
    j["ingredients"] = Json(value.ingredients);
    j["instructions"] = Json(value.instructions);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json collaborationToJson(Collaboration value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["warehouseId"] = Json(value.warehouseId);
    j["title"] = Json(value.title);
    j["description"] = Json(value.description);
    j["collaborationType"] = Json(value.collaborationType);
    j["status"] = Json(value.status);
    j["assignedTo"] = Json(value.assignedTo);
    j["participants"] = Json(value.participants);
    j["dueDate"] = Json(value.dueDate);
    j["resolvedDate"] = Json(value.resolvedDate);
    j["resolution"] = Json(value.resolution);
    j["relatedDocumentId"] = Json(value.relatedDocumentId);
    j["relatedChangeRequestId"] = Json(value.relatedChangeRequestId);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json productStructureToJson(ProductStructure value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["warehouseId"] = Json(value.warehouseId);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["nodeType"] = Json(value.nodeType);
    j["parentNodeId"] = Json(value.parentNodeId);
    j["childNodeIds"] = Json(value.childNodeIds);
    j["quantity"] = Json(value.quantity);
    j["mandatory"] = Json(value.mandatory);
    j["status"] = Json(value.status);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}
