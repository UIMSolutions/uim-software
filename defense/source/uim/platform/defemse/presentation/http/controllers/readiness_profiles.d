module uim.platform.defense.presentation.http.controllers.readiness_profiles;

import std.conv : to;
import vibe.data.json : Json;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerRequest, HTTPServerResponse, HTTPStatus;
import uim.platform.defense;

@safe:

class ReadinessController : SAPController {
    private ManageReadinessUseCase useCase;

    this(ManageReadinessUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/defense/readiness", &listAll);
        router.get("/api/v1/defense/readiness/*", &getOne);
        router.post("/api/v1/defense/readiness", &create);
        router.put("/api/v1/defense/readiness/*", &update);
        router.delete_("/api/v1/defense/readiness/*", &remove);
    }

    private void listAll(HTTPServerRequest req, HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= readinessProfileToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void getOne(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Readiness profile not found"); return; }
        writeJsonBody(res, readinessProfileToJson(*item));
    }

    private void create(HTTPServerRequest req, HTTPServerResponse res) {
        auto j = req.json;
        ReadinessProfileDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", jsonStr(j, "tenantId"));
        dto.contingentId = jsonStr(j, "contingentId");
        dto.missionPlanId = jsonStr(j, "missionPlanId");
        dto.personnelReadyPercent = jsonStr(j, "personnelReadyPercent");
        dto.equipmentReadyPercent = jsonStr(j, "equipmentReadyPercent");
        dto.supplyReadyPercent = jsonStr(j, "supplyReadyPercent");
        dto.maintenanceOpenCount = jsonStr(j, "maintenanceOpenCount");
        dto.mobilityState = jsonStr(j, "mobilityState");
        dto.communicationState = jsonStr(j, "communicationState");
        dto.status = jsonStr(j, "status");
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
        ReadinessProfileDTO dto;
        dto.id = id;
        dto.personnelReadyPercent = jsonStr(j, "personnelReadyPercent");
        dto.equipmentReadyPercent = jsonStr(j, "equipmentReadyPercent");
        dto.supplyReadyPercent = jsonStr(j, "supplyReadyPercent");
        dto.maintenanceOpenCount = jsonStr(j, "maintenanceOpenCount");
        dto.mobilityState = jsonStr(j, "mobilityState");
        dto.communicationState = jsonStr(j, "communicationState");
        dto.status = jsonStr(j, "status");
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