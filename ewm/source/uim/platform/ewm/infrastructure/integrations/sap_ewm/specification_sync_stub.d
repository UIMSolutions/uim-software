module uim.platform.ewm.infrastructure.integrations.sap_ewm.specification_sync_stub;

import uim.platform.ewm;

@safe:

class SapSpecificationSyncStubGateway : SpecificationSyncGateway {
    override IntegrationResult sync(Specification value) {
        IntegrationResult result;
        result.success = true;
        result.externalId = "sap-stock-" ~ value.id;
        result.message = "Stub specification sync completed for stock item " ~ value.id;
        return result;
    }
}
