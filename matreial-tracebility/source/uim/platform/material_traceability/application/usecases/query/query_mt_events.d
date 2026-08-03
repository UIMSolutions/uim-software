module uim.platform.material_traceability.application.usecases.query.query_mt_events;

import std.string : indexOf, toLower;
import vibe.data.json : Json;
import uim.platform.material_traceability.application.dto : RecallSimulationDTO;
import uim.platform.material_traceability.domain.entities.mt_object : MtObject, MtBusinessObjectType;
import uim.platform.material_traceability.domain.repositories.mt_repository : MtRepository;

@safe:

class QueryMtEventsUseCase {
    private MtRepository repository;

    this(MtRepository repository) {
        this.repository = repository;
    }

    MtObject[] search(string query) {
        MtObject[] pool;
        foreach (candidateType; [
            MtBusinessObjectType.materials,
            MtBusinessObjectType.transportEvents,
            MtBusinessObjectType.transformationEvents,
            MtBusinessObjectType.consumptionEvents,
            MtBusinessObjectType.recallCases,
            MtBusinessObjectType.apiDefinitions
        ]) {
            pool ~= repository.listByType(candidateType);
        }

        auto q = query.toLower();
        MtObject[] result;
        foreach (item; pool) {
            if (item.technicalName.toLower().indexOf(q) >= 0 ||
                item.businessName.toLower().indexOf(q) >= 0 ||
                item.description.toLower().indexOf(q) >= 0) {
                result ~= item;
            }
        }

        return result;
    }

    MtObject[] listLineageByMaterial(string materialId) {
        return repository.listByParent(MtBusinessObjectType.lineageViews, materialId);
    }

    MtObject[] listComplianceByLot(string lotId) {
        return repository.listByParent(MtBusinessObjectType.complianceStatements, lotId);
    }

    Json runRecallSimulation(RecallSimulationDTO request) {
        auto payload = Json.emptyObject;
        payload["recallCaseId"] = Json(request.recallCaseId);
        payload["materialId"] = Json(request.materialId);
        payload["lotId"] = Json(request.lotId);
        payload["horizon"] = Json(request.horizon.length ? request.horizon : "P30D");

        auto parameters = Json.emptyObject;
        foreach (k, v; request.parameters) {
            parameters[k] = Json(v);
        }
        payload["parameters"] = parameters;

        auto summary = Json.emptyObject;
        summary["affectedLots"] = Json("12");
        summary["affectedPartners"] = Json("7");
        summary["riskLevel"] = Json("high");
        summary["status"] = Json("action-required");
        payload["summary"] = summary;

        auto recommendations = Json.emptyArray;
        recommendations ~= Json("Block outbound deliveries for affected lots");
        recommendations ~= Json("Notify tier-1 suppliers and regulatory contacts");
        payload["recommendations"] = recommendations;

        auto meta = Json.emptyObject;
        meta["executionMode"] = Json("simulated");
        meta["message"] = Json("Integrate external risk engines for production simulations");
        payload["meta"] = meta;

        return payload;
    }
}

unittest {
    import uim.platform.material_traceability.application.dto : MtObjectDTO;
    import uim.platform.material_traceability.application.usecases.manage.manage_mt_objects : ManageMtObjectsUseCase;
    import uim.platform.material_traceability.infrastructure.persistence.memory.mt_repository : MemoryMtRepository;

    auto repo = new MemoryMtRepository();
    auto manage = new ManageMtObjectsUseCase(repo);
    auto query = new QueryMtEventsUseCase(repo);

    MtObjectDTO material;
    material.objectType = MtBusinessObjectType.materials;
    material.technicalName = "MAT_A";
    auto materialResult = manage.create(material);
    assert(materialResult.success);

    MtObjectDTO lineage;
    lineage.objectType = MtBusinessObjectType.lineageViews;
    lineage.technicalName = "LINEAGE_A";
    lineage.parentId = materialResult.id;
    auto lineageResult = manage.create(lineage);
    assert(lineageResult.success);

    auto linked = query.listLineageByMaterial(materialResult.id);
    assert(linked.length == 1);

    auto searched = query.search("mat");
    assert(searched.length >= 1);

    RecallSimulationDTO sim;
    sim.materialId = materialResult.id;
    auto output = query.runRecallSimulation(sim);
    assert(("summary" in output) !is null);
}
