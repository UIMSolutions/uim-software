module uim.platform.defemse.application.usecases.manage.budget_triggers;

import std.conv : to;
import uim.platform.defemse;

@safe:

class ManageBudgetTriggersUseCase : UIMUseCase {
    private BudgetTriggerRepository repo;

    this(BudgetTriggerRepository repo) {
        this.repo = repo;
    }

    BudgetTrigger[] list() {
        return repo.findAll();
    }

    BudgetTrigger* get_(BudgetTriggerId id) {
        return repo.findById(id);
    }

    CommandResult create(BudgetTriggerDTO dto) {
        BudgetTrigger value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.missionPlanId = dto.missionPlanId;
        value.sourceProcess = dto.sourceProcess;
        value.amount = dto.amount;
        value.currency = dto.currency;
        value.triggerReason = dto.triggerReason;
        if (dto.status.length > 0) value.status = dto.status.to!BudgetTriggerStatus;
        value.createdBy = dto.createdBy;
        if (!DefemseValidator.isValidBudgetTrigger(value))
            return CommandResult(false, "", "Invalid budget trigger data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(BudgetTriggerDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Budget trigger not found");
        if (dto.missionPlanId.length > 0) existing.missionPlanId = dto.missionPlanId;
        if (dto.sourceProcess.length > 0) existing.sourceProcess = dto.sourceProcess;
        if (dto.amount.length > 0) existing.amount = dto.amount;
        if (dto.currency.length > 0) existing.currency = dto.currency;
        if (dto.triggerReason.length > 0) existing.triggerReason = dto.triggerReason;
        if (dto.status.length > 0) existing.status = dto.status.to!BudgetTriggerStatus;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(BudgetTriggerId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Budget trigger not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}