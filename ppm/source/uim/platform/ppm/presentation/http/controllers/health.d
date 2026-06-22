module uim.platform.ppm.presentation.http.controllers.health;

import uim.platform.ppm;

@safe:

class PpmHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
        router.get("/", &handleRoot);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = Json([
            "service": Json("Enterprise Portfolio and Project Management"),
            "status": Json("ok")
        ]);
        writeJsonBody(res, body);
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeJsonBody(res, Json(["status": Json("ok") ]));
    }
}
