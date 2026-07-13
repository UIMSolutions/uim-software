module uim.platform.freight_collaboration.presentation.http.controllers.health;

import uim.platform.freight_collaboration;

@safe:

class FreightCollaborationHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
        router.get("/", &handleRoot);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = Json.emptyObject;
        body["service"] = Json("SAP Business Network Freight Collaboration");
        body["status"] = Json("ok");
        writeJsonBody(res, body);
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = Json.emptyObject;
        body["status"] = Json("ok");
        writeJsonBody(res, body);
    }
}
