module uim.platform.defemse.presentation.http.controllers.offline_sync_records;

import std.conv : to;
import vibe.data.json : Json;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerRequest, HTTPServerResponse, HTTPStatus;
import uim.platform.defemse;

@safe:

class OfflineSyncRecordController : SAPController {
    private ManageOfflineSyncRecordsUseCase useCase;

    this(ManageOfflineSyncRecordsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/defemse/offline-sync-records", &listAll);
        router.get("/api/v1/defemse/offline-sync-records/*", &getOne);
        router.post("/api/v1/defemse/offline-sync-records", &create);
        router.put("/api/v1/defemse/offline-sync-records/*", &update);
        router.delete_("/api/v1/defemse/offline-sync-records/*", &remove);
    }

    private void listAll(HTTPServerRequest req, HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= offlineSyncRecordToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void getOne(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Offline sync record not found"); return; }
        writeJsonBody(res, offlineSyncRecordToJson(*item));
    }

    private void create(HTTPServerRequest req, HTTPServerResponse res) {
        auto j = req.json;
        OfflineSyncRecordDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", jsonStr(j, "tenantId"));
        dto.recordType = jsonStr(j, "recordType");
        dto.recordId = jsonStr(j, "recordId");
        dto.action = jsonStr(j, "action");
        dto.payload = jsonStr(j, "payload");
        dto.status = jsonStr(j, "status");
        dto.lastSyncedAt = jsonStr(j, "lastSyncedAt");
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
        OfflineSyncRecordDTO dto;
        dto.id = id;
        dto.recordType = jsonStr(j, "recordType");
        dto.recordId = jsonStr(j, "recordId");
        dto.action = jsonStr(j, "action");
        dto.payload = jsonStr(j, "payload");
        dto.status = jsonStr(j, "status");
        dto.lastSyncedAt = jsonStr(j, "lastSyncedAt");
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