module uim.platform.mii.presentation.http.controllers.product;

import std.conv : to;
import uim.platform.mii;

@safe:

class ProductController : SAPController {
    private ManageProductsUseCase useCase;
    this(ManageProductsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/mii/production-messages", &handleList);
        router.get("/api/v1/mii/production-messages/*", &handleGet);
        router.post("/api/v1/mii/production-messages", &handleCreate);
        router.put("/api/v1/mii/production-messages/*", &handleUpdate);
        router.delete_("/api/v1/mii/production-messages/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= productToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Production message not found"); return; }
        writeJsonBody(res, productToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ProductDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.productNumber = jsonStr(j, "productNumber");
        dto.productType = jsonStr(j, "productType");
        dto.lifecycleStatus = jsonStr(j, "lifecycleStatus");
        dto.category = jsonStr(j, "category");
        dto.baseUnit = jsonStr(j, "baseUnit");
        dto.validFrom = jsonStr(j, "validFrom");
        dto.validTo = jsonStr(j, "validTo");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ProductDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.productNumber = jsonStr(j, "productNumber");
        dto.productType = jsonStr(j, "productType");
        dto.lifecycleStatus = jsonStr(j, "lifecycleStatus");
        dto.category = jsonStr(j, "category");
        dto.baseUnit = jsonStr(j, "baseUnit");
        dto.validFrom = jsonStr(j, "validFrom");
        dto.validTo = jsonStr(j, "validTo");
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
