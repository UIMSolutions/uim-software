module uim.platform.ewm.presentation.http.controllers.integration;

import std.conv : to;
import uim.platform.ewm;

@safe:

class IntegrationController : SAPController {
    private RunEwmIntegrationsUseCase useCase;

    this(RunEwmIntegrationsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.post("/api/v1/ewm/integrations/warehouse-master-sync/*", &handleProductHandover);
        router.post("/api/v1/ewm/integrations/stock-sync/*", &handleSpecificationSync);
    }

    private void handleProductHandover(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.handoverProduct(id);
        if (!result.success) {
            auto status = result.error == "Warehouse not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        writeJsonBody(res, Json([
            "id": Json(id),
            "externalId": Json(result.id),
            "message": Json(result.error.length ? result.error : "Warehouse sync completed")
        ]));
    }

    private void handleSpecificationSync(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.syncSpecification(id);
        if (!result.success) {
            auto status = result.error == "Stock item not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        writeJsonBody(res, Json([
            "id": Json(id),
            "externalId": Json(result.id),
            "message": Json(result.error.length ? result.error : "Stock sync completed")
        ]));
    }
}
