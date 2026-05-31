module uim.platform.ewm.infrastructure.integrations.sap_ewm.product_handover_stub;

import uim.platform.ewm;

@safe:

class SapProductHandoverStubGateway : ProductHandoverGateway {
    override IntegrationResult handover(Product value) {
        IntegrationResult result;
        result.success = true;
        result.externalId = "sap-warehouse-" ~ value.id;
        result.message = "Stub handover completed for warehouse " ~ value.id;
        return result;
    }
}
