module uim.platform.team.presentation.http.json_utils;

import std.conv : to;
import uim.platform.team;
import vibe.http.server : HTTPServerResponse;

@safe:

void writeJsonBody(scope HTTPServerResponse res, Json body, int status = 200) {
    res.writeJsonBody(body, status);
}

private Json stringArrayToJson(string[] values) {
    auto arr = Json.emptyArray;
    foreach (value; values)
        arr ~= Json(value);
    return arr;
}

Json partToJson(Part item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["number"] = Json(item.number);
    j["name"] = Json(item.name);
    j["description"] = Json(item.description);
    j["revision"] = Json(item.revision);
    j["lifecycleState"] = Json(to!string(item.lifecycleState));
    j["owningOrganization"] = Json(item.owningOrganization);
    j["responsibleEngineer"] = Json(item.responsibleEngineer);
    j["materialClass"] = Json(item.materialClass);
    j["unitOfMeasure"] = Json(item.unitOfMeasure);
    j["createdBy"] = Json(item.createdBy);
    j["modifiedBy"] = Json(item.modifiedBy);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json bomToJson(Bom item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["parentPartId"] = Json(item.parentPartId);
    j["name"] = Json(item.name);
    j["revision"] = Json(item.revision);
    auto lines = Json.emptyArray;
    foreach (line; item.lines) {
        auto jl = Json.emptyObject;
        jl["childPartId"] = Json(line.childPartId);
        jl["quantity"] = Json(line.quantity);
        jl["unitOfMeasure"] = Json(line.unitOfMeasure);
        jl["findNumber"] = Json(line.findNumber);
        jl["effectivity"] = Json(line.effectivity);
        lines ~= jl;
    }
    j["lines"] = lines;
    j["createdBy"] = Json(item.createdBy);
    j["modifiedBy"] = Json(item.modifiedBy);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json documentToJson(Document item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["title"] = Json(item.title);
    j["docNumber"] = Json(item.docNumber);
    j["revision"] = Json(item.revision);
    j["docType"] = Json(to!string(item.docType));
    j["fileName"] = Json(item.fileName);
    j["fileUri"] = Json(item.fileUri);
    j["relatedPartId"] = Json(item.relatedPartId);
    j["relatedChangeId"] = Json(item.relatedChangeId);
    j["owner"] = Json(item.owner);
    j["createdBy"] = Json(item.createdBy);
    j["modifiedBy"] = Json(item.modifiedBy);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json changeToJson(ChangeRequest item) {
    auto j = Json.emptyObject;
    j["id"] = Json(item.id);
    j["tenantId"] = Json(item.tenantId);
    j["changeNumber"] = Json(item.changeNumber);
    j["title"] = Json(item.title);
    j["description"] = Json(item.description);
    j["state"] = Json(to!string(item.state));
    j["severity"] = Json(to!string(item.severity));
    j["affectedPartIds"] = stringArrayToJson(item.affectedPartIds);
    j["affectedDocumentIds"] = stringArrayToJson(item.affectedDocumentIds);
    j["requestedBy"] = Json(item.requestedBy);
    j["approver"] = Json(item.approver);
    j["targetImplementationDate"] = Json(item.targetImplementationDate);
    j["createdBy"] = Json(item.createdBy);
    j["modifiedBy"] = Json(item.modifiedBy);
    j["createdAt"] = Json(item.createdAt);
    j["modifiedAt"] = Json(item.modifiedAt);
    return j;
}

Json changeImpactToJson(ChangeImpactDTO item) {
    auto j = Json.emptyObject;
    j["changeId"] = Json(item.changeId);
    j["changeNumber"] = Json(item.changeNumber);
    j["state"] = Json(item.state);
    j["severity"] = Json(item.severity);
    j["affectedParts"] = Json(item.affectedParts);
    j["affectedDocuments"] = Json(item.affectedDocuments);
    j["impactScore"] = Json(item.impactScore);
    return j;
}

Json plmSummaryToJson(PlmSummaryDTO item) {
    auto j = Json.emptyObject;
    j["totalParts"] = Json(item.totalParts);
    j["totalBoms"] = Json(item.totalBoms);
    j["totalDocuments"] = Json(item.totalDocuments);
    j["totalChanges"] = Json(item.totalChanges);
    j["openChanges"] = Json(item.openChanges);
    j["criticalChanges"] = Json(item.criticalChanges);
    return j;
}
