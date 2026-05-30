module uim.platform.defemse.presentation.http.controllers.mission_plans;

import std.conv : to;
import vibe.data.json : Json;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerRequest, HTTPServerResponse, HTTPStatus;
import uim.platform.defemse;

@safe:

class MissionPlanController : SAPController {
    private ManageMissionPlansUseCase useCase;

    this(ManageMissionPlansUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/defemse/missions", &listAll);
        router.get("/api/v1/defemse/missions/*", &getOne);
        router.post("/api/v1/defemse/missions", &create);
        router.put("/api/v1/defemse/missions/*", &update);
        router.delete_("/api/v1/defemse/missions/*", &remove);
    }

    private void listAll(HTTPServerRequest req, HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= missionPlanToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void getOne(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Mission plan not found"); return; }
        writeJsonBody(res, missionPlanToJson(*item));
    }

    private void create(HTTPServerRequest req, HTTPServerResponse res) {
        auto j = req.json;
        MissionPlanDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", jsonStr(j, "tenantId"));
        dto.reference = jsonStr(j, "reference");
        dto.name = jsonStr(j, "name");
        dto.objective = jsonStr(j, "objective");
        dto.missionType = jsonStr(j, "missionType");
        dto.region = jsonStr(j, "region");
        dto.status = jsonStr(j, "status");
        dto.assignedContingentIds = jsonStr(j, "assignedContingentIds");
        dto.locationId = jsonStr(j, "locationId");
        dto.downstreamProcessState = jsonStr(j, "downstreamProcessState");
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
        MissionPlanDTO dto;
        dto.id = id;
        dto.name = jsonStr(j, "name");
        dto.objective = jsonStr(j, "objective");
        dto.missionType = jsonStr(j, "missionType");
        dto.region = jsonStr(j, "region");
        dto.status = jsonStr(j, "status");
        dto.assignedContingentIds = jsonStr(j, "assignedContingentIds");
        dto.locationId = jsonStr(j, "locationId");
        dto.downstreamProcessState = jsonStr(j, "downstreamProcessState");
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