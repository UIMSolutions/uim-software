module uim.platform.etd.application.usecases.manage.manage_detection_rules;

import std.datetime : Clock;
import std.conv : to;
import uim.platform.etd;

@safe:

class ManageDetectionRulesUseCase {
    private DetectionRuleRepository repo;

    this(DetectionRuleRepository repo) {
        this.repo = repo;
    }

    DetectionRule[] list() {
        return repo.list();
    }

    const(DetectionRule)* get_(string id) {
        return repo.get_(id);
    }

    CommandResult create(DetectionRuleDTO dto) {
        DetectionRule value;
        value.id = dto.id.length ? dto.id : createCode("RULE");
        value.tenantId = dto.tenantId;
        value.name = dto.name;
        value.description = dto.description;
        value.queryPattern = dto.queryPattern;
        value.severity = dto.severity;
        value.schedule = dto.schedule;
        value.status = dto.status.length ? dto.status : "enabled";
        value.mitreTactic = dto.mitreTactic;
        value.mitreTechnique = dto.mitreTechnique;
        value.createdBy = dto.createdBy;
        value.createdAt = Clock.currTime().toISOExtString();

        if (!EtdValidator.isValidDetectionRule(value)) {
            return CommandResult(false, "", "Detection rule name and query pattern are required");
        }

        if (!repo.create(value)) {
            return CommandResult(false, "", "Detection rule already exists");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(DetectionRuleDTO dto) {
        auto current = repo.get_(dto.id);
        if (current is null) {
            return CommandResult(false, "", "Detection rule not found");
        }

        DetectionRule value = *current;
        if (dto.name.length) value.name = dto.name;
        if (dto.description.length) value.description = dto.description;
        if (dto.queryPattern.length) value.queryPattern = dto.queryPattern;
        if (dto.severity.length) value.severity = dto.severity;
        if (dto.schedule.length) value.schedule = dto.schedule;
        if (dto.status.length) value.status = dto.status;
        if (dto.mitreTactic.length) value.mitreTactic = dto.mitreTactic;
        if (dto.mitreTechnique.length) value.mitreTechnique = dto.mitreTechnique;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!repo.update(value)) {
            return CommandResult(false, "", "Detection rule not found");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult remove(string id) {
        if (!repo.remove(id)) {
            return CommandResult(false, "", "Detection rule not found");
        }
        return CommandResult(true, id, "");
    }

    private static string createCode(string prefix) {
        auto ts = Clock.currTime().toUnixTime();
        return prefix ~ "-" ~ to!string(ts);
    }
}
