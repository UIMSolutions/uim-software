/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.presentation.http.controllers.alerts;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class AlertController : SAPController {
    private ManageAlertsUseCase uc;

    this(ManageAlertsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/siem/alerts", &handleList);
        router.get("/api/v1/siem/alerts/*", &handleGet);
        router.post("/api/v1/siem/alerts", &handleCreate);
        router.put("/api/v1/siem/alerts/*", &handleUpdate);
        router.delete_("/api/v1/siem/alerts/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref a; items) jarr ~= alertToJson(a);
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
            auto a = uc.get_(id);
            if (a is null) { writeError(res, 404, "Alert not found"); return; }
            res.writeJsonBody(alertToJson(*a), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            AlertDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.severity = jsonStr(j, "severity");
            dto.correlationRuleId = jsonStr(j, "correlationRuleId");
            dto.ruleName = jsonStr(j, "ruleName");
            dto.sourceEventIds = jsonStr(j, "sourceEventIds");
            dto.affectedAssetId = jsonStr(j, "affectedAssetId");
            dto.sourceIp = jsonStr(j, "sourceIp");
            dto.destinationIp = jsonStr(j, "destinationIp");
            dto.username = jsonStr(j, "username");
            dto.mitreTactic = jsonStr(j, "mitreTactic");
            dto.mitreTechnique = jsonStr(j, "mitreTechnique");
            dto.firstSeenAt = jsonStr(j, "firstSeenAt");
            dto.lastSeenAt = jsonStr(j, "lastSeenAt");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Alert created");
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
            AlertDTO dto;
            dto.id = extractIdFromPath(path);
            dto.status = jsonStr(j, "status");
            dto.assignedTo = jsonStr(j, "assignedTo");
            dto.resolvedBy = jsonStr(j, "resolvedBy");
            dto.resolutionNote = jsonStr(j, "resolutionNote");
            dto.lastSeenAt = jsonStr(j, "lastSeenAt");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Alert updated");
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
                resp["message"] = Json("Alert deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
