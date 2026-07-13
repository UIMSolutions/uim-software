module uim.platform.content.presentation.http.controllers.integration;

import std.conv : to;
import uim.platform.content;

@safe:

class IntegrationController : SAPController {
    private PushContentDocumentUseCase useCase;

    this(PushContentDocumentUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.post("/api/v1/content/integrations/push-document/*", &handlePushDocument);
    }

    private void handlePushDocument(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto documentId = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.pushDocument(documentId);

        if (!result.success) {
            auto status = result.error == "Document not found" ? 404 : 502;
            writeError(res, status, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(documentId);
        payload["publishTicket"] = Json(result.id);
        payload["message"] = Json(result.error.length ? result.error : "Document push accepted");
        res.writeJsonBody(payload, 200);
    }
}
