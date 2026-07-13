module uim.platform.freight_collaboration.domain.integration.tender_sync_gateway;

import uim.platform.freight_collaboration.domain.entities.tender;
import uim.platform.freight_collaboration.domain.integration.types;

@safe:

interface TenderSyncGateway {
    IntegrationResult syncTender(Tender value);
}
