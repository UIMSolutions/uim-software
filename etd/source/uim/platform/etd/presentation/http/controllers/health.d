module uim.platform.etd.presentation.http.controllers.health;

import uim.platform.etd;

@safe:

class EtdHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/", &handleRoot);
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto payload = Json.emptyObject;
        payload["service"] = Json("Enterprise Threat Detection");
        payload["status"] = Json("ok");
        res.writeJsonBody(payload, 200);
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto payload = Json.emptyObject;
        payload["status"] = Json("ok");
        res.writeJsonBody(payload, 200);
    }
}
