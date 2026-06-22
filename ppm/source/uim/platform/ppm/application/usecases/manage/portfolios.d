module uim.platform.ppm.application.usecases.manage.portfolios;

import uim.platform.ppm;

@safe:

class ManagePortfoliosUseCase : UIMUseCase {
    private PortfolioRepository repo;

    this(PortfolioRepository repo) { this.repo = repo; }

    Portfolio[] list() { return repo.findAll(); }
    Portfolio* get_(PortfolioId id) { return repo.findById(id); }

    CommandResult create(PortfolioDTO dto) {
        Portfolio value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.name = dto.name;
        value.description = dto.description;
        value.strategicTheme = dto.strategicTheme;
        value.status = dto.status.length ? dto.status : value.status;
        value.planningHorizon = dto.planningHorizon;
        value.owner = dto.owner;
        value.budgetAmount = dto.budgetAmount;
        value.currency = dto.currency;
        value.createdBy = dto.createdBy;
        if (!PpmValidator.isValidPortfolio(value)) return CommandResult(false, "", "Invalid portfolio data");
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(PortfolioDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Portfolio not found");
        if (dto.name.length) existing.name = dto.name;
        if (dto.description.length) existing.description = dto.description;
        if (dto.strategicTheme.length) existing.strategicTheme = dto.strategicTheme;
        if (dto.status.length) existing.status = dto.status;
        if (dto.planningHorizon.length) existing.planningHorizon = dto.planningHorizon;
        if (dto.owner.length) existing.owner = dto.owner;
        if (dto.budgetAmount.length) existing.budgetAmount = dto.budgetAmount;
        if (dto.currency.length) existing.currency = dto.currency;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(PortfolioId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Portfolio not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
