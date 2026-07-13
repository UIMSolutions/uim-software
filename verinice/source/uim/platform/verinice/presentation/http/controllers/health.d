module uim.platform.verinice.presentation.http.controllers.health;

import uim.platform.verinice;

@safe:

class VeriniceHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
        router.get("/", &handleRoot);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = Json.emptyObject;
        body["service"] = Json("Verinice IT-Grundschutz");
        body["status"] = Json("ok");
        writeJsonBody(res, body);
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = Json.emptyObject;
        body["status"] = Json("ok");
        writeJsonBody(res, body);
    }
}
