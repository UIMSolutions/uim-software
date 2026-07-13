module uim.platform.content.presentation.http.controllers.repositories;

import std.conv : to;
import uim.platform.content;

@safe:

class RepositoryController : SAPController {
    private ManageContentRepositoriesUseCase useCase;

    this(ManageContentRepositoriesUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/content/repositories", &handleList);
        router.get("/api/v1/content/repositories/*", &handleGet);
        router.post("/api/v1/content/repositories", &handleCreate);
        router.put("/api/v1/content/repositories/*", &handleUpdate);
        router.delete_("/api/v1/content/repositories/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= repositoryToJson(item);
        }

        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["resources"] = arr;
        res.writeJsonBody(payload, 200);
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) {
            writeError(res, 404, "Repository not found");
            return;
        }
        res.writeJsonBody(repositoryToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ContentRepositoryDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.storageType = jsonStr(j, "storageType");
        dto.basePath = jsonStr(j, "basePath");
        dto.status = jsonStr(j, "status");
        dto.createdBy = jsonStr(j, "createdBy");

        auto result = useCase.create(dto);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 201);
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ContentRepositoryDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.storageType = jsonStr(j, "storageType");
        dto.basePath = jsonStr(j, "basePath");
        dto.status = jsonStr(j, "status");
        dto.modifiedBy = jsonStr(j, "modifiedBy");

        auto result = useCase.update(dto);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 200);
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        res.writeBody("", 204, "text/plain");
    }
}
