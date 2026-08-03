module uim.platform.material_traceability.presentation.http.controllers.traceability_api;

import std.conv : to;
import uim.platform.material_traceability;

@safe:

class TraceabilityApiController : SAPController {
    private ManageMtObjectsUseCase manageUseCase;
    private QueryMtEventsUseCase queryUseCase;

    this(ManageMtObjectsUseCase manageUseCase, QueryMtEventsUseCase queryUseCase) {
        this.manageUseCase = manageUseCase;
        this.queryUseCase = queryUseCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/mt/search/events", &handleSearchEvents);
        router.get("/api/v1/mt/lineage/by-material/*", &handleListLineageByMaterial);
        router.get("/api/v1/mt/compliance/by-lot/*", &handleListComplianceByLot);
        router.post("/api/v1/mt/recall-simulations", &handleRecallSimulation);
        router.get("/api/v1/mt/api-catalog", &handleApiCatalog);
    }

    private void handleSearchEvents(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto query = req.query.get("q", "");
        auto items = queryUseCase.search(query);
        writeCollection(res, items);
    }

    private void handleListLineageByMaterial(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto materialId = extractIdFromPath(req.requestPath.to!string);
        auto items = queryUseCase.listLineageByMaterial(materialId);
        writeCollection(res, items);
    }

    private void handleListComplianceByLot(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto lotId = extractIdFromPath(req.requestPath.to!string);
        auto items = queryUseCase.listComplianceByLot(lotId);
        writeCollection(res, items);
    }

    private void handleRecallSimulation(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureWrite(req, res, "recall-cases")) {
            return;
        }

        auto j = req.json;
        RecallSimulationDTO recall;
        recall.recallCaseId = mtJsonStr(j, "recallCaseId");
        recall.materialId = mtJsonStr(j, "materialId");
        recall.lotId = mtJsonStr(j, "lotId");
        recall.horizon = mtJsonStr(j, "horizon");
        recall.parameters = mtJsonStringMap(j, "parameters");

        auto payload = queryUseCase.runRecallSimulation(recall);
        res.writeJsonBody(payload, 200);
    }

    private void handleApiCatalog(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto apis = manageUseCase.list(MtBusinessObjectType.apiDefinitions);
        writeCollection(res, apis);
    }

    private void writeCollection(scope HTTPServerResponse res, MtObject[] items) {
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= objectToJson(item);
        }

        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["resources"] = arr;
        res.writeJsonBody(payload, 200);
    }
}
