module uim.platform.etd.presentation.http.controllers.integration;

import std.conv : to;
import uim.platform.etd;

@safe:

class IntegrationController : SAPController {
    private RunEtdIntegrationsUseCase useCase;

    this(RunEtdIntegrationsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.post("/api/v1/etd/integrations/threat-intel-sync/*", &handleThreatIntelSync);
    }

    private void handleThreatIntelSync(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.syncThreatIndicator(id);

        if (!result.success) {
            auto status = result.error == "Threat indicator not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(id);
        payload["externalId"] = Json(result.id);
        payload["message"] = Json(result.error.length ? result.error : "Threat intel sync completed");
        res.writeJsonBody(payload, 200);
    }
}
