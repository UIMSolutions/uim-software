module uim.platform.ead.application.usecases.query.query_ead_assets;

import std.string : indexOf, toLower;
import vibe.data.json : Json;
import uim.platform.ead.application.dto : DiagramRenderRequestDTO;
import uim.platform.ead.application.ports.diagram_runtime : DiagramRuntime;
import uim.platform.ead.domain.entities.ead_object : EadObject, EadBusinessObjectType;
import uim.platform.ead.domain.repositories.ead_repository : EadRepository;

@safe:

class QueryEadAssetsUseCase {
    private EadRepository repository;
    private DiagramRuntime diagramRuntime;

    this(EadRepository repository, DiagramRuntime diagramRuntime) {
        this.repository = repository;
        this.diagramRuntime = diagramRuntime;
    }

    EadObject[] search(string query) {
        EadObject[] pool;
        foreach (candidateType; [
            EadBusinessObjectType.businessCapabilities,
            EadBusinessObjectType.businessProcesses,
            EadBusinessObjectType.applicationComponents,
            EadBusinessObjectType.applicationServices,
            EadBusinessObjectType.interfaces,
            EadBusinessObjectType.apiDefinitions,
            EadBusinessObjectType.technologyComponents,
            EadBusinessObjectType.dependencies,
            EadBusinessObjectType.viewpoints,
            EadBusinessObjectType.diagrams
        ]) {
            pool ~= repository.listByType(candidateType);
        }

        auto q = query.toLower();
        EadObject[] result;
        foreach (item; pool) {
            if (item.technicalName.toLower().indexOf(q) >= 0 ||
                item.businessName.toLower().indexOf(q) >= 0 ||
                item.description.toLower().indexOf(q) >= 0) {
                result ~= item;
            }
        }

        return result;
    }

    EadObject[] listDependenciesBySource(string sourceId) {
        return repository.listBySource(EadBusinessObjectType.dependencies, sourceId);
    }

    EadObject[] listImpactsByTarget(string targetId) {
        return repository.listByTarget(EadBusinessObjectType.dependencies, targetId);
    }

    EadObject[] listViewpointsByLayer(string layer) {
        EadObject[] all = repository.listByType(EadBusinessObjectType.viewpoints);
        EadObject[] filtered;
        foreach (item; all) {
            if (item.architectureLayer == layer) {
                filtered ~= item;
            }
        }
        return filtered;
    }

    Json renderDiagram(DiagramRenderRequestDTO request) {
        return diagramRuntime.render(request);
    }
}

unittest {
    import uim.platform.ead.application.dto : EadObjectDTO;
    import uim.platform.ead.application.usecases.manage.manage_ead_objects : ManageEadObjectsUseCase;
    import uim.platform.ead.infrastructure.persistence.memory.ead_repository : MemoryEadRepository;
    import uim.platform.ead.infrastructure.runtime.simulated : SimulatedDiagramRuntime;

    auto repo = new MemoryEadRepository();
    auto manage = new ManageEadObjectsUseCase(repo);
    auto query = new QueryEadAssetsUseCase(repo, new SimulatedDiagramRuntime());

    EadObjectDTO source;
    source.objectType = EadBusinessObjectType.applicationComponents;
    source.technicalName = "APP_S4";
    auto sourceResult = manage.create(source);
    assert(sourceResult.success);

    EadObjectDTO target;
    target.objectType = EadBusinessObjectType.applicationComponents;
    target.technicalName = "APP_DWH";
    auto targetResult = manage.create(target);
    assert(targetResult.success);

    EadObjectDTO dep;
    dep.objectType = EadBusinessObjectType.dependencies;
    dep.technicalName = "IFLOW_001";
    dep.sourceId = sourceResult.id;
    dep.targetId = targetResult.id;
    auto depResult = manage.create(dep);
    assert(depResult.success);

    auto bySource = query.listDependenciesBySource(sourceResult.id);
    assert(bySource.length == 1);

    auto byTarget = query.listImpactsByTarget(targetResult.id);
    assert(byTarget.length == 1);

    auto searched = query.search("app");
    assert(searched.length >= 2);

    DiagramRenderRequestDTO render;
    render.diagramId = "D-1";
    auto rendered = query.renderDiagram(render);
    assert(("meta" in rendered) !is null);
}
