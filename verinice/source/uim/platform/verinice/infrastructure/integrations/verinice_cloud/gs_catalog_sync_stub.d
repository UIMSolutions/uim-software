module uim.platform.verinice.infrastructure.integrations.verinice_cloud.gs_catalog_sync_stub;

import uim.platform.verinice;

@safe:

class GsCatalogSyncStubGateway : GsCatalogSyncGateway {
    override IntegrationResult syncSafeguard(Safeguard safeguard) {
        return IntegrationResult(
            true,
            "verinice-gs-" ~ safeguard.code ~ "-" ~ safeguard.id,
            "Stub IT-Grundschutz catalog sync completed for safeguard " ~ safeguard.id
        );
    }
}
