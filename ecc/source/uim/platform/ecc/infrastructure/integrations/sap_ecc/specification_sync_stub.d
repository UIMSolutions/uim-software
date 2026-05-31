module uim.platform.ecc.infrastructure.integrations.sap_ecc.specification_sync_stub;

import uim.platform.ecc;

@safe:

class SapSpecificationSyncStubGateway : SpecificationSyncGateway {
    override IntegrationResult sync(Specification value) {
        IntegrationResult result;
        result.success = true;
        result.externalId = "sap-spec-" ~ value.id;
        result.message = "Stub specification sync completed for specification " ~ value.id;
        return result;
    }
}
