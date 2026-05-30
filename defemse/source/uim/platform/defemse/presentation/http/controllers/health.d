module uim.platform.defemse.presentation.http.controllers.health;

import vibe.data.json : Json;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerRequest, HTTPServerResponse;
import uim.platform.defemse;

@safe:

class HealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/", &handleRoot);
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
    }

    private void handleRoot(HTTPServerRequest req, HTTPServerResponse res) {
        writeJsonBody(res, Json(["service": Json("Defense & Security"), "status": Json("ok")]));
    }

    private void handleHealth(HTTPServerRequest req, HTTPServerResponse res) {
        writeJsonBody(res, Json(["status": Json("ok")]));
    }
}