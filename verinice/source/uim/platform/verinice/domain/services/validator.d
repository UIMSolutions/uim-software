module uim.platform.verinice.domain.services.validator;

import uim.platform.verinice.domain.entities.asset;
import uim.platform.verinice.domain.entities.assessment;
import uim.platform.verinice.domain.entities.safeguard;

@safe:

struct VeriniceValidator {
    static bool hasIdentity(string id, string tenantId, string name) {
        return id.length > 0 && tenantId.length > 0 && name.length > 0;
    }

    static bool isValidAsset(ref Asset value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.assetType.length > 0;
    }

    static bool isValidSafeguard(ref Safeguard value) {
        return hasIdentity(value.id, value.tenantId, value.title) && value.assetId.length > 0;
    }

    static bool isValidAssessment(ref Assessment value) {
        return hasIdentity(value.id, value.tenantId, value.status)
            && value.assetId.length > 0
            && value.safeguardId.length > 0;
    }
}
