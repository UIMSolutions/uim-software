module uim.platform.defemse.presentation.http.controllers.contingents;

import std.conv : to;
import vibe.data.json : Json;
import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerRequest, HTTPServerResponse, HTTPStatus;
import uim.platform.defemse;

@safe:

class ContingentController : SAPController {
    private ManageContingentsUseCase useCase;

    this(ManageContingentsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/defemse/contingents", &listAll);
        router.get("/api/v1/defemse/contingents/*", &getOne);
        router.post("/api/v1/defemse/contingents", &create);
        router.put("/api/v1/defemse/contingents/*", &update);
        router.delete_("/api/v1/defemse/contingents/*", &remove);
    }

    private void listAll(HTTPServerRequest req, HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= contingentToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void getOne(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Contingent not found"); return; }
        writeJsonBody(res, contingentToJson(*item));
    }

    private void create(HTTPServerRequest req, HTTPServerResponse res) {
        auto j = req.json;
        ContingentDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", jsonStr(j, "tenantId"));
        dto.code = jsonStr(j, "code");
        dto.name = jsonStr(j, "name");
        dto.unitType = jsonStr(j, "unitType");
        dto.personnelStrength = jsonStr(j, "personnelStrength");
        dto.equipmentCount = jsonStr(j, "equipmentCount");
        dto.status = jsonStr(j, "status");
        dto.readinessStatus = jsonStr(j, "readinessStatus");
        dto.currentLocationId = jsonStr(j, "currentLocationId");
        dto.destinationLocationId = jsonStr(j, "destinationLocationId");
        dto.transportMode = jsonStr(j, "transportMode");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int)HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void update(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto j = req.json;
        ContingentDTO dto;
        dto.id = id;
        dto.name = jsonStr(j, "name");
        dto.unitType = jsonStr(j, "unitType");
        dto.personnelStrength = jsonStr(j, "personnelStrength");
        dto.equipmentCount = jsonStr(j, "equipmentCount");
        dto.status = jsonStr(j, "status");
        dto.readinessStatus = jsonStr(j, "readinessStatus");
        dto.currentLocationId = jsonStr(j, "currentLocationId");
        dto.destinationLocationId = jsonStr(j, "destinationLocationId");
        dto.transportMode = jsonStr(j, "transportMode");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        auto result = useCase.update(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void remove(HTTPServerRequest req, HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) { writeError(res, 404, result.error); return; }
        res.statusCode = cast(int)HTTPStatus.noContent;
        res.writeBody("");
    }
}