module uim.platform.epd.presentation.http.controllers.health;

import uim.platform.epd;

@safe:

class EpdHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
        router.get("/", &handleRoot);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeJsonBody(res, Json(["service": Json("Integrated Product Development"), "status": Json("ok") ]));
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeJsonBody(res, Json(["status": Json("ok") ]));
    }
}
