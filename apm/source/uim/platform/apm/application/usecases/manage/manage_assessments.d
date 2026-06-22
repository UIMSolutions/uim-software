module uim.platform.apm.application.usecases.manage.manage_assessments;

import std.conv : to;
import uim.platform.apm;

@safe:

class ManageAssessmentsUseCase : UIMUseCase {
    private AssessmentRepository assessmentRepo;
    private PortfolioItemRepository portfolioItemRepo;

    this(AssessmentRepository assessmentRepo, PortfolioItemRepository portfolioItemRepo) {
        this.assessmentRepo = assessmentRepo;
        this.portfolioItemRepo = portfolioItemRepo;
    }

    ApplicationAssessment[] list() { return assessmentRepo.findAll(); }

    ApplicationAssessment[] listByTenant(TenantId tenantId) {
        if (tenantId.length == 0) return assessmentRepo.findAll();
        return assessmentRepo.findByTenant(tenantId);
    }

    ApplicationAssessment* get_(AssessmentId id) { return assessmentRepo.findById(id); }

    CommandResult create(AssessmentDTO dto) {
        auto app = portfolioItemRepo.findById(dto.applicationId);
        if (app is null)
            return CommandResult(false, "", "Application not found");

        ApplicationAssessment assessment;
        assessment.id = dto.id.length > 0 ? dto.id : "assessment-" ~ to!string(assessmentRepo.findAll().length + 1);
        assessment.tenantId = dto.tenantId;
        assessment.applicationId = dto.applicationId;
        assessment.assessmentDate = dto.assessmentDate;
        assessment.assessor = dto.assessor;
        assessment.functionalFit = AssessmentPolicy.parseFitBand(dto.functionalFit);
        assessment.technicalFit = AssessmentPolicy.parseFitBand(dto.technicalFit);
        assessment.businessValue = AssessmentPolicy.parseFitBand(dto.businessValue);
        assessment.dataQuality = AssessmentPolicy.parseFitBand(dto.dataQuality);
        assessment.overallScore = AssessmentPolicy.computeOverallScore(
            assessment.functionalFit,
            assessment.technicalFit,
            assessment.businessValue,
            assessment.dataQuality
        );
        assessment.recommendation = AssessmentPolicy.recommend(
            assessment.functionalFit,
            assessment.technicalFit,
            app.businessCriticality
        );
        assessment.riskNotes = dto.riskNotes;
        assessment.nextReviewDate = dto.nextReviewDate;
        assessment.createdBy = dto.createdBy;
        assessment.modifiedBy = dto.modifiedBy;
        assessment.createdAt = dto.createdAt;
        assessment.modifiedAt = dto.modifiedAt;

        assessmentRepo.save(assessment);
        return CommandResult(true, assessment.id, "");
    }

    CommandResult update(AssessmentDTO dto) {
        auto existing = assessmentRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Assessment not found");

        auto app = portfolioItemRepo.findById(existing.applicationId);
        if (app is null)
            return CommandResult(false, "", "Application not found");

        if (dto.assessmentDate.length > 0) existing.assessmentDate = dto.assessmentDate;
        if (dto.assessor.length > 0) existing.assessor = dto.assessor;
        if (dto.functionalFit.length > 0)
            existing.functionalFit = AssessmentPolicy.parseFitBand(dto.functionalFit, existing.functionalFit);
        if (dto.technicalFit.length > 0)
            existing.technicalFit = AssessmentPolicy.parseFitBand(dto.technicalFit, existing.technicalFit);
        if (dto.businessValue.length > 0)
            existing.businessValue = AssessmentPolicy.parseFitBand(dto.businessValue, existing.businessValue);
        if (dto.dataQuality.length > 0)
            existing.dataQuality = AssessmentPolicy.parseFitBand(dto.dataQuality, existing.dataQuality);
        if (dto.riskNotes.length > 0) existing.riskNotes = dto.riskNotes;
        if (dto.nextReviewDate.length > 0) existing.nextReviewDate = dto.nextReviewDate;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;

        existing.overallScore = AssessmentPolicy.computeOverallScore(
            existing.functionalFit,
            existing.technicalFit,
            existing.businessValue,
            existing.dataQuality
        );
        existing.recommendation = AssessmentPolicy.recommend(
            existing.functionalFit,
            existing.technicalFit,
            app.businessCriticality
        );

        assessmentRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(AssessmentId id) {
        if (assessmentRepo.findById(id) is null)
            return CommandResult(false, "", "Assessment not found");
        assessmentRepo.remove(id);
        return CommandResult(true, id, "");
    }
}
