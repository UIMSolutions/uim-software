module uim.platform.ibp.presentation.http.controllers.integration;

import std.conv : to;
import uim.platform.ibp;

@safe:

class IntegrationController : SAPController {
    private RunIbpIntegrationsUseCase useCase;

    this(RunIbpIntegrationsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.post("/api/v1/ibp/integrations/master-data-sync/*", &handleProductHandover);
        router.post("/api/v1/ibp/integrations/analytics-sync/*", &handleSpecificationSync);
    }

    private void handleProductHandover(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.handoverProduct(id);
        if (!result.success) {
            auto status = result.error == "Demand plan not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        writeJsonBody(res, Json([
            "id": Json(id),
            "externalId": Json(result.id),
            "message": Json(result.error.length ? result.error : "Master data sync completed")
        ]));
    }

    private void handleSpecificationSync(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.syncSpecification(id);
        if (!result.success) {
            auto status = result.error == "Scenario simulation not found" ? 404 : 502;
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
