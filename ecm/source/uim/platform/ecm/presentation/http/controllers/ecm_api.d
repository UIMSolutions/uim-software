module uim.platform.ecm.presentation.http.controllers.ecm_api;

import std.conv : to;
import std.file : exists, readText;
import std.path : buildPath;
import std.string : split;
import uim.platform.ecm;

@safe:

class EcmApiController : SAPController {
    private ManageEcmObjectsUseCase manageUseCase;
    private QueryDocumentsUseCase queryUseCase;
    private string webRoot;

    this(ManageEcmObjectsUseCase manageUseCase, QueryDocumentsUseCase queryUseCase, string webRoot) {
        this.manageUseCase = manageUseCase;
        this.queryUseCase = queryUseCase;
        this.webRoot = webRoot;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/ui", &handleUi);

        router.get("/api/v1/ecm/search/documents", &handleSearchDocuments);
        router.get("/api/v1/ecm/document-versions/by-document/*", &handleListDocumentVersions);

        router.get("/api/v1/ecm/*", &handleListOrGet);
        router.post("/api/v1/ecm/*", &handleCreate);
        router.put("/api/v1/ecm/*", &handleUpdate);
        router.delete_("/api/v1/ecm/*", &handleDelete);
    }

    private void handleUi(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto pagePath = buildPath(webRoot, "index.html");
        if (!exists(pagePath)) {
            writeError(res, 404, "UI not found");
            return;
        }
        res.writeBody(readText(pagePath), 200, "text/html; charset=utf-8");
    }

    private void handleSearchDocuments(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto query = req.query.get("q", "");
        auto items = queryUseCase.search(query);
        writeCollection(res, items);
    }

    private void handleListDocumentVersions(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto documentId = extractIdFromPath(req.requestPath.to!string);
        auto items = manageUseCase.listDocumentVersions(documentId);
        writeCollection(res, items);
    }

    private void handleListOrGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto parts = routeParts(req.requestPath.to!string);
        if (parts.length < 4) {
            writeError(res, 404, "Path not found");
            return;
        }

        auto objectType = parts[3];
        if (parts.length == 4) {
            auto items = manageUseCase.list(objectType);
            writeCollection(res, items);
            return;
        }

        if (parts.length != 5) {
            writeError(res, 404, "Path not found");
            return;
        }

        auto id = parts[4];
        auto item = manageUseCase.get_(objectType, id);
        if (item is null) {
            writeError(res, 404, "Object not found");
            return;
        }

        res.writeJsonBody(objectToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto parts = routeParts(req.requestPath.to!string);
        if (parts.length != 4) {
            writeError(res, 404, "Path not found");
            return;
        }

        auto objectType = parts[3];
        auto dto = requestToDto(req, objectType, "");
        auto result = manageUseCase.create(dto);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 201);
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto parts = routeParts(req.requestPath.to!string);
        if (parts.length != 5) {
            writeError(res, 404, "Path not found");
            return;
        }

        auto objectType = parts[3];
        auto id = parts[4];

        auto dto = requestToDto(req, objectType, id);
        auto result = manageUseCase.update(dto);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 200);
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto parts = routeParts(req.requestPath.to!string);
        if (parts.length != 5) {
            writeError(res, 404, "Path not found");
            return;
        }

        auto objectType = parts[3];
        auto id = parts[4];

        auto result = manageUseCase.remove(objectType, id);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        res.writeBody("", 204, "text/plain");
    }

    private EcmObjectDTO requestToDto(scope HTTPServerRequest req, string objectType, string id) {
        auto j = req.json;

        EcmObjectDTO dto;
        dto.id = id.length ? id : jsonStr(j, "id");
        dto.objectType = objectType;
        dto.tenantId = req.headers.get("X-Tenant-Id", "default");
        dto.name = jsonStr(j, "name");
        dto.title = jsonStr(j, "title");
        dto.status = jsonStr(j, "status");
        dto.parentId = jsonStr(j, "parentId");
        dto.owner = jsonStr(j, "owner");
        dto.description = jsonStr(j, "description");
        dto.externalReference = jsonStr(j, "externalReference");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.metadata = jsonStringMap(j, "metadata");

        return dto;
    }

    private string[] routeParts(string path) {
        auto raw = path.split("/");
        string[] parts;
        foreach (part; raw) {
            if (part.length) {
                parts ~= part;
            }
        }
        return parts;
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
