module uim.platform.ibp.infrastructure.integrations.sap_ibp.product_handover_stub;

import uim.platform.ibp;

@safe:

class SapProductHandoverStubGateway : ProductHandoverGateway {
    override IntegrationResult handover(Product value) {
        IntegrationResult result;
        result.success = true;
        result.externalId = "sap-ibp-master-" ~ value.id;
        result.message = "Stub master data sync completed for demand plan " ~ value.id;
        return result;
    }
}
