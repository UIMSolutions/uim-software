module uim.platform.etd.application.usecases.integration.run_etd_integrations;

import uim.platform.etd;

@safe:

class RunEtdIntegrationsUseCase {
    private ThreatIndicatorRepository indicatorRepo;
    private ThreatIntelGateway gateway;

    this(ThreatIndicatorRepository indicatorRepo, ThreatIntelGateway gateway) {
        this.indicatorRepo = indicatorRepo;
        this.gateway = gateway;
    }

    CommandResult syncThreatIndicator(string id) {
        auto indicator = indicatorRepo.get_(id);
        if (indicator is null) {
            return CommandResult(false, "", "Threat indicator not found");
        }

        auto result = gateway.syncIndicator(*indicator);
        if (!result.success) {
            return result;
        }

        return CommandResult(true, result.id.length ? result.id : id, result.error);
    }
}
