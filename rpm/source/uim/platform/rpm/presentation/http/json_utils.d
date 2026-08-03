module uim.platform.rpm.presentation.http.json_utils;

import std.conv : to;
import vibe.data.json : Json;
import uim.platform.rpm.domain.entities.rpm_object : RpmObject;

@safe:

Json objectToJson(in RpmObject value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["objectType"] = Json(value.objectType);
    j["tenantId"] = Json(value.tenantId);
    j["technicalName"] = Json(value.technicalName);
    j["businessName"] = Json(value.businessName);
    j["lifecycleState"] = Json(value.lifecycleState);
    j["parentId"] = Json(value.parentId);
    j["owner"] = Json(value.owner);
    j["locationId"] = Json(value.locationId);
    j["partnerId"] = Json(value.partnerId);
    j["referenceId"] = Json(value.referenceId);
    j["unitOfMeasure"] = Json(value.unitOfMeasure);
    j["quantity"] = Json(value.quantity);
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

string rpmJsonStr(Json j, string key) {
    if ((key in j) is null) {
        return "";
    }

    try {
        return j[key].get!string;
    } catch (Exception ex) {
        return "";
    }
}

long rpmJsonLong(Json j, string key) {
    auto s = rpmJsonStr(j, key);
    if (!s.length) {
        return 0;
    }

    try {
        return s.to!long;
    } catch (Exception ex) {
        return 0;
    }
}

string[string] rpmJsonStringMap(Json j, string key) {
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
