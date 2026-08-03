module uim.platform.npc.application.usecases.query.query_npc_plans;

import std.string : indexOf, toLower;
import vibe.data.json : Json;
import uim.platform.npc.application.dto : SimulationDTO;
import uim.platform.npc.domain.entities.npc_object : NpcObject, NpcBusinessObjectType;
import uim.platform.npc.domain.repositories.npc_repository : NpcRepository;

@safe:

class QueryNpcPlansUseCase {
    private NpcRepository repository;

    this(NpcRepository repository) {
        this.repository = repository;
    }

    NpcObject[] search(string query) {
        NpcObject[] pool;
        foreach (candidateType; [
            NpcBusinessObjectType.demandPlans,
            NpcBusinessObjectType.supplyPlans,
            NpcBusinessObjectType.constrainedPlans,
            NpcBusinessObjectType.scenarios,
            NpcBusinessObjectType.apiDefinitions
        ]) {
            pool ~= repository.listByType(candidateType);
        }

        auto q = query.toLower();
        NpcObject[] result;
        foreach (item; pool) {
            if (item.technicalName.toLower().indexOf(q) >= 0 ||
                item.businessName.toLower().indexOf(q) >= 0 ||
                item.description.toLower().indexOf(q) >= 0) {
                result ~= item;
            }
        }

        return result;
    }

    NpcObject[] listCapacitiesByResource(string resourceId) {
        return repository.listByParent(NpcBusinessObjectType.capacities, resourceId);
    }

    NpcObject[] listAllocationsByDemand(string demandId) {
        return repository.listByParent(NpcBusinessObjectType.allocations, demandId);
    }

    Json runSimulation(SimulationDTO request) {
        auto payload = Json.emptyObject;
        payload["scenarioId"] = Json(request.scenarioId);
        payload["demandPlanId"] = Json(request.demandPlanId);
        payload["supplyPlanId"] = Json(request.supplyPlanId);
        payload["horizon"] = Json(request.horizon.length ? request.horizon : "P12W");

        auto parameters = Json.emptyObject;
        foreach (k, v; request.parameters) {
            parameters[k] = Json(v);
        }
        payload["parameters"] = parameters;

        auto summary = Json.emptyObject;
        summary["serviceLevel"] = Json("97.2");
        summary["lateOrders"] = Json("18");
        summary["capacityUtilization"] = Json("91.4");
        summary["status"] = Json("feasible");
        payload["summary"] = summary;

        auto recommendations = Json.emptyArray;
        recommendations ~= Json("Increase supplier lane CAP-LN-01 by 8 percent");
        recommendations ~= Json("Move 120 units from LOC-DE-HAM to LOC-DE-MUC");
        payload["recommendations"] = recommendations;

        auto meta = Json.emptyObject;
        meta["executionMode"] = Json("simulated");
        meta["message"] = Json("Replace with optimization engine adapter for production planning runs");
        payload["meta"] = meta;

        return payload;
    }
}

unittest {
    import uim.platform.npc.application.dto : NpcObjectDTO;
    import uim.platform.npc.application.usecases.manage.manage_npc_objects : ManageNpcObjectsUseCase;
    import uim.platform.npc.infrastructure.persistence.memory.npc_repository : MemoryNpcRepository;

    auto repo = new MemoryNpcRepository();
    auto manage = new ManageNpcObjectsUseCase(repo);
    auto query = new QueryNpcPlansUseCase(repo);

    NpcObjectDTO demand;
    demand.objectType = NpcBusinessObjectType.demandPlans;
    demand.technicalName = "DP_MAIN";
    auto demandResult = manage.create(demand);
    assert(demandResult.success);

    NpcObjectDTO allocation;
    allocation.objectType = NpcBusinessObjectType.allocations;
    allocation.technicalName = "AL_001";
    allocation.parentId = demandResult.id;
    auto allocationResult = manage.create(allocation);
    assert(allocationResult.success);

    auto linked = query.listAllocationsByDemand(demandResult.id);
    assert(linked.length == 1);

    auto searched = query.search("main");
    assert(searched.length >= 1);

    SimulationDTO simulation;
    simulation.scenarioId = "SC_1";
    auto output = query.runSimulation(simulation);
    assert(("summary" in output) !is null);
}
