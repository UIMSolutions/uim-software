module uim.platform.maif.application.usecases.manage.manage_integration_flows;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.maif;

@safe:

class ManageIntegrationFlowsUseCase {
    private IntegrationFlowRepository repo;

    this(IntegrationFlowRepository repo) {
        this.repo = repo;
    }

    IntegrationFlow[] list() {
        return repo.list();
    }

    const(IntegrationFlow)* get_(string id) {
        return repo.get_(id);
    }

    CommandResult create(IntegrationFlowDTO dto) {
        IntegrationFlow value;
        value.id = dto.id.length ? dto.id : createCode("FLOW");
        value.tenantId = dto.tenantId;
        value.appId = dto.appId;
        value.name = dto.name;
        value.sourceSystem = dto.sourceSystem;
        value.targetSystem = dto.targetSystem;
        value.protocol = dto.protocol;
        value.mappingPolicy = dto.mappingPolicy;
        value.retryPolicy = dto.retryPolicy;
        value.status = dto.status.length ? dto.status : "active";
        value.createdBy = dto.createdBy;
        value.createdAt = Clock.currTime().toISOExtString();

        if (!MaifValidator.isValidIntegrationFlow(value)) {
            return CommandResult(false, "", "Flow appId and name are required");
        }

        if (!repo.create(value)) {
            return CommandResult(false, "", "Integration flow already exists");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(IntegrationFlowDTO dto) {
        auto current = repo.get_(dto.id);
        if (current is null) {
            return CommandResult(false, "", "Integration flow not found");
        }

        IntegrationFlow value = *current;
        if (dto.appId.length) value.appId = dto.appId;
        if (dto.name.length) value.name = dto.name;
        if (dto.sourceSystem.length) value.sourceSystem = dto.sourceSystem;
        if (dto.targetSystem.length) value.targetSystem = dto.targetSystem;
        if (dto.protocol.length) value.protocol = dto.protocol;
        if (dto.mappingPolicy.length) value.mappingPolicy = dto.mappingPolicy;
        if (dto.retryPolicy.length) value.retryPolicy = dto.retryPolicy;
        if (dto.status.length) value.status = dto.status;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!repo.update(value)) {
            return CommandResult(false, "", "Integration flow not found");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult remove(string id) {
        if (!repo.remove(id)) {
            return CommandResult(false, "", "Integration flow not found");
        }
        return CommandResult(true, id, "");
    }

    private static string createCode(string prefix) {
        return prefix ~ "-" ~ to!string(Clock.currTime().toUnixTime());
    }
}
