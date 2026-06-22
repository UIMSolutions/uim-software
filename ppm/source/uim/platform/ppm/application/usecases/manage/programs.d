module uim.platform.ppm.application.usecases.manage.programs;

import uim.platform.ppm;

@safe:

class ManageProgramsUseCase : UIMUseCase {
    private ProgramRepository repo;

    this(ProgramRepository repo) { this.repo = repo; }

    Program[] list() { return repo.findAll(); }
    Program* get_(ProgramId id) { return repo.findById(id); }

    CommandResult create(ProgramDTO dto) {
        Program value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.portfolioId = dto.portfolioId;
        value.name = dto.name;
        value.objective = dto.objective;
        value.status = dto.status.length ? dto.status : value.status;
        value.manager = dto.manager;
        value.startDate = dto.startDate;
        value.endDate = dto.endDate;
        value.createdBy = dto.createdBy;
        if (!PpmValidator.isValidProgram(value)) return CommandResult(false, "", "Invalid program data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ProgramDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Program not found");
        if (dto.portfolioId.length) existing.portfolioId = dto.portfolioId;
        if (dto.name.length) existing.name = dto.name;
        if (dto.objective.length) existing.objective = dto.objective;
        if (dto.status.length) existing.status = dto.status;
        if (dto.manager.length) existing.manager = dto.manager;
        if (dto.startDate.length) existing.startDate = dto.startDate;
        if (dto.endDate.length) existing.endDate = dto.endDate;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ProgramId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Program not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
