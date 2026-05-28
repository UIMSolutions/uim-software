module uim.platform.mrp.infrastructure.persistence.memory.procurement_proposals;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class MemoryProcurementProposalRepository : ProcurementProposalRepository {
    private ProcurementProposal[] store;

    ProcurementProposal[] findAll() { return store; }

    ProcurementProposal* findById(ProcurementProposalId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    ProcurementProposal[] findByTenant(TenantId tenantId) {
        ProcurementProposal[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    ProcurementProposal[] findByRun(MrpRunId mrpRunId) {
        ProcurementProposal[] result;
        foreach (ref e; store)
            if (e.mrpRunId == mrpRunId) result ~= e;
        return result;
    }

    ProcurementProposal[] findByMaterial(MaterialId materialId) {
        ProcurementProposal[] result;
        foreach (ref e; store)
            if (e.materialId == materialId) result ~= e;
        return result;
    }

    ProcurementProposal[] findByStatus(ProposalStatus status) {
        ProcurementProposal[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    void save(ProcurementProposal proposal) { store ~= proposal; }

    void update(ProcurementProposal proposal) {
        foreach (ref e; store)
            if (e.id == proposal.id) { e = proposal; return; }
    }

    void remove(ProcurementProposalId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
