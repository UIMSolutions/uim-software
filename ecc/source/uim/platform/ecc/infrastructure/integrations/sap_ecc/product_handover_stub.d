module uim.platform.ecc.infrastructure.integrations.sap_ecc.product_handover_stub;

import uim.platform.ecc;

@safe:

class SapProductHandoverStubGateway : ProductHandoverGateway {
    override IntegrationResult handover(Product value) {
        IntegrationResult result;
        result.success = true;
        result.externalId = "sap-handover-" ~ value.id;
        result.message = "Stub handover completed for product " ~ value.id;
        return result;
    }
}
