module uim.platform.material_traceability.presentation.http.json_utils;

import vibe.data.json : Json;
import uim.platform.material_traceability.domain.entities.mt_object : MtObject;

@safe:

Json objectToJson(in MtObject value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["objectType"] = Json(value.objectType);
    j["tenantId"] = Json(value.tenantId);
    j["technicalName"] = Json(value.technicalName);
    j["businessName"] = Json(value.businessName);
    j["traceabilityDomain"] = Json(value.traceabilityDomain);
    j["sourceSystem"] = Json(value.sourceSystem);
    j["lifecycleState"] = Json(value.lifecycleState);
    j["parentId"] = Json(value.parentId);
    j["owner"] = Json(value.owner);
    j["description"] = Json(value.description);
    j["externalReference"] = Json(value.externalReference);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);

    auto metadata = Json.emptyObject;
    foreach (k, v; value.metadata) {
        metadata[k] = Json(v);
    }
    j["metadata"] = metadata;
    return j;
}

string mtJsonStr(Json j, string key) {
    if ((key in j) is null) {
        return "";
    }

    try {
        return j[key].get!string;
    } catch (Exception ex) {
        return "";
    }
}

string[string] mtJsonStringMap(Json j, string key) {
    string[string] result;
    if ((key in j) is null) {
        return result;
    }

    try {
        auto map = j[key].get!(Json[string]);
        foreach (string k, value; map) {
            if (value.type == Json.Type.string) {
                result[k] = value.get!string;
            }
        }
    } catch (Exception ex) {
    }

    return result;
}
