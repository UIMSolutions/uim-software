/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.container;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct Container {
    // Use cases
    ManageITServicesUseCase manageITServices;
    ManageServiceRequestsUseCase manageServiceRequests;
    ManageIncidentsUseCase manageIncidents;
    ManageProblemsUseCase manageProblems;
    ManageChangeRecordsUseCase manageChangeRecords;
    ManageConfigurationItemsUseCase manageConfigurationItems;
    ManageSLAsUseCase manageSLAs;
    ManageKnowledgeArticlesUseCase manageKnowledgeArticles;
    ManageReleaseRecordsUseCase manageReleaseRecords;
    ManageMonitoringEventsUseCase manageMonitoringEvents;
    ManageImprovementItemsUseCase manageImprovementItems;
    ManageITAssetsUseCase manageITAssets;

    // Controllers
    ITServiceController itServiceController;
    ServiceRequestController serviceRequestController;
    IncidentController incidentController;
    ProblemController problemController;
    ChangeController changeController;
    ConfigurationItemController configurationItemController;
    SLAController slaController;
    KnowledgeController knowledgeController;
    ReleaseController releaseController;
    EventController eventController;
    ImprovementController improvementController;
    AssetController assetController;
    HealthController healthController;
}

Container buildContainer(AppConfig cfg) {
    Container c;

    // Repositories
    auto itServiceRepo          = new MemoryITServiceRepository();
    auto serviceRequestRepo     = new MemoryServiceRequestRepository();
    auto incidentRepo           = new MemoryIncidentRepository();
    auto problemRepo            = new MemoryProblemRepository();
    auto changeRecordRepo       = new MemoryChangeRecordRepository();
    auto configurationItemRepo  = new MemoryConfigurationItemRepository();
    auto slaRepo                = new MemorySLARepository();
    auto knowledgeArticleRepo   = new MemoryKnowledgeArticleRepository();
    auto releaseRecordRepo      = new MemoryReleaseRecordRepository();
    auto monitoringEventRepo    = new MemoryMonitoringEventRepository();
    auto improvementItemRepo    = new MemoryImprovementItemRepository();
    auto itAssetRepo            = new MemoryITAssetRepository();

    // Use cases
    c.manageITServices          = new ManageITServicesUseCase(itServiceRepo);
    c.manageServiceRequests     = new ManageServiceRequestsUseCase(serviceRequestRepo);
    c.manageIncidents           = new ManageIncidentsUseCase(incidentRepo);
    c.manageProblems            = new ManageProblemsUseCase(problemRepo);
    c.manageChangeRecords       = new ManageChangeRecordsUseCase(changeRecordRepo);
    c.manageConfigurationItems  = new ManageConfigurationItemsUseCase(configurationItemRepo);
    c.manageSLAs                = new ManageSLAsUseCase(slaRepo);
    c.manageKnowledgeArticles   = new ManageKnowledgeArticlesUseCase(knowledgeArticleRepo);
    c.manageReleaseRecords      = new ManageReleaseRecordsUseCase(releaseRecordRepo);
    c.manageMonitoringEvents    = new ManageMonitoringEventsUseCase(monitoringEventRepo);
    c.manageImprovementItems    = new ManageImprovementItemsUseCase(improvementItemRepo);
    c.manageITAssets            = new ManageITAssetsUseCase(itAssetRepo);

    // Controllers
    c.itServiceController           = new ITServiceController(c.manageITServices);
    c.serviceRequestController      = new ServiceRequestController(c.manageServiceRequests);
    c.incidentController            = new IncidentController(c.manageIncidents);
    c.problemController             = new ProblemController(c.manageProblems);
    c.changeController              = new ChangeController(c.manageChangeRecords);
    c.configurationItemController   = new ConfigurationItemController(c.manageConfigurationItems);
    c.slaController                 = new SLAController(c.manageSLAs);
    c.knowledgeController           = new KnowledgeController(c.manageKnowledgeArticles);
    c.releaseController             = new ReleaseController(c.manageReleaseRecords);
    c.eventController               = new EventController(c.manageMonitoringEvents);
    c.improvementController         = new ImprovementController(c.manageImprovementItems);
    c.assetController               = new AssetController(c.manageITAssets);
    c.healthController              = new HealthController();

    return c;
}
