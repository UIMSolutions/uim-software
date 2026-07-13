module uim.platform.maif.presentation.http.controllers.integration;

import std.conv : to;
import uim.platform.maif;

@safe:

class IntegrationController : SAPController {
    private RunMaifIntegrationsUseCase useCase;

    this(RunMaifIntegrationsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.post("/api/v1/maif/integrations/publish-mobile-app/*", &handlePublishMobileApp);
    }

    private void handlePublishMobileApp(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto appId = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.publishMobileApp(appId);

        if (!result.success) {
            auto status = result.error == "Mobile app not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(appId);
        payload["publishTicket"] = Json(result.id);
        payload["message"] = Json(result.error.length ? result.error : "Mobile app publish accepted");
        res.writeJsonBody(payload, 200);
    }
}
