/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.infrastructure.container;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

struct Container {
    ManageObjectivesUseCase manageObjectivesUseCase;
    ManagePlatformsUseCase managePlatformsUseCase;
    ManageInitiativesUseCase manageInitiativesUseCase;
    ManageOrganizationsUseCase manageOrganizationsUseCase;
    ManageBusinessCapabilitiesUseCase manageBusinessCapabilitiesUseCase;
    ManageBusinessContextsUseCase manageBusinessContextsUseCase;
    ManageDataObjectsUseCase manageDataObjectsUseCase;
    ManageLeanApplicationsUseCase manageLeanApplicationsUseCase;
    ManageAppInterfacesUseCase manageAppInterfacesUseCase;
    ManageProvidersUseCase manageProvidersUseCase;
    ManageITComponentsUseCase manageITComponentsUseCase;
    ManageTechCategoriesUseCase manageTechCategoriesUseCase;

    ObjectiveController objectiveController;
    LeanPlatformController platformController;
    InitiativeController initiativeController;
    OrganizationController organizationController;
    BusinessCapabilityController businessCapabilityController;
    BusinessContextController businessContextController;
    DataObjectController dataObjectController;
    LeanApplicationController applicationController;
    AppInterfaceController interfaceController;
    ProviderController providerController;
    ITComponentController itComponentController;
    TechCategoryController techCategoryController;
    HealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container c;

    // Repositories
    auto objectiveRepo = new MemoryObjectiveRepository();
    auto platformRepo = new MemoryPlatformRepository();
    auto initiativeRepo = new MemoryInitiativeRepository();
    auto organizationRepo = new MemoryOrganizationRepository();
    auto businessCapabilityRepo = new MemoryBusinessCapabilityRepository();
    auto businessContextRepo = new MemoryBusinessContextRepository();
    auto dataObjectRepo = new MemoryDataObjectRepository();
    auto applicationRepo = new MemoryLeanApplicationRepository();
    auto interfaceRepo = new MemoryAppInterfaceRepository();
    auto providerRepo = new MemoryProviderRepository();
    auto itComponentRepo = new MemoryITComponentRepository();
    auto techCategoryRepo = new MemoryTechCategoryRepository();

    // Use Cases
    c.manageObjectivesUseCase = new ManageObjectivesUseCase(objectiveRepo);
    c.managePlatformsUseCase = new ManagePlatformsUseCase(platformRepo);
    c.manageInitiativesUseCase = new ManageInitiativesUseCase(initiativeRepo);
    c.manageOrganizationsUseCase = new ManageOrganizationsUseCase(organizationRepo);
    c.manageBusinessCapabilitiesUseCase = new ManageBusinessCapabilitiesUseCase(businessCapabilityRepo);
    c.manageBusinessContextsUseCase = new ManageBusinessContextsUseCase(businessContextRepo);
    c.manageDataObjectsUseCase = new ManageDataObjectsUseCase(dataObjectRepo);
    c.manageLeanApplicationsUseCase = new ManageLeanApplicationsUseCase(applicationRepo);
    c.manageAppInterfacesUseCase = new ManageAppInterfacesUseCase(interfaceRepo);
    c.manageProvidersUseCase = new ManageProvidersUseCase(providerRepo);
    c.manageITComponentsUseCase = new ManageITComponentsUseCase(itComponentRepo);
    c.manageTechCategoriesUseCase = new ManageTechCategoriesUseCase(techCategoryRepo);

    // Controllers
    c.objectiveController = new ObjectiveController(c.manageObjectivesUseCase);
    c.platformController = new LeanPlatformController(c.managePlatformsUseCase);
    c.initiativeController = new InitiativeController(c.manageInitiativesUseCase);
    c.organizationController = new OrganizationController(c.manageOrganizationsUseCase);
    c.businessCapabilityController = new BusinessCapabilityController(c.manageBusinessCapabilitiesUseCase);
    c.businessContextController = new BusinessContextController(c.manageBusinessContextsUseCase);
    c.dataObjectController = new DataObjectController(c.manageDataObjectsUseCase);
    c.applicationController = new LeanApplicationController(c.manageLeanApplicationsUseCase);
    c.interfaceController = new AppInterfaceController(c.manageAppInterfacesUseCase);
    c.providerController = new ProviderController(c.manageProvidersUseCase);
    c.itComponentController = new ITComponentController(c.manageITComponentsUseCase);
    c.techCategoryController = new TechCategoryController(c.manageTechCategoriesUseCase);
    c.healthController = new HealthController("lean", "1.0.0");

    return c;
}
