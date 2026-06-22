module uim.platform.ppm.presentation.http.controllers.portfolio;

import std.conv : to;
import uim.platform.ppm;

@safe:

class PortfolioController : SAPController {
    private ManagePortfoliosUseCase useCase;

    this(ManagePortfoliosUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/ppm/portfolios", &handleList);
        router.get("/api/v1/ppm/portfolios/*", &handleGet);
        router.post("/api/v1/ppm/portfolios", &handleCreate);
        router.put("/api/v1/ppm/portfolios/*", &handleUpdate);
        router.delete_("/api/v1/ppm/portfolios/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= portfolioToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Portfolio not found"); return; }
        writeJsonBody(res, portfolioToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PortfolioDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.strategicTheme = jsonStr(j, "strategicTheme");
        dto.status = jsonStr(j, "status");
        dto.planningHorizon = jsonStr(j, "planningHorizon");
        dto.owner = jsonStr(j, "owner");
        dto.budgetAmount = jsonStr(j, "budgetAmount");
        dto.currency = jsonStr(j, "currency");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PortfolioDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.strategicTheme = jsonStr(j, "strategicTheme");
        dto.status = jsonStr(j, "status");
        dto.planningHorizon = jsonStr(j, "planningHorizon");
        dto.owner = jsonStr(j, "owner");
        dto.budgetAmount = jsonStr(j, "budgetAmount");
        dto.currency = jsonStr(j, "currency");
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
