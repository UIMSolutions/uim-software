module uim.platform.mes.infrastructure.integrations.sap_mes.specification_sync_stub;

import uim.platform.mes;

@safe:

class SapSpecificationSyncStubGateway : SpecificationSyncGateway {
    override IntegrationResult sync(Specification value) {
        IntegrationResult result;
        result.success = true;
        result.externalId = "sap-mes-quality-" ~ value.id;
        result.message = "Stub quality sync completed for inspection " ~ value.id;
        return result;
    }
}
