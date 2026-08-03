module uim.platform.ead.domain.services.ead_validator;

import std.algorithm.searching : canFind;
import uim.platform.ead.domain.entities.ead_object : EadObject, EadBusinessObjectType;

@safe:

struct EadValidator {
    static bool isValid(in EadObject value) {
        if (!value.objectType.length) {
            return false;
        }

        immutable allowed = [
            EadBusinessObjectType.businessCapabilities,
            EadBusinessObjectType.valueStreams,
            EadBusinessObjectType.businessProcesses,
            EadBusinessObjectType.processSteps,
            EadBusinessObjectType.businessServices,
            EadBusinessObjectType.organizationUnits,
            EadBusinessObjectType.roles,
            EadBusinessObjectType.informationObjects,
            EadBusinessObjectType.dataObjects,
            EadBusinessObjectType.applicationComponents,
            EadBusinessObjectType.applicationServices,
            EadBusinessObjectType.interfaces,
            EadBusinessObjectType.apiDefinitions,
            EadBusinessObjectType.integrationFlows,
            EadBusinessObjectType.technologyComponents,
            EadBusinessObjectType.technologyServices,
            EadBusinessObjectType.systems,
            EadBusinessObjectType.landscapes,
            EadBusinessObjectType.standards,
            EadBusinessObjectType.principles,
            EadBusinessObjectType.viewpoints,
            EadBusinessObjectType.diagrams,
            EadBusinessObjectType.dependencies,
            EadBusinessObjectType.roadmaps,
            EadBusinessObjectType.workPackages,
            EadBusinessObjectType.projects,
            EadBusinessObjectType.risks,
            EadBusinessObjectType.controls,
            EadBusinessObjectType.auditEntries
        ];

        if (!allowed.canFind(value.objectType)) {
            return false;
        }

        return value.technicalName.length > 0 || value.businessName.length > 0;
    }
}

unittest {
    EadObject valid;
    valid.objectType = EadBusinessObjectType.applicationComponents;
    valid.technicalName = "APP_FIN_AR";
    assert(EadValidator.isValid(valid));

    EadObject invalid;
    invalid.objectType = "unknown";
    invalid.businessName = "Bad";
    assert(!EadValidator.isValid(invalid));
}
