module uim.platform.mii.infrastructure.integrations.sap_mii.specification_sync_stub;

import uim.platform.mii;

@safe:

class SapSpecificationSyncStubGateway : SpecificationSyncGateway {
    override IntegrationResult sync(Specification value) {
        IntegrationResult result;
        result.success = true;
        result.externalId = "sap-mii-analytics-" ~ value.id;
        result.message = "Stub analytics sync completed for alert notification " ~ value.id;
        return result;
    }
}
