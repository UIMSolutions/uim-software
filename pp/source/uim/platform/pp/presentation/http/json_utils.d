module uim.platform.pp.presentation.http.json_utils;

import vibe.data.json : Json;
import uim.platform.pp.domain.entities.pp_object : PPObject;

@safe:

Json objectToJson(in PPObject value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["objectType"] = Json(value.objectType);
    j["tenantId"] = Json(value.tenantId);
    j["plantId"] = Json(value.plantId);
    j["materialId"] = Json(value.materialId);
    j["orderId"] = Json(value.orderId);
    j["name"] = Json(value.name);
    j["status"] = Json(value.status);
    j["description"] = Json(value.description);
    j["startDate"] = Json(value.startDate);
    j["endDate"] = Json(value.endDate);
    j["quantity"] = Json(value.quantity);
    j["uom"] = Json(value.uom);
    j["priority"] = Json(value.priority);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);

    auto attributes = Json.emptyObject;
    foreach (k, v; value.attributes) {
        attributes[k] = Json(v);
    }
    j["attributes"] = attributes;
    return j;
}

string[string] jsonStringMap(Json j, string key) {
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
