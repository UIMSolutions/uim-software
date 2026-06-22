module uim.platform.apm.application.usecases.manage.manage_portfolio_items;

import std.conv : to;
import uim.platform.apm;

@safe:

class ManagePortfolioItemsUseCase : UIMUseCase {
    private PortfolioItemRepository repo;

    this(PortfolioItemRepository repo) {
        this.repo = repo;
    }

    ApplicationPortfolioItem[] list() { return repo.findAll(); }

    ApplicationPortfolioItem[] listByTenant(TenantId tenantId) {
        if (tenantId.length == 0) return repo.findAll();
        return repo.findByTenant(tenantId);
    }

    ApplicationPortfolioItem* get_(PortfolioItemId id) { return repo.findById(id); }

    CommandResult create(PortfolioItemDTO dto) {
        if (dto.name.length == 0)
            return CommandResult(false, "", "Name is required");

        ApplicationPortfolioItem item;
        item.id = dto.id.length > 0 ? dto.id : "app-" ~ to!string(repo.findAll().length + 1);
        item.tenantId = dto.tenantId;
        item.name = dto.name;
        item.description = dto.description;
        item.businessCapability = dto.businessCapability;
        item.organization = dto.organization;
        item.lifecyclePhase = parseLifecyclePhase(dto.lifecyclePhase);
        item.businessCriticality = AssessmentPolicy.parseBusinessCriticality(dto.businessCriticality);
        item.annualCostUsd = dto.annualCostUsd;
        item.owner = dto.owner;
        item.createdBy = dto.createdBy;
        item.modifiedBy = dto.modifiedBy;
        item.createdAt = dto.createdAt;
        item.modifiedAt = dto.modifiedAt;

        repo.save(item);
        return CommandResult(true, item.id, "");
    }

    CommandResult update(PortfolioItemDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Application not found");

        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.businessCapability.length > 0) existing.businessCapability = dto.businessCapability;
        if (dto.organization.length > 0) existing.organization = dto.organization;
        if (dto.lifecyclePhase.length > 0) existing.lifecyclePhase = parseLifecyclePhase(dto.lifecyclePhase);
        if (dto.businessCriticality.length > 0)
            existing.businessCriticality = AssessmentPolicy.parseBusinessCriticality(dto.businessCriticality, existing.businessCriticality);
        if (dto.annualCostUsd.length > 0) existing.annualCostUsd = dto.annualCostUsd;
        if (dto.owner.length > 0) existing.owner = dto.owner;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(PortfolioItemId id) {
        if (repo.findById(id) is null)
            return CommandResult(false, "", "Application not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }

    private LifecyclePhase parseLifecyclePhase(string value) {
        import std.string : toLower;
        switch (toLower(value)) {
            case "invest": return LifecyclePhase.invest;
            case "maintain": return LifecyclePhase.maintain;
            case "phaseout":
            case "phase_out":
            case "phase-out":
                return LifecyclePhase.phaseOut;
            case "eliminate":
                return LifecyclePhase.eliminate;
            default:
                return LifecyclePhase.maintain;
        }
    }
}
