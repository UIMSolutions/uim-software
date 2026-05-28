/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.presentation.http.controllers.sla_controller;

import uim.platform.itil;
import vibe.http.server;
import vibe.http.router;
import vibe.data.json;
import std.conv : to;

mixin(ShowModule!());

@safe:

class SLAController : SAPController {
    private ManageSLAsUseCase useCase;

    this(ManageSLAsUseCase useCase) { this.useCase = useCase; }

    void registerRoutes(URLRouter router) {
        router.get("/api/v1/itil/slas",    &listAll);
        router.post("/api/v1/itil/slas",   &create);
        router.get("/api/v1/itil/slas/*",  &getOne);
        router.put("/api/v1/itil/slas/*",  &update);
        router.delete_("/api/v1/itil/slas/*", &remove);
    }

    private void listAll(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (s; items) arr ~= slaToJson(s);
        writeJsonBody(res, arr);
    }

    private void getOne(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "SLA not found"); return; }
        writeJsonBody(res, slaToJson(*item));
    }

    private void create(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto j = req.json;
        ServiceLevelAgreementDTO dto;
        dto.id                   = jsonStr(j, "id");
        dto.tenantId             = jsonStr(j, "tenantId");
        dto.name                 = jsonStr(j, "name");
        dto.description          = jsonStr(j, "description");
        dto.serviceId            = jsonStr(j, "serviceId");
        dto.customerId           = jsonStr(j, "customerId");
        dto.startDate            = jsonStr(j, "startDate");
        dto.endDate              = jsonStr(j, "endDate");
        dto.availabilityTarget   = jsonStr(j, "availabilityTarget");
        dto.mttrTarget           = jsonStr(j, "mttrTarget");
        dto.responseTimeTarget   = jsonStr(j, "responseTimeTarget");
        dto.resolutionTimeTarget = jsonStr(j, "resolutionTimeTarget");
        dto.accountManager       = jsonStr(j, "accountManager");
        dto.createdBy            = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int)HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void update(HTTPServerRequest req, HTTPServerResponse res) @safe {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto j = req.json;
        ServiceLevelAgreementDTO dto;
        dto.id                 = id;
        dto.name               = jsonStr(j, "name");
        dto.availabilityTarget = jsonStr(j, "availabilityTarget");
        dto.endDate            = jsonStr(j, "endDate");
        dto.modifiedBy         = jsonStr(j, "modifiedBy");
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
