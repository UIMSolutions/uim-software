module uim.platform.defemse.application.usecases.manage.defemse_feature_tests;

import std.conv : to;
import uim.platform.defemse;

@safe unittest {
    auto repo = new MemoryMaintenanceTaskRepository();
    auto uc = new ManageMaintenanceTasksUseCase(repo);

    MaintenanceTaskDTO dto;
    dto.id = "MT-1";
    dto.tenantId = "T1";
    dto.contingentId = "C1";
    dto.equipmentId = "EQ-1";
    dto.taskType = "inspection";
    dto.priority = "high";
    dto.dueAt = "2026-05-31";
    dto.status = "planned";
    dto.locationId = "L1";
    dto.createdBy = "u1";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll().length == 1);
    assert(repo.findAll()[0].taskType == "inspection");
}

@safe unittest {
    auto repo = new MemoryBudgetTriggerRepository();
    auto uc = new ManageBudgetTriggersUseCase(repo);

    BudgetTriggerDTO dto;
    dto.id = "BT-1";
    dto.tenantId = "T1";
    dto.missionPlanId = "MP-1";
    dto.sourceProcess = "mission-planning";
    dto.amount = "12500";
    dto.currency = "USD";
    dto.triggerReason = "exercise replenishment";
    dto.status = "requested";
    dto.createdBy = "u1";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll().length == 1);
    assert(repo.findAll()[0].currency == "USD");
}

@safe unittest {
    auto repo = new MemoryOfflineSyncRecordRepository();
    auto uc = new ManageOfflineSyncRecordsUseCase(repo);

    OfflineSyncRecordDTO dto;
    dto.id = "OS-1";
    dto.tenantId = "T1";
    dto.recordType = "mission-plan";
    dto.recordId = "MP-1";
    dto.action = "upsert";
    dto.payload = "{}";
    dto.status = "pending";
    dto.createdBy = "u1";

    auto result = uc.create(dto);
    assert(result.success);
    assert(repo.findAll().length == 1);
    assert(repo.findAll()[0].recordType == "mission-plan");
}