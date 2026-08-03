module uim.platform.ead.presentation.http.controllers.health;

import uim.platform.ead;

@safe:

class EadHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/", &handleRoot);
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto payload = Json.emptyObject;
        payload["service"] = Json("Enterprise Architecture Designer Cloud Edition");
        payload["status"] = Json("ok");
        res.writeJsonBody(payload, 200);
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto payload = Json.emptyObject;
        payload["status"] = Json("ok");
        res.writeJsonBody(payload, 200);
    }
}
