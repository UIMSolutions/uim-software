module uim.platform.bn_supply_chain.presentation.http.health_controller;

import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerRequest, HTTPServerResponse;

class HealthController {
    void registerRoutes(URLRouter router) {
        router.get("/", &health);
        router.get("/health", &health);
        router.get("/api/v1/health", &health);
    }

    void health(HTTPServerRequest req, HTTPServerResponse res) {
        res.writeJsonBody(["status": "ok", "service": "bn-supply-chain"], 200);
    }
}
