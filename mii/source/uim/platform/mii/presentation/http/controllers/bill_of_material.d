module uim.platform.mii.presentation.http.controllers.bill_of_material;

import std.conv : to;
import uim.platform.mii;

@safe:

class BillOfMaterialController : SAPController {
    private ManageBillOfMaterialsUseCase useCase;
    this(ManageBillOfMaterialsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/mii/work-center-events", &handleList);
        router.get("/api/v1/mii/work-center-events/*", &handleGet);
        router.post("/api/v1/mii/work-center-events", &handleCreate);
        router.put("/api/v1/mii/work-center-events/*", &handleUpdate);
        router.delete_("/api/v1/mii/work-center-events/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= billOfMaterialToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = useCase.get_(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Bill of material not found"); return; }
        writeJsonBody(res, billOfMaterialToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        BillOfMaterialDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.messageId = jsonStr(j, "messageId");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.bomType = jsonStr(j, "bomType");
        dto.revision = jsonStr(j, "revision");
        dto.usage = jsonStr(j, "usage");
        dto.plant = jsonStr(j, "plant");
        dto.baseQuantity = jsonStr(j, "baseQuantity");
        dto.baseUnit = jsonStr(j, "baseUnit");
        dto.isActive = jsonStr(j, "isActive");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        BillOfMaterialDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.bomType = jsonStr(j, "bomType");
        dto.revision = jsonStr(j, "revision");
        dto.usage = jsonStr(j, "usage");
        dto.plant = jsonStr(j, "plant");
        dto.baseQuantity = jsonStr(j, "baseQuantity");
        dto.baseUnit = jsonStr(j, "baseUnit");
        dto.isActive = jsonStr(j, "isActive");
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
