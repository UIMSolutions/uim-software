module uim.platform.content.presentation.http.controllers.folders;

import std.conv : to;
import uim.platform.content;

@safe:

class FolderController : SAPController {
    private ManageFoldersUseCase useCase;

    this(ManageFoldersUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/content/folders", &handleList);
        router.get("/api/v1/content/folders/*", &handleGet);
        router.post("/api/v1/content/folders", &handleCreate);
        router.put("/api/v1/content/folders/*", &handleUpdate);
        router.delete_("/api/v1/content/folders/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= folderToJson(item);
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
            writeError(res, 404, "Folder not found");
            return;
        }
        res.writeJsonBody(folderToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        FolderDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.repositoryId = jsonStr(j, "repositoryId");
        dto.parentFolderId = jsonStr(j, "parentFolderId");
        dto.name = jsonStr(j, "name");
        dto.path = jsonStr(j, "path");
        dto.description = jsonStr(j, "description");
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
        FolderDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.repositoryId = jsonStr(j, "repositoryId");
        dto.parentFolderId = jsonStr(j, "parentFolderId");
        dto.name = jsonStr(j, "name");
        dto.path = jsonStr(j, "path");
        dto.description = jsonStr(j, "description");
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
