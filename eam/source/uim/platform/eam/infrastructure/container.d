/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.infrastructure.container;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

struct Container {
    ManageEquipmentUseCase manageEquipmentUseCase;
    ManageFunctionalLocationsUseCase manageFunctionalLocationsUseCase;
    ManageMaintenanceOrdersUseCase manageMaintenanceOrdersUseCase;
    ManageMaintenanceNotificationsUseCase manageMaintenanceNotificationsUseCase;
    ManageMaintenancePlansUseCase manageMaintenancePlansUseCase;
    ManageWorkCentersUseCase manageWorkCentersUseCase;
    ManageMaterialBOMsUseCase manageMaterialBOMsUseCase;
    ManageMaintenanceItemsUseCase manageMaintenanceItemsUseCase;

    EquipmentController equipmentController;
    FunctionalLocationController functionalLocationController;
    MaintenanceOrderController maintenanceOrderController;
    MaintenanceNotificationController maintenanceNotificationController;
    MaintenancePlanController maintenancePlanController;
    WorkCenterController workCenterController;
    MaterialBOMController materialBOMController;
    MaintenanceItemController maintenanceItemController;
    HealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container c;

    // Repositories
    auto equipmentRepo = new MemoryEquipmentRepository();
    auto functionalLocationRepo = new MemoryFunctionalLocationRepository();
    auto maintenanceOrderRepo = new MemoryMaintenanceOrderRepository();
    auto maintenanceNotificationRepo = new MemoryMaintenanceNotificationRepository();
    auto maintenancePlanRepo = new MemoryMaintenancePlanRepository();
    auto workCenterRepo = new MemoryWorkCenterRepository();
    auto materialBOMRepo = new MemoryMaterialBOMRepository();
    auto maintenanceItemRepo = new MemoryMaintenanceItemRepository();

    // Use Cases
    c.manageEquipmentUseCase = new ManageEquipmentUseCase(equipmentRepo);
    c.manageFunctionalLocationsUseCase = new ManageFunctionalLocationsUseCase(functionalLocationRepo);
    c.manageMaintenanceOrdersUseCase = new ManageMaintenanceOrdersUseCase(maintenanceOrderRepo);
    c.manageMaintenanceNotificationsUseCase = new ManageMaintenanceNotificationsUseCase(maintenanceNotificationRepo);
    c.manageMaintenancePlansUseCase = new ManageMaintenancePlansUseCase(maintenancePlanRepo);
    c.manageWorkCentersUseCase = new ManageWorkCentersUseCase(workCenterRepo);
    c.manageMaterialBOMsUseCase = new ManageMaterialBOMsUseCase(materialBOMRepo);
    c.manageMaintenanceItemsUseCase = new ManageMaintenanceItemsUseCase(maintenanceItemRepo);

    // Controllers
    c.equipmentController = new EquipmentController(c.manageEquipmentUseCase);
    c.functionalLocationController = new FunctionalLocationController(c.manageFunctionalLocationsUseCase);
    c.maintenanceOrderController = new MaintenanceOrderController(c.manageMaintenanceOrdersUseCase);
    c.maintenanceNotificationController = new MaintenanceNotificationController(c.manageMaintenanceNotificationsUseCase);
    c.maintenancePlanController = new MaintenancePlanController(c.manageMaintenancePlansUseCase);
    c.workCenterController = new WorkCenterController(c.manageWorkCentersUseCase);
    c.materialBOMController = new MaterialBOMController(c.manageMaterialBOMsUseCase);
    c.maintenanceItemController = new MaintenanceItemController(c.manageMaintenanceItemsUseCase);
    c.healthController = new HealthController();

    return c;
}
