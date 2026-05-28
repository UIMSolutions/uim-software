/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.presentation.http.controllers.business_context;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class BusinessContextController : SAPController {
    private ManageBusinessContextsUseCase uc;

    this(ManageBusinessContextsUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/lean/business-contexts", &handleList);
        router.get("/api/v1/lean/business-contexts/*", &handleGet);
        router.post("/api/v1/lean/business-contexts", &handleCreate);
        router.put("/api/v1/lean/business-contexts/*", &handleUpdate);
        router.delete_("/api/v1/lean/business-contexts/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref bc; items) jarr ~= businessContextToJson(bc);
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
            auto bc = uc.get_(id);
            if (bc is null) { writeError(res, 404, "Business context not found"); return; }
            res.writeJsonBody(businessContextToJson(*bc), 200);
        } catch (Exception e) { writeError(res, 500, "Internal server error"); }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            BusinessContextDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.capabilityId = jsonStr(j, "capabilityId");
            dto.owningOrgId = jsonStr(j, "owningOrgId");
            dto.processOwner = jsonStr(j, "processOwner");
            dto.frequency = jsonStr(j, "frequency");
            dto.createdBy = jsonStr(j, "createdBy");
            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("BusinessContext created");
                res.writeJsonBody(resp, 201);
            } else { writeError(res, 400, result.error); }
        } catch (Exception e) { writeError(res, 500, "Internal server error"); }
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto j = req.json;
            BusinessContextDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.processOwner = jsonStr(j, "processOwner");
            dto.modifiedBy = jsonStr(j, "modifiedBy");
            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("BusinessContext updated");
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
                resp["message"] = Json("BusinessContext deleted");
                res.writeJsonBody(resp, 200);
            } else { writeError(res, 404, result.error); }
        } catch (Exception e) { writeError(res, 500, "Internal server error"); }
    }
}
