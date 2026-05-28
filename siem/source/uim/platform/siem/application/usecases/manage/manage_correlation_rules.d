/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.application.usecases.manage.manage_correlation_rules;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

class ManageCorrelationRulesUseCase : UIMUseCase {
    private CorrelationRuleRepository repo;

    this(CorrelationRuleRepository repo) {
        this.repo = repo;
    }

    CorrelationRule* get_(CorrelationRuleId id) {
        return repo.findById(id);
    }

    CorrelationRule[] list() {
        return repo.findAll();
    }

    CorrelationRule[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    CorrelationRule[] listByStatus(RuleStatus status) {
        return repo.findByStatus(status);
    }

    CorrelationRule[] listByType(RuleType ruleType) {
        return repo.findByType(ruleType);
    }

    CommandResult create(CorrelationRuleDTO dto) {
        CorrelationRule r;
        r.id = dto.id;
        r.tenantId = dto.tenantId;
        r.name = dto.name;
        r.description = dto.description;
        r.ruleExpression = dto.ruleExpression;
        r.conditionField = dto.conditionField;
        r.conditionOperator = dto.conditionOperator;
        r.conditionValue = dto.conditionValue;
        r.timeWindowSeconds = dto.timeWindowSeconds;
        r.threshold = dto.threshold;
        r.aggregationField = dto.aggregationField;
        r.severity = dto.severity;
        r.alertName = dto.alertName;
        r.mitreTactic = dto.mitreTactic;
        r.mitreTechnique = dto.mitreTechnique;
        r.author = dto.author;
        r.version_ = dto.version_;
        r.tags = dto.tags;
        r.createdBy = dto.createdBy;
        if (!SiemValidator.isValidCorrelationRule(r))
            return CommandResult(false, "", "Invalid correlation rule data");
        repo.save(r);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(CorrelationRuleDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Correlation rule not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.ruleExpression.length > 0) existing.ruleExpression = dto.ruleExpression;
        if (dto.status.length > 0) {
            import std.conv : to;
            existing.status = dto.status.to!RuleStatus;
        }
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(CorrelationRuleId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Correlation rule not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
