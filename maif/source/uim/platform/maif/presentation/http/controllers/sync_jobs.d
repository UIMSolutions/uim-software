module uim.platform.maif.presentation.http.controllers.sync_jobs;

import std.conv : to;
import uim.platform.maif;

@safe:

class SyncJobController : SAPController {
    private ManageSyncJobsUseCase useCase;

    this(ManageSyncJobsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/maif/sync-jobs", &handleList);
        router.get("/api/v1/maif/sync-jobs/*", &handleGet);
        router.post("/api/v1/maif/sync-jobs", &handleCreate);
        router.put("/api/v1/maif/sync-jobs/*", &handleUpdate);
        router.delete_("/api/v1/maif/sync-jobs/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= syncJobToJson(item);
        }

        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["resources"] = arr;
        res.writeJsonBody(payload, 200);
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) {
            writeError(res, 404, "Sync job not found");
            return;
        }
        res.writeJsonBody(syncJobToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;

        SyncJobDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.flowId = jsonStr(j, "flowId");
        dto.triggerType = jsonStr(j, "triggerType");
        dto.status = jsonStr(j, "status");
        dto.startedAt = jsonStr(j, "startedAt");
        dto.finishedAt = jsonStr(j, "finishedAt");
        dto.recordsProcessed = jsonStr(j, "recordsProcessed");
        dto.recordsFailed = jsonStr(j, "recordsFailed");
        dto.lastError = jsonStr(j, "lastError");
        dto.createdBy = jsonStr(j, "createdBy");

        auto result = useCase.create(dto);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 201);
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;

        SyncJobDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.flowId = jsonStr(j, "flowId");
        dto.triggerType = jsonStr(j, "triggerType");
        dto.status = jsonStr(j, "status");
        dto.startedAt = jsonStr(j, "startedAt");
        dto.finishedAt = jsonStr(j, "finishedAt");
        dto.recordsProcessed = jsonStr(j, "recordsProcessed");
        dto.recordsFailed = jsonStr(j, "recordsFailed");
        dto.lastError = jsonStr(j, "lastError");
        dto.modifiedBy = jsonStr(j, "modifiedBy");

        auto result = useCase.update(dto);
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
        auto result = useCase.remove(id);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        payload["message"] = Json("Sync job deleted");
        res.writeJsonBody(payload, 200);
    }
}
