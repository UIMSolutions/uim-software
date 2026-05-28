/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.infrastructure.container;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

struct Container {
    ManageSecurityEventsUseCase manageSecurityEventsUseCase;
    ManageAlertsUseCase manageAlertsUseCase;
    ManageIncidentsUseCase manageIncidentsUseCase;
    ManageCorrelationRulesUseCase manageCorrelationRulesUseCase;
    ManageAssetsUseCase manageAssetsUseCase;
    ManageThreatIndicatorsUseCase manageThreatIndicatorsUseCase;

    SecurityEventController securityEventController;
    AlertController alertController;
    IncidentController incidentController;
    CorrelationRuleController correlationRuleController;
    AssetController assetController;
    ThreatIndicatorController threatIndicatorController;
    HealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container c;

    // Repositories
    auto securityEventRepo = new MemorySecurityEventRepository();
    auto alertRepo = new MemoryAlertRepository();
    auto incidentRepo = new MemoryIncidentRepository();
    auto correlationRuleRepo = new MemoryCorrelationRuleRepository();
    auto assetRepo = new MemoryAssetRepository();
    auto threatIndicatorRepo = new MemoryThreatIndicatorRepository();

    // Use Cases
    c.manageSecurityEventsUseCase = new ManageSecurityEventsUseCase(securityEventRepo);
    c.manageAlertsUseCase = new ManageAlertsUseCase(alertRepo);
    c.manageIncidentsUseCase = new ManageIncidentsUseCase(incidentRepo);
    c.manageCorrelationRulesUseCase = new ManageCorrelationRulesUseCase(correlationRuleRepo);
    c.manageAssetsUseCase = new ManageAssetsUseCase(assetRepo);
    c.manageThreatIndicatorsUseCase = new ManageThreatIndicatorsUseCase(threatIndicatorRepo);

    // Controllers
    c.securityEventController = new SecurityEventController(c.manageSecurityEventsUseCase);
    c.alertController = new AlertController(c.manageAlertsUseCase);
    c.incidentController = new IncidentController(c.manageIncidentsUseCase);
    c.correlationRuleController = new CorrelationRuleController(c.manageCorrelationRulesUseCase);
    c.assetController = new AssetController(c.manageAssetsUseCase);
    c.threatIndicatorController = new ThreatIndicatorController(c.manageThreatIndicatorsUseCase);
    c.healthController = new HealthController("siem", "1.0.0");

    return c;
}
