module uim.platform.mrp.domain.repositories.procurement_proposal_repository;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

interface ProcurementProposalRepository {
    ProcurementProposal[] findAll();
    ProcurementProposal* findById(ProcurementProposalId id);
    ProcurementProposal[] findByTenant(TenantId tenantId);
    ProcurementProposal[] findByRun(MrpRunId mrpRunId);
    ProcurementProposal[] findByMaterial(MaterialId materialId);
    ProcurementProposal[] findByStatus(ProposalStatus status);
    void save(ProcurementProposal proposal);
    void update(ProcurementProposal proposal);
    void remove(ProcurementProposalId id);
}
