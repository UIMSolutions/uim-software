module uim.platform.etd.presentation.http.controllers.threat_indicators;

import std.conv : to;
import uim.platform.etd;

@safe:

class ThreatIndicatorController : SAPController {
    private ManageThreatIndicatorsUseCase useCase;

    this(ManageThreatIndicatorsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/etd/threat-indicators", &handleList);
        router.get("/api/v1/etd/threat-indicators/*", &handleGet);
        router.post("/api/v1/etd/threat-indicators", &handleCreate);
        router.put("/api/v1/etd/threat-indicators/*", &handleUpdate);
        router.delete_("/api/v1/etd/threat-indicators/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= threatIndicatorToJson(item);
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
            writeError(res, 404, "Threat indicator not found");
            return;
        }

        res.writeJsonBody(threatIndicatorToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;

        ThreatIndicatorDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.indicatorType = jsonStr(j, "indicatorType");
        dto.indicatorValue = jsonStr(j, "indicatorValue");
        dto.confidence = jsonStr(j, "confidence");
        dto.severity = jsonStr(j, "severity");
        dto.firstSeenAt = jsonStr(j, "firstSeenAt");
        dto.lastSeenAt = jsonStr(j, "lastSeenAt");
        dto.source = jsonStr(j, "source");
        dto.status = jsonStr(j, "status");
        dto.enrichment = jsonStr(j, "enrichment");
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

        ThreatIndicatorDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.indicatorType = jsonStr(j, "indicatorType");
        dto.indicatorValue = jsonStr(j, "indicatorValue");
        dto.confidence = jsonStr(j, "confidence");
        dto.severity = jsonStr(j, "severity");
        dto.firstSeenAt = jsonStr(j, "firstSeenAt");
        dto.lastSeenAt = jsonStr(j, "lastSeenAt");
        dto.source = jsonStr(j, "source");
        dto.status = jsonStr(j, "status");
        dto.enrichment = jsonStr(j, "enrichment");
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
        payload["message"] = Json("Threat indicator deleted");
        res.writeJsonBody(payload, 200);
    }
}
