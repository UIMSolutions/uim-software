module uim.platform.mrp.application.usecases.manage.manage_procurement_proposals;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class ManageProcurementProposalsUseCase : UIMUseCase {
    private ProcurementProposalRepository repo;

    this(ProcurementProposalRepository repo) {
        this.repo = repo;
    }

    ProcurementProposal* get_(ProcurementProposalId id) { return repo.findById(id); }
    ProcurementProposal[] list() { return repo.findAll(); }
    ProcurementProposal[] listByRun(MrpRunId runId) { return repo.findByRun(runId); }

    CommandResult create(ProcurementProposalDTO dto) {
        ProcurementProposal p;
        p.id = dto.id;
        p.tenantId = dto.tenantId;
        p.mrpRunId = dto.mrpRunId;
        p.plantId = dto.plantId;
        p.materialId = dto.materialId;
        p.proposalType = parseEnumValue!ProposalType(dto.proposalType, ProposalType.plannedOrder);
        p.status = parseEnumValue!ProposalStatus(dto.status, ProposalStatus.created);
        p.quantity = dto.quantity;
        p.dueDate = dto.dueDate;
        p.source = dto.source;
        p.exceptionMessage = dto.exceptionMessage;
        p.createdBy = dto.createdBy;

        if (!MRPValidator.isValidProcurementProposal(p))
            return CommandResult(false, "", "Invalid procurement proposal data");

        repo.save(p);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(ProcurementProposalDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Procurement proposal not found");

        if (dto.quantity.length > 0) existing.quantity = dto.quantity;
        if (dto.dueDate.length > 0) existing.dueDate = dto.dueDate;
        if (dto.source.length > 0) existing.source = dto.source;
        if (dto.exceptionMessage.length > 0) existing.exceptionMessage = dto.exceptionMessage;
        if (dto.proposalType.length > 0)
            existing.proposalType = parseEnumValue!ProposalType(
                dto.proposalType,
                existing.proposalType
            );
        if (dto.status.length > 0) existing.status = parseEnumValue!ProposalStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ProcurementProposalId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Procurement proposal not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }

    private static T parseEnumValue(T)(string raw, T fallback) {
        import std.conv : to;

        if (raw.length == 0) {
            return fallback;
        }

        try {
            return raw.to!T;
        } catch (Exception e) {
            return fallback;
        }
    }
}
