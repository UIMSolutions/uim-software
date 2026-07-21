module uim.platform.defense.presentation.http.controllers.budget_triggers;

import std.conv : to;
import vibe.data.json : Json;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerRequest, HTTPServerResponse, HTTPStatus;
import uim.platform.defense;

@safe:

class BudgetTriggerController : SAPController {
    private ManageBudgetTriggersUseCase useCase;

    this(ManageBudgetTriggersUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/defense/budget-triggers", &listAll);
        router.get("/api/v1/defense/budget-triggers/*", &getOne);
        router.post("/api/v1/defense/budget-triggers", &create);
        router.put("/api/v1/defense/budget-triggers/*", &update);
        router.delete_("/api/v1/defense/budget-triggers/*", &remove);
    }

    private void listAll(HTTPServerRequest req, HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= budgetTriggerToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void getOne(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Budget trigger not found"); return; }
        writeJsonBody(res, budgetTriggerToJson(*item));
    }

    private void create(HTTPServerRequest req, HTTPServerResponse res) {
        auto j = req.json;
        BudgetTriggerDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", jsonStr(j, "tenantId"));
        dto.missionPlanId = jsonStr(j, "missionPlanId");
        dto.sourceProcess = jsonStr(j, "sourceProcess");
        dto.amount = jsonStr(j, "amount");
        dto.currency = jsonStr(j, "currency");
        dto.triggerReason = jsonStr(j, "triggerReason");
        dto.status = jsonStr(j, "status");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int)HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void update(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto j = req.json;
        BudgetTriggerDTO dto;
        dto.id = id;
        dto.missionPlanId = jsonStr(j, "missionPlanId");
        dto.sourceProcess = jsonStr(j, "sourceProcess");
        dto.amount = jsonStr(j, "amount");
        dto.currency = jsonStr(j, "currency");
        dto.triggerReason = jsonStr(j, "triggerReason");
        dto.status = jsonStr(j, "status");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = useCase.update(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void remove(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) { writeError(res, 404, result.error); return; }
        res.statusCode = cast(int)HTTPStatus.noContent;
        res.writeBody("");
    }
}