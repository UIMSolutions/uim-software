module uim.platform.maif.application.usecases.integration.run_maif_integrations;

import uim.platform.maif;

@safe:

class RunMaifIntegrationsUseCase {
    private MobileAppRepository mobileAppRepo;
    private MobileBackendGateway backendGateway;

    this(MobileAppRepository mobileAppRepo, MobileBackendGateway backendGateway) {
        this.mobileAppRepo = mobileAppRepo;
        this.backendGateway = backendGateway;
    }

    CommandResult publishMobileApp(string appId) {
        auto app = mobileAppRepo.get_(appId);
        if (app is null) {
            return CommandResult(false, "", "Mobile app not found");
        }

        return backendGateway.publishMobileApp(*app);
    }
}
