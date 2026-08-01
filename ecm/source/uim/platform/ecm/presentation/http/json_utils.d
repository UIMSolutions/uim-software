module uim.platform.ecm.presentation.http.json_utils;

import vibe.data.json : Json;
import uim.platform.ecm.domain.entities.ecm_object : EcmObject;

@safe:

Json objectToJson(in EcmObject value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["objectType"] = Json(value.objectType);
    j["tenantId"] = Json(value.tenantId);
    j["name"] = Json(value.name);
    j["title"] = Json(value.title);
    j["status"] = Json(value.status);
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
        // Ignore invalid metadata payloads and keep result empty.
    }

    return result;
}
