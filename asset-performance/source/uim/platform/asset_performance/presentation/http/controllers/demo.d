module uim.software.asset_performance.presentation.http.controllers.demo;

import uim.software.asset_performance;

mixin(ShowModule!());

@safe:

class DemoController : SAPController {
    private Container container;

    this(Container container) {
        this.container = container;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.post("/api/v1/asset-performance/demo/seed", &handleSeed);
    }

    private void handleSeed(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto tenantId = req.headers.get("X-Tenant-Id", "demo-tenant");
            auto seedResult = seedDemoData(container, tenantId);

            auto payload = Json.emptyObject;
            payload["tenantId"] = Json(tenantId);
            payload["inserted"] = Json(cast(long) seedResult.inserted);
            payload["skipped"] = Json(cast(long) seedResult.skipped);
            payload["message"] = Json("Demo dataset seeded successfully");

            res.writeJsonBody(payload, 200);
        } catch (Exception e) {
            writeError(res, 500, "Failed to seed demo dataset");
        }
    }
}