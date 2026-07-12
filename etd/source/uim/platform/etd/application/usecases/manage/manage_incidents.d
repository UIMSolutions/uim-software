module uim.platform.etd.application.usecases.manage.manage_incidents;

import std.datetime : Clock;
import uim.platform.etd;

@safe:

class ManageIncidentsUseCase {
    private IncidentRepository repo;

    this(IncidentRepository repo) {
        this.repo = repo;
    }

    Incident[] list() {
        return repo.list();
    }

    const(Incident)* get_(string id) {
        return repo.get_(id);
    }

    CommandResult create(IncidentDTO dto) {
        Incident value;
        value.id = dto.id.length ? dto.id : createCode("INC");
        value.tenantId = dto.tenantId;
        value.title = dto.title;
        value.description = dto.description;
        value.severity = dto.severity;
        value.status = dto.status.length ? dto.status : "new";
        value.category = dto.category;
        value.sourceSystem = dto.sourceSystem;
        value.detectedAt = dto.detectedAt;
        value.assignedTo = dto.assignedTo;
        value.containmentStatus = dto.containmentStatus;
        value.createdBy = dto.createdBy;
        value.createdAt = Clock.currTime().toISOExtString();

        if (!EtdValidator.isValidIncident(value)) {
            return CommandResult(false, "", "Incident title and severity are required");
        }

        if (!repo.create(value)) {
            return CommandResult(false, "", "Incident already exists");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(IncidentDTO dto) {
        auto current = repo.get_(dto.id);
        if (current is null) {
            return CommandResult(false, "", "Incident not found");
        }

        Incident value = *current;
        if (dto.title.length) value.title = dto.title;
        if (dto.description.length) value.description = dto.description;
        if (dto.severity.length) value.severity = dto.severity;
        if (dto.status.length) value.status = dto.status;
        if (dto.category.length) value.category = dto.category;
        if (dto.sourceSystem.length) value.sourceSystem = dto.sourceSystem;
        if (dto.detectedAt.length) value.detectedAt = dto.detectedAt;
        if (dto.assignedTo.length) value.assignedTo = dto.assignedTo;
        if (dto.containmentStatus.length) value.containmentStatus = dto.containmentStatus;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!repo.update(value)) {
            return CommandResult(false, "", "Incident not found");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult remove(string id) {
        if (!repo.remove(id)) {
            return CommandResult(false, "", "Incident not found");
        }
        return CommandResult(true, id, "");
    }

    private static string createCode(string prefix) {
        auto ts = Clock.currTime().toUnixTime();
        return prefix ~ "-" ~ ts.to!string;
    }
}
