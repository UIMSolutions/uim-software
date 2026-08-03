module uim.platform.bw.presentation.http.controllers.object_type;

import std.conv : to;
import std.format : format;
import uim.platform.bw;

@safe:

class ObjectTypeController : SAPController {
    private ManageBwObjectsUseCase manageUseCase;
    private string objectType;

    this(ManageBwObjectsUseCase manageUseCase, string objectType) {
        this.manageUseCase = manageUseCase;
        this.objectType = objectType;
    }

    override void registerRoutes(URLRouter router) {
        auto basePath = format("/api/v1/bw/%s", objectType);
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

    private BwObjectDTO requestToDto(scope HTTPServerRequest req, string id) {
        auto j = req.json;

        BwObjectDTO dto;
        dto.id = id.length ? id : bwJsonStr(j, "id");
        dto.objectType = objectType;
        dto.tenantId = req.headers.get("X-Tenant-Id", "default");
        dto.technicalName = bwJsonStr(j, "technicalName");
        dto.businessName = bwJsonStr(j, "businessName");
        dto.semanticLayer = bwJsonStr(j, "semanticLayer");
        dto.sourceSystem = bwJsonStr(j, "sourceSystem");
        dto.lifecycleState = bwJsonStr(j, "lifecycleState");
        dto.parentId = bwJsonStr(j, "parentId");
        dto.owner = bwJsonStr(j, "owner");
        dto.description = bwJsonStr(j, "description");
        dto.externalReference = bwJsonStr(j, "externalReference");
        dto.createdBy = bwJsonStr(j, "createdBy");
        dto.modifiedBy = bwJsonStr(j, "modifiedBy");
        dto.metadata = bwJsonStringMap(j, "metadata");

        return dto;
    }

    private void writeCollection(scope HTTPServerResponse res, BwObject[] items) {
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
