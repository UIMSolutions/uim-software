module uim.platform.etd.infrastructure.container;

import uim.platform.etd;

@safe:

struct Container {
    AppConfig config;

    ManageIncidentsUseCase manageIncidentsUseCase;
    ManageThreatIndicatorsUseCase manageThreatIndicatorsUseCase;
    ManageDetectionRulesUseCase manageDetectionRulesUseCase;
    RunEtdIntegrationsUseCase runEtdIntegrationsUseCase;

    EtdHealthController healthController;
    IncidentController incidentController;
    ThreatIndicatorController threatIndicatorController;
    DetectionRuleController detectionRuleController;
    IntegrationController integrationController;
}

Container buildContainer(AppConfig config) {
    Container c;
    c.config = config;

    auto incidentRepo = new MemoryIncidentRepository();
    auto indicatorRepo = new MemoryThreatIndicatorRepository();
    auto ruleRepo = new MemoryDetectionRuleRepository();

    auto threatIntelGateway = new SapThreatIntelStubGateway();

    c.manageIncidentsUseCase = new ManageIncidentsUseCase(incidentRepo);
    c.manageThreatIndicatorsUseCase = new ManageThreatIndicatorsUseCase(indicatorRepo);
    c.manageDetectionRulesUseCase = new ManageDetectionRulesUseCase(ruleRepo);
    c.runEtdIntegrationsUseCase = new RunEtdIntegrationsUseCase(indicatorRepo, threatIntelGateway);

    c.healthController = new EtdHealthController();
    c.incidentController = new IncidentController(c.manageIncidentsUseCase);
    c.threatIndicatorController = new ThreatIndicatorController(c.manageThreatIndicatorsUseCase);
    c.detectionRuleController = new DetectionRuleController(c.manageDetectionRulesUseCase);
    c.integrationController = new IntegrationController(c.runEtdIntegrationsUseCase);

    return c;
}
