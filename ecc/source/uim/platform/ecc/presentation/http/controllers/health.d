module uim.platform.ecc.presentation.http.controllers.health;

import uim.platform.ecc;

@safe:

class EccHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
        router.get("/", &handleRoot);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeJsonBody(res, Json(["service": Json("Engineering Control Center"), "status": Json("ok") ]));
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeJsonBody(res, Json(["status": Json("ok") ]));
    }
}
