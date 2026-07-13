module uim.platform.freight_collaboration.domain.services.validator;

import uim.platform.freight_collaboration.domain.entities.freight_order;
import uim.platform.freight_collaboration.domain.entities.milestone_update;
import uim.platform.freight_collaboration.domain.entities.tender;

@safe:

struct FreightCollaborationValidator {
    static bool hasIdentity(string id, string tenantId, string name) {
        return id.length > 0 && tenantId.length > 0 && name.length > 0;
    }

    static bool isValidFreightOrder(ref FreightOrder value) {
        return hasIdentity(value.id, value.tenantId, value.orderNumber)
            && value.originLocation.length > 0
            && value.destinationLocation.length > 0;
    }

    static bool isValidTender(ref Tender value) {
        return hasIdentity(value.id, value.tenantId, value.tenderNumber)
            && value.freightOrderId.length > 0;
    }

    static bool isValidMilestone(ref MilestoneUpdate value) {
        return hasIdentity(value.id, value.tenantId, value.milestoneType)
            && value.freightOrderId.length > 0
            && value.eventTime.length > 0;
    }
}
