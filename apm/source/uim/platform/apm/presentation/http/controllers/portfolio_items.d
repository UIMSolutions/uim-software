module uim.platform.apm.presentation.http.controllers.portfolio_items;

import std.conv : to;
import uim.platform.apm;

@safe:

class PortfolioItemsController : SAPController {
    private ManagePortfolioItemsUseCase useCase;

    this(ManagePortfolioItemsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/apm/applications", &handleList);
        router.get("/api/v1/apm/applications/*", &handleGet);
        router.post("/api/v1/apm/applications", &handleCreate);
        router.put("/api/v1/apm/applications/*", &handleUpdate);
        router.delete_("/api/v1/apm/applications/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto tenantId = req.headers.get("X-Tenant-Id", "");
        auto items = useCase.listByTenant(tenantId);
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= portfolioItemToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Application not found"); return; }
        writeJsonBody(res, portfolioItemToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PortfolioItemDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.businessCapability = jsonStr(j, "businessCapability");
        dto.organization = jsonStr(j, "organization");
        dto.lifecyclePhase = jsonStr(j, "lifecyclePhase");
        dto.businessCriticality = jsonStr(j, "businessCriticality");
        dto.annualCostUsd = jsonStr(j, "annualCostUsd");
        dto.owner = jsonStr(j, "owner");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");

        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }

        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PortfolioItemDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.businessCapability = jsonStr(j, "businessCapability");
        dto.organization = jsonStr(j, "organization");
        dto.lifecyclePhase = jsonStr(j, "lifecyclePhase");
        dto.businessCriticality = jsonStr(j, "businessCriticality");
        dto.annualCostUsd = jsonStr(j, "annualCostUsd");
        dto.owner = jsonStr(j, "owner");
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
