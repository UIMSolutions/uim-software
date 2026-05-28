/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.presentation.http.controllers.correlation_rules;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class CorrelationRuleController : SAPController {
    private ManageCorrelationRulesUseCase uc;

    this(ManageCorrelationRulesUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/siem/correlation-rules", &handleList);
        router.get("/api/v1/siem/correlation-rules/*", &handleGet);
        router.post("/api/v1/siem/correlation-rules", &handleCreate);
        router.put("/api/v1/siem/correlation-rules/*", &handleUpdate);
        router.delete_("/api/v1/siem/correlation-rules/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref r; items) jarr ~= correlationRuleToJson(r);
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
            auto r = uc.get_(id);
            if (r is null) { writeError(res, 404, "Correlation rule not found"); return; }
            res.writeJsonBody(correlationRuleToJson(*r), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            CorrelationRuleDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.ruleType = jsonStr(j, "ruleType");
            dto.status = jsonStr(j, "status");
            dto.ruleExpression = jsonStr(j, "ruleExpression");
            dto.conditionField = jsonStr(j, "conditionField");
            dto.conditionOperator = jsonStr(j, "conditionOperator");
            dto.conditionValue = jsonStr(j, "conditionValue");
            dto.timeWindowSeconds = jsonStr(j, "timeWindowSeconds");
            dto.threshold = jsonStr(j, "threshold");
            dto.aggregationField = jsonStr(j, "aggregationField");
            dto.severity = jsonStr(j, "severity");
            dto.alertName = jsonStr(j, "alertName");
            dto.mitreTactic = jsonStr(j, "mitreTactic");
            dto.mitreTechnique = jsonStr(j, "mitreTechnique");
            dto.author = jsonStr(j, "author");
            dto.version_ = jsonStr(j, "version");
            dto.tags = jsonStr(j, "tags");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Correlation rule created");
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
            CorrelationRuleDTO dto;
            dto.id = extractIdFromPath(path);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.ruleExpression = jsonStr(j, "ruleExpression");
            dto.status = jsonStr(j, "status");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Correlation rule updated");
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
                resp["message"] = Json("Correlation rule deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
