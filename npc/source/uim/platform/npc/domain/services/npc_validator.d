module uim.platform.npc.domain.services.npc_validator;

import std.algorithm.searching : canFind;
import uim.platform.npc.domain.entities.npc_object : NpcObject, NpcBusinessObjectType;

@safe:

struct NpcValidator {
    static bool isValid(in NpcObject value) {
        if (!value.objectType.length) {
            return false;
        }

        immutable allowed = [
            NpcBusinessObjectType.organizations,
            NpcBusinessObjectType.suppliers,
            NpcBusinessObjectType.customers,
            NpcBusinessObjectType.products,
            NpcBusinessObjectType.locations,
            NpcBusinessObjectType.resources,
            NpcBusinessObjectType.capacities,
            NpcBusinessObjectType.demandPlans,
            NpcBusinessObjectType.supplyPlans,
            NpcBusinessObjectType.constrainedPlans,
            NpcBusinessObjectType.scenarios,
            NpcBusinessObjectType.assumptions,
            NpcBusinessObjectType.milestones,
            NpcBusinessObjectType.exceptions,
            NpcBusinessObjectType.alerts,
            NpcBusinessObjectType.commitments,
            NpcBusinessObjectType.allocations,
            NpcBusinessObjectType.collaborationThreads,
            NpcBusinessObjectType.comments,
            NpcBusinessObjectType.attachments,
            NpcBusinessObjectType.workflows,
            NpcBusinessObjectType.approvals,
            NpcBusinessObjectType.kpiDefinitions,
            NpcBusinessObjectType.kpiValues,
            NpcBusinessObjectType.apiDefinitions,
            NpcBusinessObjectType.auditEntries
        ];

        if (!allowed.canFind(value.objectType)) {
            return false;
        }

        return value.technicalName.length > 0 || value.businessName.length > 0;
    }
}

unittest {
    NpcObject valid;
    valid.objectType = NpcBusinessObjectType.demandPlans;
    valid.technicalName = "DP_Q1";
    assert(NpcValidator.isValid(valid));

    NpcObject invalidType;
    invalidType.objectType = "broken";
    invalidType.businessName = "Broken";
    assert(!NpcValidator.isValid(invalidType));
}
