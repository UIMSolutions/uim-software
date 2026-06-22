module uim.platform.apm.presentation.http.controllers.health;

import uim.platform.apm;

@safe:

class ApmHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/", &handleRoot);
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = Json([
            "service": Json("Application Portfolio Assessment"),
            "status": Json("ok")
        ]);
        writeJsonBody(res, body);
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeJsonBody(res, Json(["status": Json("ok") ]));
    }
}
