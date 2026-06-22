module uim.platform.ppm.presentation.http.controllers.initiative;

import std.conv : to;
import uim.platform.ppm;

@safe:

class InitiativeController : SAPController {
    private ManageInitiativesUseCase useCase;

    this(ManageInitiativesUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/ppm/initiatives", &handleList);
        router.get("/api/v1/ppm/initiatives/*", &handleGet);
        router.post("/api/v1/ppm/initiatives", &handleCreate);
        router.put("/api/v1/ppm/initiatives/*", &handleUpdate);
        router.delete_("/api/v1/ppm/initiatives/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= initiativeToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Initiative not found"); return; }
        writeJsonBody(res, initiativeToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        InitiativeDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.portfolioId = jsonStr(j, "portfolioId");
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.category = jsonStr(j, "category");
        dto.priority = jsonStr(j, "priority");
        dto.status = jsonStr(j, "status");
        dto.sponsor = jsonStr(j, "sponsor");
        dto.expectedBenefits = jsonStr(j, "expectedBenefits");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        InitiativeDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.portfolioId = jsonStr(j, "portfolioId");
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.category = jsonStr(j, "category");
        dto.priority = jsonStr(j, "priority");
        dto.status = jsonStr(j, "status");
        dto.sponsor = jsonStr(j, "sponsor");
        dto.expectedBenefits = jsonStr(j, "expectedBenefits");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
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
