module uim.platform.team.presentation.http.controllers.changes;

import std.conv : to;
import uim.platform.team;

@safe:

class ChangesController : SAPController {
    private ManageChangesUseCase useCase;

    this(ManageChangesUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/team/changes", &handleList);
        router.get("/api/v1/team/changes/*", &handleGet);
        router.post("/api/v1/team/changes", &handleCreate);
        router.put("/api/v1/team/changes/*", &handleUpdate);
        router.delete_("/api/v1/team/changes/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.listByTenant(req.headers.get("X-Tenant-Id", ""));
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= changeToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Change request not found"); return; }
        writeJsonBody(res, changeToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ChangeRequestDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.changeNumber = jsonStr(j, "changeNumber");
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.state = jsonStr(j, "state");
        dto.severity = jsonStr(j, "severity");
        dto.affectedPartIds = jsonStrArray(j, "affectedPartIds");
        dto.affectedDocumentIds = jsonStrArray(j, "affectedDocumentIds");
        dto.requestedBy = jsonStr(j, "requestedBy");
        dto.approver = jsonStr(j, "approver");
        dto.targetImplementationDate = jsonStr(j, "targetImplementationDate");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");

        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ChangeRequestDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.state = jsonStr(j, "state");
        dto.severity = jsonStr(j, "severity");
        dto.affectedPartIds = jsonStrArray(j, "affectedPartIds");
        dto.affectedDocumentIds = jsonStrArray(j, "affectedDocumentIds");
        dto.requestedBy = jsonStr(j, "requestedBy");
        dto.approver = jsonStr(j, "approver");
        dto.targetImplementationDate = jsonStr(j, "targetImplementationDate");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");

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
