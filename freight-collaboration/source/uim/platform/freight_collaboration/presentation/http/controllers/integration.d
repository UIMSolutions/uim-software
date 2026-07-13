module uim.platform.freight_collaboration.presentation.http.controllers.integration;

import std.conv : to;
import uim.platform.freight_collaboration;

@safe:

class IntegrationController : SAPController {
    private RunFreightCollaborationIntegrationsUseCase useCase;

    this(RunFreightCollaborationIntegrationsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.post("/api/v1/freight-collaboration/integrations/tender-sync/*", &handleTenderSync);
    }

    private void handleTenderSync(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.syncTender(id);

        if (!result.success) {
            auto status = result.error == "Tender not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        auto body = Json.emptyObject;
        body["id"] = Json(id);
        body["externalId"] = Json(result.id);
        body["message"] = Json(result.error.length ? result.error : "Tender sync completed");
        writeJsonBody(res, body);
    }
}
