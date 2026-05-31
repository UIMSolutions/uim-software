module uim.platform.epd.infrastructure.integrations.sap_ipd.specification_sync_stub;

import uim.platform.epd;

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
