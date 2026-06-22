module uim.platform.ppm.presentation.http.controllers.demand;

import std.conv : to;
import uim.platform.ppm;

@safe:

class DemandController : SAPController {
    private ManageDemandsUseCase useCase;

    this(ManageDemandsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/ppm/demands", &handleList);
        router.get("/api/v1/ppm/demands/*", &handleGet);
        router.post("/api/v1/ppm/demands", &handleCreate);
        router.put("/api/v1/ppm/demands/*", &handleUpdate);
        router.delete_("/api/v1/ppm/demands/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= demandToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Demand not found"); return; }
        writeJsonBody(res, demandToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        DemandDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.portfolioId = jsonStr(j, "portfolioId");
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.source = jsonStr(j, "source");
        dto.businessValue = jsonStr(j, "businessValue");
        dto.priority = jsonStr(j, "priority");
        dto.status = jsonStr(j, "status");
        dto.requestedBy = jsonStr(j, "requestedBy");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        DemandDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.portfolioId = jsonStr(j, "portfolioId");
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.source = jsonStr(j, "source");
        dto.businessValue = jsonStr(j, "businessValue");
        dto.priority = jsonStr(j, "priority");
        dto.status = jsonStr(j, "status");
        dto.requestedBy = jsonStr(j, "requestedBy");
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
