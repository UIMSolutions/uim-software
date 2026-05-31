module uim.platform.ibp.presentation.http.controllers.specification;

import std.conv : to;
import uim.platform.ibp;

@safe:

class SpecificationController : SAPController {
    private ManageSpecificationsUseCase useCase;
    this(ManageSpecificationsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/ibp/scenario-simulations", &handleList);
        router.get("/api/v1/ibp/scenario-simulations/*", &handleGet);
        router.post("/api/v1/ibp/scenario-simulations", &handleCreate);
        router.put("/api/v1/ibp/scenario-simulations/*", &handleUpdate);
        router.delete_("/api/v1/ibp/scenario-simulations/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= specificationToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = useCase.get_(extractIdFromPath(req.requestPath.to!string));
        if (item is null) { writeError(res, 404, "Scenario simulation not found"); return; }
        writeJsonBody(res, specificationToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        SpecificationDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.demandPlanId = jsonStr(j, "demandPlanId");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.specificationType = jsonStr(j, "specificationType");
        dto.status = jsonStr(j, "status");
        dto.specificationNumber = jsonStr(j, "specificationNumber");
        dto.property = jsonStr(j, "property");
        dto.targetValue = jsonStr(j, "targetValue");
        dto.unit = jsonStr(j, "unit");
        dto.lowerLimit = jsonStr(j, "lowerLimit");
        dto.upperLimit = jsonStr(j, "upperLimit");
        dto.testMethod = jsonStr(j, "testMethod");
        dto.complianceStandard = jsonStr(j, "complianceStandard");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        SpecificationDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.specificationType = jsonStr(j, "specificationType");
        dto.status = jsonStr(j, "status");
        dto.specificationNumber = jsonStr(j, "specificationNumber");
        dto.property = jsonStr(j, "property");
        dto.targetValue = jsonStr(j, "targetValue");
        dto.unit = jsonStr(j, "unit");
        dto.lowerLimit = jsonStr(j, "lowerLimit");
        dto.upperLimit = jsonStr(j, "upperLimit");
        dto.testMethod = jsonStr(j, "testMethod");
        dto.complianceStandard = jsonStr(j, "complianceStandard");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        auto result = useCase.update(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto result = useCase.remove(extractIdFromPath(req.requestPath.to!string));
        if (!result.success) { writeError(res, 404, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.noContent;
        res.writeBody("");
    }
}
