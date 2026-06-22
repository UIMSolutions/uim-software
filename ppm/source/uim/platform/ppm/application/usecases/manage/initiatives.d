module uim.platform.ppm.application.usecases.manage.initiatives;

import uim.platform.ppm;

@safe:

class ManageInitiativesUseCase : UIMUseCase {
    private InitiativeRepository repo;

    this(InitiativeRepository repo) { this.repo = repo; }

    Initiative[] list() { return repo.findAll(); }
    Initiative* get_(InitiativeId id) { return repo.findById(id); }

    CommandResult create(InitiativeDTO dto) {
        Initiative value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.portfolioId = dto.portfolioId;
        value.title = dto.title;
        value.description = dto.description;
        value.category = dto.category;
        value.priority = dto.priority;
        value.status = dto.status.length ? dto.status : value.status;
        value.sponsor = dto.sponsor;
        value.expectedBenefits = dto.expectedBenefits;
        value.createdBy = dto.createdBy;
        if (!PpmValidator.isValidInitiative(value)) return CommandResult(false, "", "Invalid initiative data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(InitiativeDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Initiative not found");
        if (dto.portfolioId.length) existing.portfolioId = dto.portfolioId;
        if (dto.title.length) existing.title = dto.title;
        if (dto.description.length) existing.description = dto.description;
        if (dto.category.length) existing.category = dto.category;
        if (dto.priority.length) existing.priority = dto.priority;
        if (dto.status.length) existing.status = dto.status;
        if (dto.sponsor.length) existing.sponsor = dto.sponsor;
        if (dto.expectedBenefits.length) existing.expectedBenefits = dto.expectedBenefits;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(InitiativeId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Initiative not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
