module uim.platform.mii.infrastructure.integrations.sap_mii.product_handover_stub;

import uim.platform.mii;

@safe:

class SapProductHandoverStubGateway : ProductHandoverGateway {
    override IntegrationResult handover(Product value) {
        IntegrationResult result;
        result.success = true;
        result.externalId = "sap-mii-message-" ~ value.id;
        result.message = "Stub ERP message sync completed for production message " ~ value.id;
        return result;
    }
}
