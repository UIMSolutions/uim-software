module uim.platform.npc.presentation.http.controllers.health;

import uim.platform.npc;

@safe:

class NpcHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        router.get("/", &handleRoot);
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto payload = Json.emptyObject;
        payload["service"] = Json("Planning Collaboration in Business Network");
        payload["status"] = Json("ok");
        res.writeJsonBody(payload, 200);
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto payload = Json.emptyObject;
        payload["status"] = Json("ok");
        res.writeJsonBody(payload, 200);
    }
}
