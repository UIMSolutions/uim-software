module uim.platform.mii.presentation.http.controllers.health;

import uim.platform.mii;

@safe:

class MiiHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
        router.get("/", &handleRoot);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeJsonBody(res, Json(["service": Json("Manufacturing Integration and Intelligence"), "status": Json("ok") ]));
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeJsonBody(res, Json(["status": Json("ok") ]));
    }
}
