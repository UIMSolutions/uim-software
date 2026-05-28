/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.presentation.http.controllers.assets;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class AssetController : SAPController {
    private ManageAssetsUseCase uc;

    this(ManageAssetsUseCase uc) {
        this.uc = uc;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/siem/assets", &handleList);
        router.get("/api/v1/siem/assets/*", &handleGet);
        router.post("/api/v1/siem/assets", &handleCreate);
        router.put("/api/v1/siem/assets/*", &handleUpdate);
        router.delete_("/api/v1/siem/assets/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto items = uc.list();
            auto jarr = Json.emptyArray;
            foreach (ref a; items) jarr ~= assetToJson(a);
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
            if (a is null) { writeError(res, 404, "Asset not found"); return; }
            res.writeJsonBody(assetToJson(*a), 200);
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            AssetDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.assetType = jsonStr(j, "assetType");
            dto.criticality = jsonStr(j, "criticality");
            dto.ipAddress = jsonStr(j, "ipAddress");
            dto.macAddress = jsonStr(j, "macAddress");
            dto.hostname = jsonStr(j, "hostname");
            dto.operatingSystem = jsonStr(j, "operatingSystem");
            dto.osVersion = jsonStr(j, "osVersion");
            dto.owner = jsonStr(j, "owner");
            dto.department = jsonStr(j, "department");
            dto.location = jsonStr(j, "location");
            dto.tags = jsonStr(j, "tags");
            dto.firstRegisteredAt = jsonStr(j, "firstRegisteredAt");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Asset created");
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
            AssetDTO dto;
            dto.id = extractIdFromPath(path);
            dto.name = jsonStr(j, "name");
            dto.description = jsonStr(j, "description");
            dto.ipAddress = jsonStr(j, "ipAddress");
            dto.operatingSystem = jsonStr(j, "operatingSystem");
            dto.osVersion = jsonStr(j, "osVersion");
            dto.owner = jsonStr(j, "owner");
            dto.lastSeenAt = jsonStr(j, "lastSeenAt");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto resp = Json.emptyObject;
                resp["id"] = Json(result.id);
                resp["message"] = Json("Asset updated");
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
                resp["message"] = Json("Asset deleted");
                res.writeJsonBody(resp, 200);
            } else {
                writeError(res, 404, result.error);
            }
        } catch (Exception e) {
            writeError(res, 500, "Internal server error");
        }
    }
}
