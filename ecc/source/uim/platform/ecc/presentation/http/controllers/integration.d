module uim.platform.ecc.presentation.http.controllers.integration;

import std.conv : to;
import uim.platform.ecc;

@safe:

class IntegrationController : SAPController {
    private RunEccIntegrationsUseCase useCase;

    this(RunEccIntegrationsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.post("/api/v1/ecc/integrations/material-master-sync/*", &handleProductHandover);
        router.post("/api/v1/ecc/integrations/document-info-record-sync/*", &handleSpecificationSync);
    }

    private void handleProductHandover(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.handoverProduct(id);
        if (!result.success) {
            auto status = result.error == "Product not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        writeJsonBody(res, Json([
            "id": Json(id),
            "externalId": Json(result.id),
            "message": Json(result.error.length ? result.error : "Product handover completed")
        ]));
    }

    private void handleSpecificationSync(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.syncSpecification(id);
        if (!result.success) {
            auto status = result.error == "Specification not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        writeJsonBody(res, Json([
            "id": Json(id),
            "externalId": Json(result.id),
            "message": Json(result.error.length ? result.error : "Specification sync completed")
        ]));
    }
}
