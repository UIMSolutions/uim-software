module uim.platform.npc.presentation.http.controllers.plan_api;

import std.conv : to;
import uim.platform.npc;

@safe:

class PlanApiController : SAPController {
    private ManageNpcObjectsUseCase manageUseCase;
    private QueryNpcPlansUseCase queryUseCase;

    this(ManageNpcObjectsUseCase manageUseCase, QueryNpcPlansUseCase queryUseCase) {
        this.manageUseCase = manageUseCase;
        this.queryUseCase = queryUseCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/npc/search/plans", &handleSearchPlans);
        router.get("/api/v1/npc/capacities/by-resource/*", &handleListCapacitiesByResource);
        router.get("/api/v1/npc/allocations/by-demand/*", &handleListAllocationsByDemand);
        router.post("/api/v1/npc/simulations", &handleSimulation);
        router.get("/api/v1/npc/api-catalog", &handleApiCatalog);
    }

    private void handleSearchPlans(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto query = req.query.get("q", "");
        auto items = queryUseCase.search(query);
        writeCollection(res, items);
    }

    private void handleListCapacitiesByResource(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto resourceId = extractIdFromPath(req.requestPath.to!string);
        auto items = queryUseCase.listCapacitiesByResource(resourceId);
        writeCollection(res, items);
    }

    private void handleListAllocationsByDemand(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto demandId = extractIdFromPath(req.requestPath.to!string);
        auto items = queryUseCase.listAllocationsByDemand(demandId);
        writeCollection(res, items);
    }

    private void handleSimulation(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureWrite(req, res, "scenarios")) {
            return;
        }

        auto j = req.json;
        SimulationDTO simulation;
        simulation.scenarioId = npcJsonStr(j, "scenarioId");
        simulation.demandPlanId = npcJsonStr(j, "demandPlanId");
        simulation.supplyPlanId = npcJsonStr(j, "supplyPlanId");
        simulation.horizon = npcJsonStr(j, "horizon");
        simulation.parameters = npcJsonStringMap(j, "parameters");

        auto payload = queryUseCase.runSimulation(simulation);
        res.writeJsonBody(payload, 200);
    }

    private void handleApiCatalog(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        if (!AuthGuard.ensureRead(req, res)) {
            return;
        }

        auto apis = manageUseCase.list(NpcBusinessObjectType.apiDefinitions);
        writeCollection(res, apis);
    }

    private void writeCollection(scope HTTPServerResponse res, NpcObject[] items) {
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
