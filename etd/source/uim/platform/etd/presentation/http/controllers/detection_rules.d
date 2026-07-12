module uim.platform.etd.presentation.http.controllers.detection_rules;

import std.conv : to;
import uim.platform.etd;

@safe:

class DetectionRuleController : SAPController {
    private ManageDetectionRulesUseCase useCase;

    this(ManageDetectionRulesUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/etd/detection-rules", &handleList);
        router.get("/api/v1/etd/detection-rules/*", &handleGet);
        router.post("/api/v1/etd/detection-rules", &handleCreate);
        router.put("/api/v1/etd/detection-rules/*", &handleUpdate);
        router.delete_("/api/v1/etd/detection-rules/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= detectionRuleToJson(item);
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
            writeError(res, 404, "Detection rule not found");
            return;
        }

        res.writeJsonBody(detectionRuleToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;

        DetectionRuleDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.queryPattern = jsonStr(j, "queryPattern");
        dto.severity = jsonStr(j, "severity");
        dto.schedule = jsonStr(j, "schedule");
        dto.status = jsonStr(j, "status");
        dto.mitreTactic = jsonStr(j, "mitreTactic");
        dto.mitreTechnique = jsonStr(j, "mitreTechnique");
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

        DetectionRuleDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.queryPattern = jsonStr(j, "queryPattern");
        dto.severity = jsonStr(j, "severity");
        dto.schedule = jsonStr(j, "schedule");
        dto.status = jsonStr(j, "status");
        dto.mitreTactic = jsonStr(j, "mitreTactic");
        dto.mitreTechnique = jsonStr(j, "mitreTechnique");
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
        payload["message"] = Json("Detection rule deleted");
        res.writeJsonBody(payload, 200);
    }
}
