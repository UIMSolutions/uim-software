/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.presentation.http.controllers.incidents;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class IncidentController : SAPController {
    private ManageIncidentsUseCase uc;

    this(ManageIncidentsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/siem/incidents", &handleList);
        router.get("/api/v1/siem/incidents/*", &handleGet);
        router.post("/api/v1/siem/incidents", &handleCreate);
        router.put("/api/v1/siem/incidents/*", &handleUpdate);
        router.delete_("/api/v1/siem/incidents/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref i; items) jarr ~= incidentToJson(i);
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
            auto i = uc.get_(id);
            if (i is null) { writeError(res, 404, "Incident not found"); return; }
            res.writeJsonBody(incidentToJson(*i), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            IncidentDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.severity = jsonStr(j, "severity");
            dto.alertIds = jsonStr(j, "alertIds");
            dto.affectedAssetIds = jsonStr(j, "affectedAssetIds");
            dto.leadAnalyst = jsonStr(j, "leadAnalyst");
            dto.respondents = jsonStr(j, "respondents");
            dto.attackVector = jsonStr(j, "attackVector");
            dto.mitreTactics = jsonStr(j, "mitreTactics");
            dto.mitreTechniques = jsonStr(j, "mitreTechniques");
            dto.detectedAt = jsonStr(j, "detectedAt");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Incident created");
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
            IncidentDTO dto;
            dto.id = extractIdFromPath(path);
            dto.status = jsonStr(j, "status");
            dto.severity = jsonStr(j, "severity");
            dto.leadAnalyst = jsonStr(j, "leadAnalyst");
            dto.containmentActions = jsonStr(j, "containmentActions");
            dto.eradicationActions = jsonStr(j, "eradicationActions");
            dto.recoveryActions = jsonStr(j, "recoveryActions");
            dto.lessonsLearned = jsonStr(j, "lessonsLearned");
            dto.containedAt = jsonStr(j, "containedAt");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Incident updated");
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
                resp["message"] = Json("Incident deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
