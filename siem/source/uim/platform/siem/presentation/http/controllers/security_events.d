/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.presentation.http.controllers.security_events;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class SecurityEventController : SAPController {
    private ManageSecurityEventsUseCase uc;

    this(ManageSecurityEventsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/siem/security-events", &handleList);
        router.get("/api/v1/siem/security-events/*", &handleGet);
        router.post("/api/v1/siem/security-events", &handleCreate);
        router.put("/api/v1/siem/security-events/*", &handleUpdate);
        router.delete_("/api/v1/siem/security-events/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= securityEventToJson(e);
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
            auto e = uc.get_(id);
            if (e is null) { writeError(res, 404, "Security event not found"); return; }
            res.writeJsonBody(securityEventToJson(*e), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            SecurityEventDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.source = jsonStr(j, "source");
            dto.severity = jsonStr(j, "severity");
            dto.sourceIp = jsonStr(j, "sourceIp");
            dto.destinationIp = jsonStr(j, "destinationIp");
            dto.sourcePort = jsonStr(j, "sourcePort");
            dto.destinationPort = jsonStr(j, "destinationPort");
            dto.protocol = jsonStr(j, "protocol");
            dto.username = jsonStr(j, "username");
            dto.hostname = jsonStr(j, "hostname");
            dto.rawLog = jsonStr(j, "rawLog");
            dto.eventType = jsonStr(j, "eventType");
            dto.category = jsonStr(j, "category");
            dto.action = jsonStr(j, "action");
            dto.outcome = jsonStr(j, "outcome");
            dto.assetId = jsonStr(j, "assetId");
            dto.timestamp = jsonStr(j, "timestamp");
            dto.receivedAt = jsonStr(j, "receivedAt");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Security event created");
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
            SecurityEventDTO dto;
            dto.id = extractIdFromPath(path);
            dto.status = jsonStr(j, "status");
            dto.alertId = jsonStr(j, "alertId");
            dto.correlationRuleId = jsonStr(j, "correlationRuleId");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Security event updated");
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
                resp["message"] = Json("Security event deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
