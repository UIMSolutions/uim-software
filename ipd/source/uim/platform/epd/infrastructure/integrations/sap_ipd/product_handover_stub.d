module uim.platform.epd.infrastructure.integrations.sap_ipd.product_handover_stub;

import uim.platform.epd;

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
