module uim.platform.ppm.application.usecases.manage.demands;

import uim.platform.ppm;

@safe:

class ManageDemandsUseCase : UIMUseCase {
    private DemandRepository repo;

    this(DemandRepository repo) { this.repo = repo; }

    Demand[] list() { return repo.findAll(); }
    Demand* get_(DemandId id) { return repo.findById(id); }

    CommandResult create(DemandDTO dto) {
        Demand value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.portfolioId = dto.portfolioId;
        value.title = dto.title;
        value.description = dto.description;
        value.source = dto.source;
        value.businessValue = dto.businessValue;
        value.priority = dto.priority;
        value.status = dto.status.length ? dto.status : value.status;
        value.requestedBy = dto.requestedBy;
        value.createdBy = dto.createdBy;
        if (!PpmValidator.isValidDemand(value)) return CommandResult(false, "", "Invalid demand data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(DemandDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Demand not found");
        if (dto.portfolioId.length) existing.portfolioId = dto.portfolioId;
        if (dto.title.length) existing.title = dto.title;
        if (dto.description.length) existing.description = dto.description;
        if (dto.source.length) existing.source = dto.source;
        if (dto.businessValue.length) existing.businessValue = dto.businessValue;
        if (dto.priority.length) existing.priority = dto.priority;
        if (dto.status.length) existing.status = dto.status;
        if (dto.requestedBy.length) existing.requestedBy = dto.requestedBy;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(DemandId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Demand not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
