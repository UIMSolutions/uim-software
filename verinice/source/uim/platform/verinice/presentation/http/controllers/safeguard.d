module uim.platform.verinice.presentation.http.controllers.safeguard;

import std.conv : to;
import uim.platform.verinice;

@safe:

class SafeguardController : SAPController {
    private ManageSafeguardsUseCase useCase;

    this(ManageSafeguardsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/verinice/safeguards", &handleList);
        router.get("/api/v1/verinice/safeguards/*", &handleGet);
        router.post("/api/v1/verinice/safeguards", &handleCreate);
        router.put("/api/v1/verinice/safeguards/*", &handleUpdate);
        router.delete_("/api/v1/verinice/safeguards/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items)
            arr ~= safeguardToJson(item);

        auto body = Json.emptyObject;
        body["count"] = Json(cast(long)items.length);
        body["resources"] = arr;
        writeJsonBody(res, body);
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) {
            writeError(res, 404, "Safeguard not found");
            return;
        }
        writeJsonBody(res, safeguardToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        SafeguardDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.assetId = jsonStr(j, "assetId");
        dto.code = jsonStr(j, "code");
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.implementationStatus = jsonStr(j, "implementationStatus");
        dto.maturityLevel = jsonStr(j, "maturityLevel");
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
        SafeguardDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.assetId = jsonStr(j, "assetId");
        dto.code = jsonStr(j, "code");
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.implementationStatus = jsonStr(j, "implementationStatus");
        dto.maturityLevel = jsonStr(j, "maturityLevel");
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
