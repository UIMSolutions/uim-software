module uim.platform.workflow.presentation.http.controllers.health;

import uim.platform.workflow;

@safe:

class WorkflowHealthController : SAPController {
    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/", &handleRoot);
        router.get("/health", &handleHealth);
        router.get("/api/v1/health", &handleHealth);
    }

    private void handleRoot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = Json.emptyObject;
        body["service"] = Json("workflow");
        body["status"] = Json("ok");
        body["message"] = Json("Advanced Workflow service is running");
        res.writeJsonBody(body, 200);
    }

    private void handleHealth(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto body = Json.emptyObject;
        body["status"] = Json("UP");
        body["component"] = Json("workflow");
        res.writeJsonBody(body, 200);
    }
}
