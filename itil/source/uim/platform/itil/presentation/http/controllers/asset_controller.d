/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.presentation.http.controllers.asset_controller;

import uim.platform.itil;
import vibe.http.server;
import vibe.http.router;
import vibe.data.json;
import std.conv : to;

mixin(ShowModule!());

@safe:

class AssetController : SAPController {
    private ManageITAssetsUseCase useCase;

    this(ManageITAssetsUseCase useCase) { this.useCase = useCase; }

    void registerRoutes(URLRouter router) {
        router.get("/api/v1/itil/assets",    &listAll);
        router.post("/api/v1/itil/assets",   &create);
        router.get("/api/v1/itil/assets/*",  &getOne);
        router.put("/api/v1/itil/assets/*",  &update);
        router.delete_("/api/v1/itil/assets/*", &remove);
    }

    private void listAll(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (a; items) arr ~= itAssetToJson(a);
        writeJsonBody(res, arr);
    }

    private void getOne(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "IT asset not found"); return; }
        writeJsonBody(res, itAssetToJson(*item));
    }

    private void create(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto j = req.json;
        ITAssetDTO dto;
        dto.id            = jsonStr(j, "id");
        dto.tenantId      = jsonStr(j, "tenantId");
        dto.name          = jsonStr(j, "name");
        dto.description   = jsonStr(j, "description");
        dto.serialNumber  = jsonStr(j, "serialNumber");
        dto.manufacturer  = jsonStr(j, "manufacturer");
        dto.model         = jsonStr(j, "model");
        dto.purchaseDate  = jsonStr(j, "purchaseDate");
        dto.warrantyExpiry = jsonStr(j, "warrantyExpiry");
        dto.annualCostUsd = jsonStr(j, "annualCostUsd");
        dto.location      = jsonStr(j, "location");
        dto.assignedTo    = jsonStr(j, "assignedTo");
        dto.linkedCIId    = jsonStr(j, "linkedCIId");
        dto.createdBy     = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int)HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void update(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto j = req.json;
        ITAssetDTO dto;
        dto.id          = id;
        dto.name        = jsonStr(j, "name");
        dto.location    = jsonStr(j, "location");
        dto.assignedTo  = jsonStr(j, "assignedTo");
        dto.modifiedBy  = jsonStr(j, "modifiedBy");
        auto result = useCase.update(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void remove(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) { writeError(res, 404, result.error); return; }
        res.statusCode = cast(int)HTTPStatus.noContent;
        res.writeBody("");
    }
}
