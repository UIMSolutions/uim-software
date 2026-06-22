module uim.platform.team.presentation.http.controllers.parts;

import std.conv : to;
import uim.platform.team;

@safe:

class PartsController : SAPController {
    private ManagePartsUseCase useCase;

    this(ManagePartsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/team/parts", &handleList);
        router.get("/api/v1/team/parts/*", &handleGet);
        router.post("/api/v1/team/parts", &handleCreate);
        router.put("/api/v1/team/parts/*", &handleUpdate);
        router.delete_("/api/v1/team/parts/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.listByTenant(req.headers.get("X-Tenant-Id", ""));
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= partToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Part not found"); return; }
        writeJsonBody(res, partToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PartDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.number = jsonStr(j, "number");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.revision = jsonStr(j, "revision");
        dto.lifecycleState = jsonStr(j, "lifecycleState");
        dto.owningOrganization = jsonStr(j, "owningOrganization");
        dto.responsibleEngineer = jsonStr(j, "responsibleEngineer");
        dto.materialClass = jsonStr(j, "materialClass");
        dto.unitOfMeasure = jsonStr(j, "unitOfMeasure");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");

        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PartDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.number = jsonStr(j, "number");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.revision = jsonStr(j, "revision");
        dto.lifecycleState = jsonStr(j, "lifecycleState");
        dto.owningOrganization = jsonStr(j, "owningOrganization");
        dto.responsibleEngineer = jsonStr(j, "responsibleEngineer");
        dto.materialClass = jsonStr(j, "materialClass");
        dto.unitOfMeasure = jsonStr(j, "unitOfMeasure");
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
