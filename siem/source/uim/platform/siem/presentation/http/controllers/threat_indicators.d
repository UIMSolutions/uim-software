/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.presentation.http.controllers.threat_indicators;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class ThreatIndicatorController : SAPController {
    private ManageThreatIndicatorsUseCase uc;

    this(ManageThreatIndicatorsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/siem/threat-indicators", &handleList);
        router.get("/api/v1/siem/threat-indicators/*", &handleGet);
        router.post("/api/v1/siem/threat-indicators", &handleCreate);
        router.put("/api/v1/siem/threat-indicators/*", &handleUpdate);
        router.delete_("/api/v1/siem/threat-indicators/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref t; items) jarr ~= threatIndicatorToJson(t);
            auto resp = Json.emptyObject;
            resp["count"] = Json(cast(long) items.length);
            resp["resources"] = jarr;
            res.writeJsonBody(resp, 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto path = req.requestURI.to!string;
            auto id = extractIdFromPath(path);
            auto t = uc.get_(id);
            if (t is null) { writeError(res, 404, "Threat indicator not found"); return; }
            res.writeJsonBody(threatIndicatorToJson(*t), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ThreatIndicatorDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.indicatorType = jsonStr(j, "indicatorType");
            dto.confidence = jsonStr(j, "confidence");
            dto.value = jsonStr(j, "value");
            dto.threatActor = jsonStr(j, "threatActor");
            dto.malwareFamily = jsonStr(j, "malwareFamily");
            dto.campaign = jsonStr(j, "campaign");
            dto.tlpLevel = jsonStr(j, "tlpLevel");
            dto.source = jsonStr(j, "source");
            dto.tags = jsonStr(j, "tags");
            dto.expiresAt = jsonStr(j, "expiresAt");
            dto.firstSeenAt = jsonStr(j, "firstSeenAt");
            dto.lastSeenAt = jsonStr(j, "lastSeenAt");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Threat indicator created");
                res.writeJsonBody(resp, 201);
            } else {
                writeError(res, 400, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto path = req.requestURI.to!string;
            auto j = req.json;
            ThreatIndicatorDTO dto;
            dto.id = extractIdFromPath(path);
            dto.value = jsonStr(j, "value");
            dto.threatActor = jsonStr(j, "threatActor");
            dto.malwareFamily = jsonStr(j, "malwareFamily");
            dto.lastSeenAt = jsonStr(j, "lastSeenAt");
            dto.expiresAt = jsonStr(j, "expiresAt");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Threat indicator updated");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto path = req.requestURI.to!string;
            auto id = extractIdFromPath(path);
            auto result = uc.remove(id);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["message"] = Json("Threat indicator deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
