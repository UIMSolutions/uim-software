module uim.platform.verinice.presentation.http.controllers.asset;

import std.conv : to;
import uim.platform.verinice;

@safe:

class AssetController : SAPController {
    private ManageAssetsUseCase useCase;

    this(ManageAssetsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/verinice/assets", &handleList);
        router.get("/api/v1/verinice/assets/*", &handleGet);
        router.post("/api/v1/verinice/assets", &handleCreate);
        router.put("/api/v1/verinice/assets/*", &handleUpdate);
        router.delete_("/api/v1/verinice/assets/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items)
            arr ~= assetToJson(item);

        auto body = Json.emptyObject;
        body["count"] = Json(cast(long)items.length);
        body["resources"] = arr;
        writeJsonBody(res, body);
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) {
            writeError(res, 404, "Asset not found");
            return;
        }
        writeJsonBody(res, assetToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        AssetDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.assetType = jsonStr(j, "assetType");
        dto.confidentiality = jsonStr(j, "confidentiality");
        dto.integrity = jsonStr(j, "integrity");
        dto.availability = jsonStr(j, "availability");
        dto.owner = jsonStr(j, "owner");
        dto.createdBy = jsonStr(j, "createdBy");

        auto result = useCase.create(dto);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }

        res.statusCode = cast(int)HTTPStatus.created;
        auto body = Json.emptyObject;
        body["id"] = Json(result.id);
        writeJsonBody(res, body);
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        AssetDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.assetType = jsonStr(j, "assetType");
        dto.confidentiality = jsonStr(j, "confidentiality");
        dto.integrity = jsonStr(j, "integrity");
        dto.availability = jsonStr(j, "availability");
        dto.owner = jsonStr(j, "owner");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");

        auto result = useCase.update(dto);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        auto body = Json.emptyObject;
        body["id"] = Json(result.id);
        writeJsonBody(res, body);
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }
        res.statusCode = cast(int)HTTPStatus.noContent;
        res.writeBody("");
    }
}
