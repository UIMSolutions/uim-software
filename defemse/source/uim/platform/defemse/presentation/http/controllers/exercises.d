module uim.platform.defemse.presentation.http.controllers.exercises;

import std.conv : to;
import vibe.data.json : Json;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerRequest, HTTPServerResponse, HTTPStatus;
import uim.platform.defemse;

@safe:

class ExerciseController : SAPController {
    private ManageExercisesUseCase useCase;

    this(ManageExercisesUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/defemse/exercises", &listAll);
        router.get("/api/v1/defemse/exercises/*", &getOne);
        router.post("/api/v1/defemse/exercises", &create);
        router.put("/api/v1/defemse/exercises/*", &update);
        router.delete_("/api/v1/defemse/exercises/*", &remove);
    }

    private void listAll(HTTPServerRequest req, HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= exerciseToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void getOne(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Exercise not found"); return; }
        writeJsonBody(res, exerciseToJson(*item));
    }

    private void create(HTTPServerRequest req, HTTPServerResponse res) {
        auto j = req.json;
        ExerciseDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", jsonStr(j, "tenantId"));
        dto.reference = jsonStr(j, "reference");
        dto.name = jsonStr(j, "name");
        dto.exerciseType = jsonStr(j, "exerciseType");
        dto.exerciseScope = jsonStr(j, "exerciseScope");
        dto.status = jsonStr(j, "status");
        dto.missionPlanId = jsonStr(j, "missionPlanId");
        dto.plannedStart = jsonStr(j, "plannedStart");
        dto.plannedEnd = jsonStr(j, "plannedEnd");
        dto.contingencyLevel = jsonStr(j, "contingencyLevel");
        dto.relocationRequired = jsonStr(j, "relocationRequired");
        dto.locationId = jsonStr(j, "locationId");
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
        ExerciseDTO dto;
        dto.id = id;
        dto.name = jsonStr(j, "name");
        dto.exerciseType = jsonStr(j, "exerciseType");
        dto.exerciseScope = jsonStr(j, "exerciseScope");
        dto.status = jsonStr(j, "status");
        dto.missionPlanId = jsonStr(j, "missionPlanId");
        dto.plannedStart = jsonStr(j, "plannedStart");
        dto.plannedEnd = jsonStr(j, "plannedEnd");
        dto.contingencyLevel = jsonStr(j, "contingencyLevel");
        dto.relocationRequired = jsonStr(j, "relocationRequired");
        dto.locationId = jsonStr(j, "locationId");
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