module uim.platform.freight_collaboration.infrastructure.integrations.sap_bn_fc.tender_sync_stub;

import uim.platform.freight_collaboration;

@safe:

class SapBnTenderSyncStubGateway : TenderSyncGateway {
    override IntegrationResult syncTender(Tender value) {
        return IntegrationResult(
            true,
            "sap-bn-fc-" ~ value.tenderNumber ~ "-" ~ value.id,
            "Stub tender sync completed for tender " ~ value.id
        );
    }
}
