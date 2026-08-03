module uim.platform.material_traceability.domain.services.mt_validator;

import std.algorithm.searching : canFind;
import uim.platform.material_traceability.domain.entities.mt_object : MtObject, MtBusinessObjectType;

@safe:

struct MtValidator {
    static bool isValid(in MtObject value) {
        if (!value.objectType.length) {
            return false;
        }

        immutable allowed = [
            MtBusinessObjectType.materials,
            MtBusinessObjectType.materialLots,
            MtBusinessObjectType.batches,
            MtBusinessObjectType.serialNumbers,
            MtBusinessObjectType.suppliers,
            MtBusinessObjectType.manufacturers,
            MtBusinessObjectType.plants,
            MtBusinessObjectType.warehouses,
            MtBusinessObjectType.shipmentUnits,
            MtBusinessObjectType.transportEvents,
            MtBusinessObjectType.transformationEvents,
            MtBusinessObjectType.consumptionEvents,
            MtBusinessObjectType.qualityInspections,
            MtBusinessObjectType.certificates,
            MtBusinessObjectType.complianceStatements,
            MtBusinessObjectType.recallCases,
            MtBusinessObjectType.incidents,
            MtBusinessObjectType.chainOfCustodyLinks,
            MtBusinessObjectType.lineageViews,
            MtBusinessObjectType.riskAssessments,
            MtBusinessObjectType.partnerMappings,
            MtBusinessObjectType.documentReferences,
            MtBusinessObjectType.apiDefinitions,
            MtBusinessObjectType.auditEntries
        ];

        if (!allowed.canFind(value.objectType)) {
            return false;
        }

        return value.technicalName.length > 0 || value.businessName.length > 0;
    }
}

unittest {
    MtObject valid;
    valid.objectType = MtBusinessObjectType.materials;
    valid.technicalName = "MAT_4711";
    assert(MtValidator.isValid(valid));

    MtObject invalid;
    invalid.objectType = "invalid";
    invalid.businessName = "Broken";
    assert(!MtValidator.isValid(invalid));
}
