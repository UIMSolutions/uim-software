module uim.platform.ewm.presentation.http.controllers.health;

import uim.platform.ewm;

@safe:

class EwmHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
        router.get("/", &handleRoot);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeJsonBody(res, Json(["service": Json("Extended Warehouse Management"), "status": Json("ok") ]));
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeJsonBody(res, Json(["status": Json("ok") ]));
    }
}
