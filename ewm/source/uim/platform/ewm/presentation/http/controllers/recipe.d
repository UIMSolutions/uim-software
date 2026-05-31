module uim.platform.ewm.presentation.http.controllers.recipe;

import std.conv : to;
import uim.platform.ewm;

@safe:

class RecipeController : SAPController {
    private ManageRecipesUseCase useCase;
    this(ManageRecipesUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/ewm/handling-units", &handleList);
        router.get("/api/v1/ewm/handling-units/*", &handleGet);
        router.post("/api/v1/ewm/handling-units", &handleCreate);
        router.put("/api/v1/ewm/handling-units/*", &handleUpdate);
        router.delete_("/api/v1/ewm/handling-units/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= recipeToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = useCase.get_(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Recipe not found"); return; }
        writeJsonBody(res, recipeToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        RecipeDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.warehouseId = jsonStr(j, "warehouseId");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.recipeType = jsonStr(j, "recipeType");
        dto.status = jsonStr(j, "status");
        dto.recipeNumber = jsonStr(j, "recipeNumber");
        dto.yieldValue = jsonStr(j, "yieldValue");
        dto.yieldUnit = jsonStr(j, "yieldUnit");
        dto.batchSize = jsonStr(j, "batchSize");
        dto.batchUnit = jsonStr(j, "batchUnit");
        dto.shelfLife = jsonStr(j, "shelfLife");
        dto.storageConditions = jsonStr(j, "storageConditions");
        dto.ingredients = jsonStr(j, "ingredients");
        dto.instructions = jsonStr(j, "instructions");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        RecipeDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.recipeType = jsonStr(j, "recipeType");
        dto.status = jsonStr(j, "status");
        dto.recipeNumber = jsonStr(j, "recipeNumber");
        dto.yieldValue = jsonStr(j, "yieldValue");
        dto.yieldUnit = jsonStr(j, "yieldUnit");
        dto.batchSize = jsonStr(j, "batchSize");
        dto.batchUnit = jsonStr(j, "batchUnit");
        dto.shelfLife = jsonStr(j, "shelfLife");
        dto.storageConditions = jsonStr(j, "storageConditions");
        dto.ingredients = jsonStr(j, "ingredients");
        dto.instructions = jsonStr(j, "instructions");
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
