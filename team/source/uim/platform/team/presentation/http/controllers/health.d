module uim.platform.team.presentation.http.controllers.health;

import uim.platform.team;

@safe:

class TeamHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/", &handleRoot);
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeJsonBody(res, Json([
            "service": Json("Product Lifecycle Management"),
            "status": Json("ok")
        ]));
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeJsonBody(res, Json(["status": Json("ok") ]));
    }
}
