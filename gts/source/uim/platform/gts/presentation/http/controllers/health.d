module uim.platform.gts.presentation.http.controllers.health;

import uim.platform.gts;

@safe:

class GTSHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/", &handleRoot);
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = Json.emptyObject;
        body["service"] = Json("gts");
        body["status"] = Json("ok");
        body["message"] = Json("Global Trade Services is running");
        res.writeJsonBody(body, 200);
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = Json.emptyObject;
        body["status"] = Json("UP");
        body["component"] = Json("gts");
        res.writeJsonBody(body, 200);
    }
}
