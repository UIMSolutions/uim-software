module uim.platform.team.application.usecases.manage.analyze_plm;

import std.conv : to;
import uim.platform.team;

@safe:

class AnalyzePlmUseCase : UIMUseCase {
    private PartRepository partRepo;
    private BomRepository bomRepo;
    private DocumentRepository documentRepo;
    private ChangeRequestRepository changeRepo;

    this(PartRepository partRepo, BomRepository bomRepo, DocumentRepository documentRepo, ChangeRequestRepository changeRepo) {
        this.partRepo = partRepo;
        this.bomRepo = bomRepo;
        this.documentRepo = documentRepo;
        this.changeRepo = changeRepo;
    }

    ChangeImpactDTO[] changeImpact(TenantId tenantId = "") {
        auto changes = tenantId.length == 0 ? changeRepo.findAll() : changeRepo.findByTenant(tenantId);

        ChangeImpactDTO[] result;
        foreach (changeRequest; changes) {
            ChangeImpactDTO impact;
            impact.changeId = changeRequest.id;
            impact.changeNumber = changeRequest.changeNumber;
            impact.state = to!string(changeRequest.state);
            impact.severity = to!string(changeRequest.severity);
            impact.affectedParts = cast(long) changeRequest.affectedPartIds.length;
            impact.affectedDocuments = cast(long) changeRequest.affectedDocumentIds.length;
            impact.impactScore = ChangePolicy.computeImpactScore(
                changeRequest.severity,
                changeRequest.affectedPartIds.length,
                changeRequest.affectedDocumentIds.length
            );
            result ~= impact;
        }

        return result;
    }

    PlmSummaryDTO summary(TenantId tenantId = "") {
        PlmSummaryDTO summary;
        summary.totalParts = cast(long)((tenantId.length == 0) ? partRepo.findAll().length : partRepo.findByTenant(tenantId).length);
        summary.totalBoms = cast(long)((tenantId.length == 0) ? bomRepo.findAll().length : bomRepo.findByTenant(tenantId).length);
        summary.totalDocuments = cast(long)((tenantId.length == 0) ? documentRepo.findAll().length : documentRepo.findByTenant(tenantId).length);

        auto changes = tenantId.length == 0 ? changeRepo.findAll() : changeRepo.findByTenant(tenantId);
        summary.totalChanges = cast(long) changes.length;
        foreach (changeRequest; changes) {
            if (changeRequest.state != ChangeState.implemented && changeRequest.state != ChangeState.rejected)
                summary.openChanges++;
            if (changeRequest.severity == Severity.critical)
                summary.criticalChanges++;
        }

        return summary;
    }
}
