module uim.platform.freight_collaboration.infrastructure.integrations.sap_bn_fc.tender_sync_http;

import std.net.curl : HTTP, post;
import std.string : startsWith;
import uim.platform.freight_collaboration;

@safe:

class SapBnTenderSyncHttpGateway : TenderSyncGateway {
    private string baseUrl;
    private string syncPath;
    private string apiToken;

    this(string baseUrl, string syncPath, string apiToken) {
        this.baseUrl = baseUrl;
        this.syncPath = syncPath;
        this.apiToken = apiToken;
    }

    override IntegrationResult syncTender(Tender value) {
        if (!baseUrl.length) {
            return IntegrationResult(false, "", "Missing SAP BN base URL");
        }

        auto body = Json.emptyObject;
        body["id"] = Json(value.id);
        body["tenantId"] = Json(value.tenantId);
        body["freightOrderId"] = Json(value.freightOrderId);
        body["tenderNumber"] = Json(value.tenderNumber);
        body["status"] = Json(value.status);
        body["offeredRate"] = Json(value.offeredRate);
        body["currency"] = Json(value.currency);
        body["responseBy"] = Json(value.responseBy);
        body["awardedCarrierId"] = Json(value.awardedCarrierId);

        auto url = buildUrl(baseUrl, syncPath);
        auto payload = body.toString();

        try {
            sendJson(url, payload, apiToken);
            return IntegrationResult(
                true,
                "sap-bn-fc-" ~ value.tenderNumber ~ "-" ~ value.id,
                "Tender synced with SAP Business Network Freight Collaboration"
            );
        } catch (Exception ex) {
            return IntegrationResult(false, "", "Tender sync failed: " ~ ex.msg);
        }
    }
}

private string buildUrl(string baseUrl, string path) {
    auto normalizedBase = baseUrl;
    while (normalizedBase.length > 0 && normalizedBase[$ - 1] == '/') {
        normalizedBase = normalizedBase[0 .. $ - 1];
    }

    auto normalizedPath = path.length ? path : "/";
    if (!normalizedPath.startsWith("/")) {
        normalizedPath = "/" ~ normalizedPath;
    }

    return normalizedBase ~ normalizedPath;
}

@trusted
private void sendJson(string url, string payload, string apiToken) {
    auto http = new HTTP();
    http.addRequestHeader("Content-Type", "application/json");
    http.addRequestHeader("Accept", "application/json");
    if (apiToken.length) {
        http.addRequestHeader("Authorization", "Bearer " ~ apiToken);
    }

    auto bytes = cast(ubyte[]) payload.dup;
    post(url, bytes, http);
}
