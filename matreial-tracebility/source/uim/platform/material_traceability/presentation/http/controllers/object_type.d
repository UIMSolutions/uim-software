module uim.platform.material_traceability.presentation.http.controllers.object_type;

import std.conv : to;
import std.format : format;
import uim.platform.material_traceability;

@safe:

class ObjectTypeController : SAPController {
    private ManageMtObjectsUseCase manageUseCase;
    private string objectType;

    this(ManageMtObjectsUseCase manageUseCase, string objectType) {
        this.manageUseCase = manageUseCase;
        this.objectType = objectType;
    }

    override void registerRoutes(URLRouter router) {
        auto basePath = format("/api/v1/mt/%s", objectType);
        router.get(basePath, &handleList);
        router.get(basePath ~ "/*", &handleGet);
        router.post(basePath, &handleCreate);
        router.put(basePath ~ "/*", &handleUpdate);
        router.delete_(basePath ~ "/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto items = manageUseCase.list(objectType);
        writeCollection(res, items);
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = manageUseCase.get_(objectType, id);
        if (item is null) {
            writeError(res, 404, "Object not found");
            return;
        }

        res.writeJsonBody(objectToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureWrite(req, res, objectType)) {
            return;
        }

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
        if (!AuthGuard.ensureWrite(req, res, objectType)) {
            return;
        }

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
        if (!AuthGuard.ensureWrite(req, res, objectType)) {
            return;
        }

        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = manageUseCase.remove(objectType, id);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        res.writeBody("", 204, "text/plain");
    }

    private MtObjectDTO requestToDto(scope HTTPServerRequest req, string id) {
        auto j = req.json;

        MtObjectDTO dto;
        dto.id = id.length ? id : mtJsonStr(j, "id");
        dto.objectType = objectType;
        dto.tenantId = req.headers.get("X-Tenant-Id", "default");
        dto.technicalName = mtJsonStr(j, "technicalName");
        dto.businessName = mtJsonStr(j, "businessName");
        dto.traceabilityDomain = mtJsonStr(j, "traceabilityDomain");
        dto.sourceSystem = mtJsonStr(j, "sourceSystem");
        dto.lifecycleState = mtJsonStr(j, "lifecycleState");
        dto.parentId = mtJsonStr(j, "parentId");
        dto.owner = mtJsonStr(j, "owner");
        dto.description = mtJsonStr(j, "description");
        dto.externalReference = mtJsonStr(j, "externalReference");
        dto.createdBy = mtJsonStr(j, "createdBy");
        dto.modifiedBy = mtJsonStr(j, "modifiedBy");
        dto.metadata = mtJsonStringMap(j, "metadata");

        return dto;
    }

    private void writeCollection(scope HTTPServerResponse res, MtObject[] items) {
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
