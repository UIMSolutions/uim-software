/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.presentation.http.controllers.lean_application;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class LeanApplicationController : SAPController {
    private ManageLeanApplicationsUseCase uc;

    this(ManageLeanApplicationsUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/lean/applications", &handleList);
        router.get("/api/v1/lean/applications/*", &handleGet);
        router.post("/api/v1/lean/applications", &handleCreate);
        router.put("/api/v1/lean/applications/*", &handleUpdate);
        router.delete_("/api/v1/lean/applications/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref a; items) jarr ~= leanApplicationToJson(a);
            auto resp = Json.emptyObject;
            resp["count"] = Json(cast(long) items.length);
            resp["resources"] = jarr;
            res.writeJsonBody(resp, 200);
        } catch (Exception e) { writeError(res, 500, "Internal server error"); }
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto id = extractIdFromPath(req.requestURI.to!string);
            auto a = uc.get_(id);
            if (a is null) { writeError(res, 404, "Application not found"); return; }
            res.writeJsonBody(leanApplicationToJson(*a), 200);
        } catch (Exception e) { writeError(res, 500, "Internal server error"); }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            LeanApplicationDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.applicationType = jsonStr(j, "applicationType");
            dto.lifecycleStatus = jsonStr(j, "lifecycleStatus");
            dto.functionalFit = jsonStr(j, "functionalFit");
            dto.technicalFit = jsonStr(j, "technicalFit");
            dto.owningOrgId = jsonStr(j, "owningOrgId");
            dto.itOwner = jsonStr(j, "itOwner");
            dto.businessOwner = jsonStr(j, "businessOwner");
            dto.vendor = jsonStr(j, "vendor");
            dto.version_ = jsonStr(j, "version");
            dto.annualCostUsd = jsonStr(j, "annualCostUsd");
            dto.createdBy = jsonStr(j, "createdBy");
            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Application created");
                res.writeJsonBody(resp, 201);
            } else { writeError(res, 400, result.error); }
        } catch (Exception e) { writeError(res, 500, "Internal server error"); }
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto j = req.json;
            LeanApplicationDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.lifecycleStatus = jsonStr(j, "lifecycleStatus");
            dto.functionalFit = jsonStr(j, "functionalFit");
            dto.technicalFit = jsonStr(j, "technicalFit");
            dto.modifiedBy = jsonStr(j, "modifiedBy");
            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Application updated");
                res.writeJsonBody(resp, 200);
            } else { writeError(res, 404, result.error); }
        } catch (Exception e) { writeError(res, 500, "Internal server error"); }
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto id = extractIdFromPath(req.requestURI.to!string);
            auto result = uc.remove(id);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["message"] = Json("Application deleted");
                res.writeJsonBody(resp, 200);
            } else { writeError(res, 404, result.error); }
        } catch (Exception e) { writeError(res, 500, "Internal server error"); }
    }
}
