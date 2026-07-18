module uim.platform.dm.presentation.http.controllers.health;

import uim.platform.dm;

@safe:

class DMHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/", &handleRoot);
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = Json.emptyObject;
        body["service"] = Json("dm");
        body["status"] = Json("ok");
        body["message"] = Json("Digital Manufacturing service is running");
        res.writeJsonBody(body, 200);
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = Json.emptyObject;
        body["status"] = Json("UP");
        body["component"] = Json("dm");
        res.writeJsonBody(body, 200);
    }
}
