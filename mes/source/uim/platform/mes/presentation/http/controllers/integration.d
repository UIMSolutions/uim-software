module uim.platform.mes.presentation.http.controllers.integration;

import std.conv : to;
import uim.platform.mes;

@safe:

class IntegrationController : SAPController {
    private RunMesIntegrationsUseCase useCase;

    this(RunMesIntegrationsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.post("/api/v1/mes/integrations/order-sync/*", &handleProductHandover);
        router.post("/api/v1/mes/integrations/quality-sync/*", &handleSpecificationSync);
    }

    private void handleProductHandover(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.handoverProduct(id);
        if (!result.success) {
            auto status = result.error == "Production order not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        writeJsonBody(res, Json([
            "id": Json(id),
            "externalId": Json(result.id),
            "message": Json(result.error.length ? result.error : "Order sync completed")
        ]));
    }

    private void handleSpecificationSync(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.syncSpecification(id);
        if (!result.success) {
            auto status = result.error == "Quality inspection not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        writeJsonBody(res, Json([
            "id": Json(id),
            "externalId": Json(result.id),
            "message": Json(result.error.length ? result.error : "Quality sync completed")
        ]));
    }
}
