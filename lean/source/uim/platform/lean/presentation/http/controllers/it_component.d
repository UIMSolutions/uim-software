/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.presentation.http.controllers.it_component;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class ITComponentController : SAPController {
    private ManageITComponentsUseCase uc;

    this(ManageITComponentsUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/lean/it-components", &handleList);
        router.get("/api/v1/lean/it-components/*", &handleGet);
        router.post("/api/v1/lean/it-components", &handleCreate);
        router.put("/api/v1/lean/it-components/*", &handleUpdate);
        router.delete_("/api/v1/lean/it-components/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref c; items) jarr ~= itComponentToJson(c);
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
            auto c = uc.get_(id);
            if (c is null) { writeError(res, 404, "IT component not found"); return; }
            res.writeJsonBody(itComponentToJson(*c), 200);
        } catch (Exception e) { writeError(res, 500, "Internal server error"); }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ITComponentDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.componentType = jsonStr(j, "componentType");
            dto.lifecycleStatus = jsonStr(j, "lifecycleStatus");
            dto.techCategoryId = jsonStr(j, "techCategoryId");
            dto.providerId = jsonStr(j, "providerId");
            dto.version_ = jsonStr(j, "version");
            dto.releaseDate = jsonStr(j, "releaseDate");
            dto.endOfLifeDate = jsonStr(j, "endOfLifeDate");
            dto.licenseModel = jsonStr(j, "licenseModel");
            dto.annualCostUsd = jsonStr(j, "annualCostUsd");
            dto.technicalRisk = jsonStr(j, "technicalRisk");
            dto.createdBy = jsonStr(j, "createdBy");
            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("IT component created");
                res.writeJsonBody(resp, 201);
            } else { writeError(res, 400, result.error); }
        } catch (Exception e) { writeError(res, 500, "Internal server error"); }
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            import std.conv : to;
            auto j = req.json;
            ITComponentDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.lifecycleStatus = jsonStr(j, "lifecycleStatus");
            dto.technicalRisk = jsonStr(j, "technicalRisk");
            dto.modifiedBy = jsonStr(j, "modifiedBy");
            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("IT component updated");
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
                resp["message"] = Json("IT component deleted");
                res.writeJsonBody(resp, 200);
            } else { writeError(res, 404, result.error); }
        } catch (Exception e) { writeError(res, 500, "Internal server error"); }
    }
}
