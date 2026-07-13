module uim.platform.verinice.application.usecases.integration.verinice_integrations;

import uim.platform.verinice;

@safe:

class RunVeriniceIntegrationsUseCase : UIMUseCase {
    private SafeguardRepository safeguardRepo;
    private GsCatalogSyncGateway gsCatalogSyncGateway;

    this(
        SafeguardRepository safeguardRepo,
        GsCatalogSyncGateway gsCatalogSyncGateway
    ) {
        this.safeguardRepo = safeguardRepo;
        this.gsCatalogSyncGateway = gsCatalogSyncGateway;
    }

    CommandResult syncSafeguardCatalog(SafeguardId id) {
        auto safeguard = safeguardRepo.findById(id);
        if (safeguard is null) {
            return CommandResult(false, "", "Safeguard not found");
        }

        auto result = gsCatalogSyncGateway.syncSafeguard(*safeguard);
        if (!result.success) {
            return CommandResult(false, "", result.message);
        }

        return CommandResult(true, result.externalId, result.message);
    }
}
