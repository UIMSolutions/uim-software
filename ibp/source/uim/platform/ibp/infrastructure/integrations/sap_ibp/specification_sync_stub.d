module uim.platform.ibp.infrastructure.integrations.sap_ibp.specification_sync_stub;

import uim.platform.ibp;

@safe:

class SapSpecificationSyncStubGateway : SpecificationSyncGateway {
    override IntegrationResult sync(Specification value) {
        IntegrationResult result;
        result.success = true;
        result.externalId = "sap-ibp-analytics-" ~ value.id;
        result.message = "Stub analytics sync completed for scenario " ~ value.id;
        return result;
    }
}
