module uim.platform.etd.presentation.http.controllers.incidents;

import std.conv : to;
import uim.platform.etd;

@safe:

class IncidentController : SAPController {
    private ManageIncidentsUseCase useCase;

    this(ManageIncidentsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/etd/incidents", &handleList);
        router.get("/api/v1/etd/incidents/*", &handleGet);
        router.post("/api/v1/etd/incidents", &handleCreate);
        router.put("/api/v1/etd/incidents/*", &handleUpdate);
        router.delete_("/api/v1/etd/incidents/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= incidentToJson(item);
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
            writeError(res, 404, "Incident not found");
            return;
        }

        res.writeJsonBody(incidentToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;

        IncidentDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.severity = jsonStr(j, "severity");
        dto.status = jsonStr(j, "status");
        dto.category = jsonStr(j, "category");
        dto.sourceSystem = jsonStr(j, "sourceSystem");
        dto.detectedAt = jsonStr(j, "detectedAt");
        dto.assignedTo = jsonStr(j, "assignedTo");
        dto.containmentStatus = jsonStr(j, "containmentStatus");
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

        IncidentDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.title = jsonStr(j, "title");
        dto.description = jsonStr(j, "description");
        dto.severity = jsonStr(j, "severity");
        dto.status = jsonStr(j, "status");
        dto.category = jsonStr(j, "category");
        dto.sourceSystem = jsonStr(j, "sourceSystem");
        dto.detectedAt = jsonStr(j, "detectedAt");
        dto.assignedTo = jsonStr(j, "assignedTo");
        dto.containmentStatus = jsonStr(j, "containmentStatus");
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
        payload["message"] = Json("Incident deleted");
        res.writeJsonBody(payload, 200);
    }
}
