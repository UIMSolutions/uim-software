module uim.platform.mii.presentation.http.controllers.integration;

import std.conv : to;
import uim.platform.mii;

@safe:

class IntegrationController : SAPController {
    private RunMiiIntegrationsUseCase useCase;

    this(RunMiiIntegrationsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.post("/api/v1/mii/integrations/erp-message-sync/*", &handleProductHandover);
        router.post("/api/v1/mii/integrations/analytics-sync/*", &handleSpecificationSync);
    }

    private void handleProductHandover(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.handoverProduct(id);
        if (!result.success) {
            auto status = result.error == "Production message not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        writeJsonBody(res, Json([
            "id": Json(id),
            "externalId": Json(result.id),
            "message": Json(result.error.length ? result.error : "ERP message sync completed")
        ]));
    }

    private void handleSpecificationSync(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.syncSpecification(id);
        if (!result.success) {
            auto status = result.error == "Alert notification not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        writeJsonBody(res, Json([
            "id": Json(id),
            "externalId": Json(result.id),
            "message": Json(result.error.length ? result.error : "Analytics sync completed")
        ]));
    }
}
