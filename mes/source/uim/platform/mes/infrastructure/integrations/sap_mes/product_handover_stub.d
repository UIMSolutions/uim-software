module uim.platform.mes.infrastructure.integrations.sap_mes.product_handover_stub;

import uim.platform.mes;

@safe:

class SapProductHandoverStubGateway : ProductHandoverGateway {
    override IntegrationResult handover(Product value) {
        IntegrationResult result;
        result.success = true;
        result.externalId = "sap-mes-order-" ~ value.id;
        result.message = "Stub order sync completed for production order " ~ value.id;
        return result;
    }
}
