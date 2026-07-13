module uim.platform.freight_collaboration.application.usecases.integration.freight_collaboration_integrations;

import uim.platform.freight_collaboration;

@safe:

class RunFreightCollaborationIntegrationsUseCase : UIMUseCase {
    private TenderRepository tenderRepo;
    private TenderSyncGateway tenderSyncGateway;

    this(
        TenderRepository tenderRepo,
        TenderSyncGateway tenderSyncGateway
    ) {
        this.tenderRepo = tenderRepo;
        this.tenderSyncGateway = tenderSyncGateway;
    }

    CommandResult syncTender(TenderId id) {
        auto tender = tenderRepo.findById(id);
        if (tender is null) {
            return CommandResult(false, "", "Tender not found");
        }

        auto result = tenderSyncGateway.syncTender(*tender);
        if (!result.success) {
            return CommandResult(false, "", result.message);
        }

        return CommandResult(true, result.externalId, result.message);
    }
}
