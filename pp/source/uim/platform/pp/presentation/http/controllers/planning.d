module uim.platform.pp.presentation.http.controllers.planning;

import std.conv : to;
import uim.platform.pp;

@safe:

class PPPlanningController : SAPController {
    private ManagePPObjectsUseCase manageUseCase;
    private RunMRPUseCase runMRPUseCase;

    this(ManagePPObjectsUseCase manageUseCase, RunMRPUseCase runMRPUseCase) {
        this.manageUseCase = manageUseCase;
        this.runMRPUseCase = runMRPUseCase;
    }

    override void registerRoutes(URLRouter router) {
        router.post("/api/v1/pp/mrp-runs/execute", &handleRunMRP);
        router.get("/api/v1/pp/planned-orders/by-material/*", &handleByMaterial);
    }

    private void handleRunMRP(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;

        MRPExecutionDTO dto;
        dto.plantId = jsonStr(j, "plantId");
        dto.materialId = jsonStr(j, "materialId");
        dto.runMode = jsonStr(j, "runMode");
        dto.horizonDays = jsonStr(j, "horizonDays");
        dto.initiatedBy = jsonStr(j, "initiatedBy");

        auto result = runMRPUseCase.execute(dto);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["runId"] = Json(result.id);
        payload["status"] = Json("completed");
        res.writeJsonBody(payload, 201);
    }

    private void handleByMaterial(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto materialId = extractIdFromPath(req.requestPath.to!string);
        auto plannedOrders = manageUseCase.listByMaterial("planned-orders", materialId);

        auto arr = Json.emptyArray;
        foreach (po; plannedOrders) {
            arr ~= objectToJson(po);
        }

        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) plannedOrders.length);
        payload["resources"] = arr;
        res.writeJsonBody(payload, 200);
    }
}
