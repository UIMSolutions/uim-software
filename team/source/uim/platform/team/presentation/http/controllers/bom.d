module uim.platform.team.presentation.http.controllers.bom;

import std.conv : to;
import uim.platform.team;

@safe:

class BomController : SAPController {
    private ManageBomsUseCase useCase;

    this(ManageBomsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/team/boms", &handleList);
        router.get("/api/v1/team/boms/*", &handleGet);
        router.post("/api/v1/team/boms", &handleCreate);
        router.put("/api/v1/team/boms/*", &handleUpdate);
        router.delete_("/api/v1/team/boms/*", &handleDelete);
    }

    private BomLineDTO[] parseLines(Json j) {
        BomLineDTO[] lines;
        if (!j.hasKey("lines") || !j["lines"].isArray)
            return lines;

        foreach (lineJ; j["lines"].toArray) {
            if (!lineJ.isObject)
                continue;
            BomLineDTO line;
            line.childPartId = jsonStr(lineJ, "childPartId");
            line.quantity = jsonStr(lineJ, "quantity");
            line.unitOfMeasure = jsonStr(lineJ, "unitOfMeasure");
            line.findNumber = jsonStr(lineJ, "findNumber");
            line.effectivity = jsonStr(lineJ, "effectivity");
            lines ~= line;
        }
        return lines;
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.listByTenant(req.headers.get("X-Tenant-Id", ""));
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= bomToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "BOM not found"); return; }
        writeJsonBody(res, bomToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        BomDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.parentPartId = jsonStr(j, "parentPartId");
        dto.name = jsonStr(j, "name");
        dto.revision = jsonStr(j, "revision");
        dto.lines = parseLines(j);
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");

        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        BomDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.revision = jsonStr(j, "revision");
        dto.lines = parseLines(j);
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");

        auto result = useCase.update(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) { writeError(res, 404, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.noContent;
        res.writeBody("");
    }
}
