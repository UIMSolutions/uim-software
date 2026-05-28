/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.presentation.http.controllers.improvement_controller;

import uim.platform.itil;
import vibe.http.server;
import vibe.http.router;
import vibe.data.json;
import std.conv : to;

mixin(ShowModule!());

@safe:

class ImprovementController : SAPController {
    private ManageImprovementItemsUseCase useCase;

    this(ManageImprovementItemsUseCase useCase) { this.useCase = useCase; }

    void registerRoutes(URLRouter router) {
        router.get("/api/v1/itil/improvements",    &listAll);
        router.post("/api/v1/itil/improvements",   &create);
        router.get("/api/v1/itil/improvements/*",  &getOne);
        router.put("/api/v1/itil/improvements/*",  &update);
        router.delete_("/api/v1/itil/improvements/*", &remove);
    }

    private void listAll(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (i; items) arr ~= improvementItemToJson(i);
        writeJsonBody(res, arr);
    }

    private void getOne(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Improvement item not found"); return; }
        writeJsonBody(res, improvementItemToJson(*item));
    }

    private void create(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto j = req.json;
        ImprovementItemDTO dto;
        dto.id              = jsonStr(j, "id");
        dto.tenantId        = jsonStr(j, "tenantId");
        dto.title           = jsonStr(j, "title");
        dto.description     = jsonStr(j, "description");
        dto.category        = jsonStr(j, "category");
        dto.proposedBy      = jsonStr(j, "proposedBy");
        dto.owner           = jsonStr(j, "owner");
        dto.targetDate      = jsonStr(j, "targetDate");
        dto.expectedBenefit = jsonStr(j, "expectedBenefit");
        dto.relatedServiceId = jsonStr(j, "relatedServiceId");
        dto.createdBy       = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int)HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void update(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto j = req.json;
        ImprovementItemDTO dto;
        dto.id              = id;
        dto.title           = jsonStr(j, "title");
        dto.description     = jsonStr(j, "description");
        dto.expectedBenefit = jsonStr(j, "expectedBenefit");
        dto.modifiedBy      = jsonStr(j, "modifiedBy");
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
