module uim.platform.ecm.presentation.http.controllers.document_api;

import std.conv : to;
import uim.platform.ecm;

@safe:

class DocumentApiController : SAPController {
    private ManageEcmObjectsUseCase manageUseCase;
    private QueryDocumentsUseCase queryUseCase;

    this(ManageEcmObjectsUseCase manageUseCase, QueryDocumentsUseCase queryUseCase) {
        this.manageUseCase = manageUseCase;
        this.queryUseCase = queryUseCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/ecm/search/documents", &handleSearchDocuments);
        router.get("/api/v1/ecm/document-versions/by-document/*", &handleListDocumentVersions);
    }

    private void handleSearchDocuments(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!ensureReadAccess(req, res)) {
            return;
        }

        auto query = req.query.get("q", "");
        auto items = queryUseCase.search(query);
        writeCollection(res, items);
    }

    private void handleListDocumentVersions(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!ensureReadAccess(req, res)) {
            return;
        }

        auto documentId = extractIdFromPath(req.requestPath.to!string);
        auto items = manageUseCase.listDocumentVersions(documentId);
        writeCollection(res, items);
    }

    private void writeCollection(scope HTTPServerResponse res, EcmObject[] items) {
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= objectToJson(item);
        }

        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["resources"] = arr;
        res.writeJsonBody(payload, 200);
    }
}
