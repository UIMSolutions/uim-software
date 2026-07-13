module uim.platform.verinice.presentation.http.controllers.integration;

import std.conv : to;
import uim.platform.verinice;

@safe:

class IntegrationController : SAPController {
    private RunVeriniceIntegrationsUseCase useCase;

    this(RunVeriniceIntegrationsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.post("/api/v1/verinice/integrations/gs-catalog-sync/*", &handleGsCatalogSync);
    }

    private void handleGsCatalogSync(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.syncSafeguardCatalog(id);

        if (!result.success) {
            auto status = result.error == "Safeguard not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        auto body = Json.emptyObject;
        body["id"] = Json(id);
        body["externalId"] = Json(result.id);
        body["message"] = Json(result.error.length ? result.error : "IT-Grundschutz safeguard sync completed");
        writeJsonBody(res, body);
    }
}
