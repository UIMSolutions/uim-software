module uim.platform.freight_collaboration.presentation.http.controllers.milestone;

import std.conv : to;
import uim.platform.freight_collaboration;

@safe:

class MilestoneController : SAPController {
    private ManageMilestonesUseCase useCase;

    this(ManageMilestonesUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/freight-collaboration/milestones", &handleList);
        router.get("/api/v1/freight-collaboration/milestones/*", &handleGet);
        router.post("/api/v1/freight-collaboration/milestones", &handleCreate);
        router.put("/api/v1/freight-collaboration/milestones/*", &handleUpdate);
        router.delete_("/api/v1/freight-collaboration/milestones/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= milestoneToJson(item);

        auto body = Json.emptyObject;
        body["count"] = Json(cast(long) items.length);
        body["resources"] = arr;
        writeJsonBody(res, body);
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) {
            writeError(res, 404, "Milestone not found");
            return;
        }
        writeJsonBody(res, milestoneToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        MilestoneUpdateDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.freightOrderId = jsonStr(j, "freightOrderId");
        dto.milestoneType = jsonStr(j, "milestoneType");
        dto.eventTime = jsonStr(j, "eventTime");
        dto.location = jsonStr(j, "location");
        dto.statusComment = jsonStr(j, "statusComment");
        dto.reportedBy = jsonStr(j, "reportedBy");
        dto.createdBy = jsonStr(j, "createdBy");

        auto result = useCase.create(dto);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }

        res.statusCode = cast(int) HTTPStatus.created;
        auto body = Json.emptyObject;
        body["id"] = Json(result.id);
        writeJsonBody(res, body);
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        MilestoneUpdateDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.freightOrderId = jsonStr(j, "freightOrderId");
        dto.milestoneType = jsonStr(j, "milestoneType");
        dto.eventTime = jsonStr(j, "eventTime");
        dto.location = jsonStr(j, "location");
        dto.statusComment = jsonStr(j, "statusComment");
        dto.reportedBy = jsonStr(j, "reportedBy");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");

        auto result = useCase.update(dto);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        auto body = Json.emptyObject;
        body["id"] = Json(result.id);
        writeJsonBody(res, body);
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }
        res.statusCode = cast(int) HTTPStatus.noContent;
        res.writeBody("");
    }
}
