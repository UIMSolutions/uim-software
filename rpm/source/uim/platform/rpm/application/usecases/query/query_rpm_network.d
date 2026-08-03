module uim.platform.rpm.application.usecases.query.query_rpm_network;

import std.string : indexOf, toLower;
import vibe.data.json : Json;
import uim.platform.rpm.application.dto : KpiQueryDTO;
import uim.platform.rpm.application.ports.analytics_runtime : RpmAnalyticsRuntime;
import uim.platform.rpm.domain.entities.rpm_object : RpmObject, RpmBusinessObjectType;
import uim.platform.rpm.domain.repositories.rpm_repository : RpmRepository;

@safe:

class QueryRpmNetworkUseCase {
    private RpmRepository repository;
    private RpmAnalyticsRuntime analyticsRuntime;

    this(RpmRepository repository, RpmAnalyticsRuntime analyticsRuntime) {
        this.repository = repository;
        this.analyticsRuntime = analyticsRuntime;
    }

    RpmObject[] search(string query) {
        RpmObject[] pool;
        foreach (objectType; [
            RpmBusinessObjectType.packagingMaterials,
            RpmBusinessObjectType.packagingPools,
            RpmBusinessObjectType.partners,
            RpmBusinessObjectType.locations,
            RpmBusinessObjectType.shipmentOrders,
            RpmBusinessObjectType.returnOrders,
            RpmBusinessObjectType.serialAssets,
            RpmBusinessObjectType.apiDefinitions
        ]) {
            pool ~= repository.listByType(objectType);
        }

        auto needle = query.toLower();
        if (!needle.length) {
            return pool;
        }

        RpmObject[] result;
        foreach (item; pool) {
            if (item.technicalName.toLower().indexOf(needle) >= 0 ||
                item.businessName.toLower().indexOf(needle) >= 0 ||
                item.description.toLower().indexOf(needle) >= 0 ||
                item.externalReference.toLower().indexOf(needle) >= 0) {
                result ~= item;
            }
        }

        return result;
    }

    RpmObject[] traceAsset(string assetId) {
        RpmObject[] trace;

        auto serial = repository.getByTypeAndId(RpmBusinessObjectType.serialAssets, assetId);
        if (serial !is null) {
            RpmObject copy;
            copy.id = (*serial).id;
            copy.objectType = (*serial).objectType;
            copy.tenantId = (*serial).tenantId;
            copy.technicalName = (*serial).technicalName;
            copy.businessName = (*serial).businessName;
            copy.lifecycleState = (*serial).lifecycleState;
            copy.parentId = (*serial).parentId;
            copy.owner = (*serial).owner;
            copy.locationId = (*serial).locationId;
            copy.partnerId = (*serial).partnerId;
            copy.referenceId = (*serial).referenceId;
            copy.unitOfMeasure = (*serial).unitOfMeasure;
            copy.quantity = (*serial).quantity;
            copy.description = (*serial).description;
            copy.externalReference = (*serial).externalReference;
            copy.createdBy = (*serial).createdBy;
            copy.modifiedBy = (*serial).modifiedBy;
            copy.createdAt = (*serial).createdAt;
            copy.modifiedAt = (*serial).modifiedAt;
            copy.metadata = (*serial).metadata.dup;
            trace ~= copy;
        }

        trace ~= repository.listByParent(RpmBusinessObjectType.telemetryEvents, assetId);
        trace ~= repository.listByParent(RpmBusinessObjectType.qualityInspections, assetId);
        trace ~= repository.listByParent(RpmBusinessObjectType.cleaningOrders, assetId);
        trace ~= repository.listByParent(RpmBusinessObjectType.repairOrders, assetId);
        trace ~= repository.listByParent(RpmBusinessObjectType.shipmentItems, assetId);
        trace ~= repository.listByParent(RpmBusinessObjectType.returnItems, assetId);

        return trace;
    }

    RpmObject[] listPoolBalances(string poolId) {
        return repository.listByParent(RpmBusinessObjectType.inventorySnapshots, poolId);
    }

    Json kpis(KpiQueryDTO query) {
        return analyticsRuntime.summarize(query);
    }
}

unittest {
    import uim.platform.rpm.application.dto : RpmObjectDTO;
    import uim.platform.rpm.application.usecases.manage.manage_rpm_objects : ManageRpmObjectsUseCase;
    import uim.platform.rpm.infrastructure.persistence.memory.rpm_repository : MemoryRpmRepository;
    import uim.platform.rpm.infrastructure.runtime.simulated_analytics : SimulatedRpmAnalyticsRuntime;

    auto repo = new MemoryRpmRepository();
    auto manage = new ManageRpmObjectsUseCase(repo);
    auto query = new QueryRpmNetworkUseCase(repo, new SimulatedRpmAnalyticsRuntime());

    RpmObjectDTO asset;
    asset.objectType = RpmBusinessObjectType.serialAssets;
    asset.id = "SER-1000";
    asset.technicalName = "PALLET-SER-1000";
    assert(manage.create(asset).success);

    RpmObjectDTO evt;
    evt.objectType = RpmBusinessObjectType.telemetryEvents;
    evt.parentId = "SER-1000";
    evt.technicalName = "SCAN";
    assert(manage.create(evt).success);

    auto trace = query.traceAsset("SER-1000");
    assert(trace.length >= 2);

    auto searched = query.search("pallet");
    assert(searched.length >= 1);

    KpiQueryDTO req;
    auto summary = query.kpis(req);
    assert(("metrics" in summary) !is null);
}
