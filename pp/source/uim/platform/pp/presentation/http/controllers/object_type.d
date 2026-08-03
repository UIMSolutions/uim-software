module uim.platform.pp.presentation.http.controllers.object_type;

import std.conv : to;
import std.format : format;
import uim.platform.pp;

@safe:

class PPObjectTypeController : SAPController {
    private ManagePPObjectsUseCase manageUseCase;
    private string objectType;

    this(ManagePPObjectsUseCase manageUseCase, string objectType) {
        this.manageUseCase = manageUseCase;
        this.objectType = objectType;
    }

    override void registerRoutes(URLRouter router) {
        auto basePath = format("/api/v1/pp/%s", objectType);
        router.get(basePath, &handleList);
        router.get(basePath ~ "/*", &handleGet);
        router.post(basePath, &handleCreate);
        router.put(basePath ~ "/*", &handleUpdate);
        router.delete_(basePath ~ "/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = manageUseCase.list(objectType);
        writeCollection(res, items);
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = manageUseCase.get_(objectType, id);
        if (item is null) {
            writeError(res, 404, "Object not found");
            return;
        }

        res.writeJsonBody(objectToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto dto = requestToDto(req, "");
        auto result = manageUseCase.create(dto);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 201);
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto dto = requestToDto(req, id);

        auto result = manageUseCase.update(dto);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 200);
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = manageUseCase.remove(objectType, id);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        res.writeBody("", 204, "text/plain");
    }

    private PPObjectDTO requestToDto(scope HTTPServerRequest req, string id) {
        auto j = req.json;

        PPObjectDTO dto;
        dto.id = id.length ? id : jsonStr(j, "id");
        dto.objectType = objectType;
        dto.tenantId = req.headers.get("X-Tenant-Id", "default");
        dto.plantId = jsonStr(j, "plantId");
        dto.materialId = jsonStr(j, "materialId");
        dto.orderId = jsonStr(j, "orderId");
        dto.name = jsonStr(j, "name");
        dto.status = jsonStr(j, "status");
        dto.description = jsonStr(j, "description");
        dto.startDate = jsonStr(j, "startDate");
        dto.endDate = jsonStr(j, "endDate");
        dto.quantity = jsonStr(j, "quantity");
        dto.uom = jsonStr(j, "uom");
        dto.priority = jsonStr(j, "priority");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.attributes = jsonStringMap(j, "attributes");

        return dto;
    }

    private void writeCollection(scope HTTPServerResponse res, PPObject[] items) {
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= objectToJson(item);
        }

        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["resources"] = arr;
        res.writeJsonBody(payload, 200);
    }
}
