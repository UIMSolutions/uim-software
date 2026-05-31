module uim.platform.ibp.presentation.http.controllers.product_structure;

import std.conv : to;
import uim.platform.ibp;

@safe:

class ProductStructureController : SAPController {
    private ManageProductStructuresUseCase useCase;
    this(ManageProductStructuresUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/ibp/planning-areas", &handleList);
        router.get("/api/v1/ibp/planning-areas/*", &handleGet);
        router.post("/api/v1/ibp/planning-areas", &handleCreate);
        router.put("/api/v1/ibp/planning-areas/*", &handleUpdate);
        router.delete_("/api/v1/ibp/planning-areas/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= productStructureToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = useCase.get_(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Product structure not found"); return; }
        writeJsonBody(res, productStructureToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ProductStructureDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.demandPlanId = jsonStr(j, "demandPlanId");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.nodeType = jsonStr(j, "nodeType");
        dto.parentNodeId = jsonStr(j, "parentNodeId");
        dto.childNodeIds = jsonStr(j, "childNodeIds");
        dto.quantity = jsonStr(j, "quantity");
        dto.mandatory = jsonStr(j, "mandatory");
        dto.status = jsonStr(j, "status");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ProductStructureDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.nodeType = jsonStr(j, "nodeType");
        dto.parentNodeId = jsonStr(j, "parentNodeId");
        dto.childNodeIds = jsonStr(j, "childNodeIds");
        dto.quantity = jsonStr(j, "quantity");
        dto.mandatory = jsonStr(j, "mandatory");
        dto.status = jsonStr(j, "status");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        auto result = useCase.update(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = useCase.remove(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) { writeError(res, 404, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.noContent;
        res.writeBody("");
    }
}
