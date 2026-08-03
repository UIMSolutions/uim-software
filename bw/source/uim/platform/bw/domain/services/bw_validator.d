module uim.platform.bw.domain.services.bw_validator;

import std.algorithm.searching : canFind;
import uim.platform.bw.domain.entities.bw_object : BwObject, BwBusinessObjectType;

@safe:

struct BwValidator {
    static bool isValid(in BwObject value) {
        if (!value.objectType.length) {
            return false;
        }

        immutable allowed = [
            BwBusinessObjectType.infoAreas,
            BwBusinessObjectType.infoObjects,
            BwBusinessObjectType.characteristics,
            BwBusinessObjectType.keyFigures,
            BwBusinessObjectType.hierarchies,
            BwBusinessObjectType.dataSources,
            BwBusinessObjectType.transformations,
            BwBusinessObjectType.dtrs,
            BwBusinessObjectType.adsos,
            BwBusinessObjectType.openHubDestinations,
            BwBusinessObjectType.compositeProviders,
            BwBusinessObjectType.cubes,
            BwBusinessObjectType.multiProviders,
            BwBusinessObjectType.queries,
            BwBusinessObjectType.workbooks,
            BwBusinessObjectType.processChains,
            BwBusinessObjectType.analysisAuthorizations,
            BwBusinessObjectType.planningModels,
            BwBusinessObjectType.aggregationLevels,
            BwBusinessObjectType.planningFunctions,
            BwBusinessObjectType.dataSlices,
            BwBusinessObjectType.dataFlows,
            BwBusinessObjectType.apiDefinitions,
            BwBusinessObjectType.auditEntries
        ];

        if (!allowed.canFind(value.objectType)) {
            return false;
        }

        return value.technicalName.length > 0 || value.businessName.length > 0;
    }
}

unittest {
    BwObject valid;
    valid.objectType = BwBusinessObjectType.infoObjects;
    valid.technicalName = "ZCUSTOMER";
    assert(BwValidator.isValid(valid));

    BwObject invalidType;
    invalidType.objectType = "invalid-type";
    invalidType.businessName = "Broken";
    assert(!BwValidator.isValid(invalidType));
}
