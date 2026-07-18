/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.defemse.infrastructure.container;

import uim.platform.defemse.infrastructure.config;
import uim.platform.defemse.infrastructure.persistence.repositories;
import uim.platform.defemse.presentation.http.controllers;

struct Container {
    AppConfig config;

    ManageMissionPlansUseCase manageMissionPlans;
    ManageExercisesUseCase manageExercises;
    ManageContingentsUseCase manageContingents;
    ManageReadinessUseCase manageReadiness;
    ManageRedeploymentOrdersUseCase manageRedeploymentOrders;
    ManageMaintenanceTasksUseCase manageMaintenanceTasks;
    ManageBudgetTriggersUseCase manageBudgetTriggers;
    ManageOfflineSyncRecordsUseCase manageOfflineSyncRecords;

    MissionPlanController missionPlanController;
    ExerciseController exerciseController;
    ContingentController contingentController;
    ReadinessController readinessController;
    RedeploymentOrderController redeploymentOrderController;
    MaintenanceTaskController maintenanceTaskController;
    BudgetTriggerController budgetTriggerController;
    OfflineSyncRecordController offlineSyncRecordController;
    HealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container container;
    container.config = config;

    auto missionPlanRepo = new MemoryMissionPlanRepository();
    auto exerciseRepo = new MemoryExerciseRepository();
    auto contingentRepo = new MemoryContingentRepository();
    auto readinessRepo = new MemoryReadinessRepository();
    auto redeploymentOrderRepo = new MemoryRedeploymentOrderRepository();
    auto maintenanceTaskRepo = new MemoryMaintenanceTaskRepository();
    auto budgetTriggerRepo = new MemoryBudgetTriggerRepository();
    auto offlineSyncRecordRepo = new MemoryOfflineSyncRecordRepository();

    container.manageMissionPlans = new ManageMissionPlansUseCase(missionPlanRepo);
    container.manageExercises = new ManageExercisesUseCase(exerciseRepo);
    container.manageContingents = new ManageContingentsUseCase(contingentRepo);
    container.manageReadiness = new ManageReadinessUseCase(readinessRepo);
    container.manageRedeploymentOrders = new ManageRedeploymentOrdersUseCase(redeploymentOrderRepo);
    container.manageMaintenanceTasks = new ManageMaintenanceTasksUseCase(maintenanceTaskRepo);
    container.manageBudgetTriggers = new ManageBudgetTriggersUseCase(budgetTriggerRepo);
    container.manageOfflineSyncRecords = new ManageOfflineSyncRecordsUseCase(offlineSyncRecordRepo);

    container.missionPlanController = new MissionPlanController(container.manageMissionPlans);
    container.exerciseController = new ExerciseController(container.manageExercises);
    container.contingentController = new ContingentController(container.manageContingents);
    container.readinessController = new ReadinessController(container.manageReadiness);
    container.redeploymentOrderController = new RedeploymentOrderController(container.manageRedeploymentOrders);
    container.maintenanceTaskController = new MaintenanceTaskController(container.manageMaintenanceTasks);
    container.budgetTriggerController = new BudgetTriggerController(container.manageBudgetTriggers);
    container.offlineSyncRecordController = new OfflineSyncRecordController(container.manageOfflineSyncRecords);
    container.healthController = new HealthController();

    return container;
}
