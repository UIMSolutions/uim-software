/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.presentation.http.controllers.tracking_model;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class TrackingModelController : SAPController {
    private ManageTrackingModelsUseCase uc;

    this(ManageTrackingModelsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/gtt/tracking-models", &handleList);
        router.get("/api/v1/gtt/tracking-models/*", &handleGet);
        router.post("/api/v1/gtt/tracking-models", &handleCreate);
        router.put("/api/v1/gtt/tracking-models/*", &handleUpdate);
        router.delete_("/api/v1/gtt/tracking-models/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref e; items) jarr ~= trackingModelToJson(e);
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
            if (e is null) { writeError(res, 404, "Tracking model not found"); return; }
            res.writeJsonBody(trackingModelToJson(*e), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            TrackingModelDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.trackedObjectType = jsonStr(j, "trackedObjectType");
            dto.expectedEvents = jsonStr(j, "expectedEvents");
            dto.milestones = jsonStr(j, "milestones");
            dto.correlationRules = jsonStr(j, "correlationRules");
            dto.exceptionRules = jsonStr(j, "exceptionRules");
            dto.version_ = jsonStr(j, "version");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Tracking model created");
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
            TrackingModelDTO dto;
            dto.id = extractIdFromPath(path);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.expectedEvents = jsonStr(j, "expectedEvents");
            dto.milestones = jsonStr(j, "milestones");
            dto.correlationRules = jsonStr(j, "correlationRules");
            dto.exceptionRules = jsonStr(j, "exceptionRules");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Tracking model updated");
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
                resp["message"] = Json("Tracking model deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
