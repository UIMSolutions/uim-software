module uim.platform.freight_collaboration.presentation.http.json_utils;

import uim.platform.freight_collaboration;
import vibe.http.server : HTTPServerResponse;

@safe:

void writeJsonBody(scope HTTPServerResponse res, Json body, int status = 200) {
    res.writeJsonBody(body, status);
}

Json freightOrderToJson(FreightOrder value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["orderNumber"] = Json(value.orderNumber);
    j["shipperId"] = Json(value.shipperId);
    j["carrierId"] = Json(value.carrierId);
    j["transportMode"] = Json(value.transportMode);
    j["status"] = Json(value.status);
    j["originLocation"] = Json(value.originLocation);
    j["destinationLocation"] = Json(value.destinationLocation);
    j["plannedPickup"] = Json(value.plannedPickup);
    j["plannedDelivery"] = Json(value.plannedDelivery);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json tenderToJson(Tender value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["freightOrderId"] = Json(value.freightOrderId);
    j["tenderNumber"] = Json(value.tenderNumber);
    j["status"] = Json(value.status);
    j["offeredRate"] = Json(value.offeredRate);
    j["currency"] = Json(value.currency);
    j["responseBy"] = Json(value.responseBy);
    j["awardedCarrierId"] = Json(value.awardedCarrierId);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json milestoneToJson(MilestoneUpdate value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["freightOrderId"] = Json(value.freightOrderId);
    j["milestoneType"] = Json(value.milestoneType);
    j["eventTime"] = Json(value.eventTime);
    j["location"] = Json(value.location);
    j["statusComment"] = Json(value.statusComment);
    j["reportedBy"] = Json(value.reportedBy);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}
