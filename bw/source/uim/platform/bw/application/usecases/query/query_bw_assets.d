module uim.platform.bw.application.usecases.query.query_bw_assets;

import std.string : indexOf, toLower;
import vibe.data.json : Json;
import uim.platform.bw.application.dto : QueryExecutionDTO;
import uim.platform.bw.application.ports.query_runtime : BwQueryRuntime;
import uim.platform.bw.domain.entities.bw_object : BwObject, BwBusinessObjectType;
import uim.platform.bw.domain.repositories.bw_repository : BwRepository;

@safe:

class QueryBwAssetsUseCase {
    private BwRepository repository;
    private BwQueryRuntime queryRuntime;

    this(BwRepository repository, BwQueryRuntime queryRuntime) {
        this.repository = repository;
        this.queryRuntime = queryRuntime;
    }

    BwObject[] search(string query) {
        BwObject[] pool;
        foreach (candidateType; [
            BwBusinessObjectType.infoObjects,
            BwBusinessObjectType.adsos,
            BwBusinessObjectType.compositeProviders,
            BwBusinessObjectType.queries,
            BwBusinessObjectType.dataFlows,
            BwBusinessObjectType.apiDefinitions
        ]) {
            pool ~= repository.listByType(candidateType);
        }

        auto q = query.toLower();
        BwObject[] result;
        foreach (item; pool) {
            if (item.technicalName.toLower().indexOf(q) >= 0 ||
                item.businessName.toLower().indexOf(q) >= 0 ||
                item.description.toLower().indexOf(q) >= 0) {
                result ~= item;
            }
        }

        return result;
    }

    BwObject[] listDataFlowsBySource(string sourceId) {
        return repository.listByParent(BwBusinessObjectType.dataFlows, sourceId);
    }

    BwObject[] listQueriesByProvider(string providerId) {
        return repository.listByParent(BwBusinessObjectType.queries, providerId);
    }

    Json executeQuery(QueryExecutionDTO request) {
        return queryRuntime.execute(request);
    }
}

unittest {
    import uim.platform.bw.application.dto : BwObjectDTO;
    import uim.platform.bw.application.usecases.manage.manage_bw_objects : ManageBwObjectsUseCase;
    import uim.platform.bw.infrastructure.runtime.simulated : SimulatedBwQueryRuntime;
    import uim.platform.bw.infrastructure.persistence.memory.bw_repository : MemoryBwRepository;

    auto repo = new MemoryBwRepository();
    auto manage = new ManageBwObjectsUseCase(repo);
    auto query = new QueryBwAssetsUseCase(repo, new SimulatedBwQueryRuntime());

    BwObjectDTO provider;
    provider.objectType = BwBusinessObjectType.compositeProviders;
    provider.technicalName = "ZCP_SALES";
    auto providerResult = manage.create(provider);
    assert(providerResult.success);

    BwObjectDTO bwQuery;
    bwQuery.objectType = BwBusinessObjectType.queries;
    bwQuery.technicalName = "ZQ_SALES";
    bwQuery.parentId = providerResult.id;
    auto queryResult = manage.create(bwQuery);
    assert(queryResult.success);

    auto linked = query.listQueriesByProvider(providerResult.id);
    assert(linked.length == 1);

    auto searched = query.search("sales");
    assert(searched.length >= 2);

    QueryExecutionDTO execution;
    execution.providerId = providerResult.id;
    execution.queryId = queryResult.id;
    auto executed = query.executeQuery(execution);
    assert(("meta" in executed) !is null);
}
