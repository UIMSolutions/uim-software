module uim.platform.verinice.domain.integration.gs_catalog_sync_gateway;

import uim.platform.verinice.domain.entities.safeguard;
import uim.platform.verinice.domain.integration.types;

@safe:

interface GsCatalogSyncGateway {
    IntegrationResult syncSafeguard(Safeguard safeguard);
}
