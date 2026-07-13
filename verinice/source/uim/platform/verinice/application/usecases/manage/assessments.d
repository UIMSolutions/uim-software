module uim.platform.verinice.application.usecases.manage.assessments;

import uim.platform.verinice;

@safe:

class ManageAssessmentsUseCase : UIMUseCase {
    private AssessmentRepository repo;

    this(AssessmentRepository repo) {
        this.repo = repo;
    }

    Assessment[] list() {
        return repo.findAll();
    }

    Assessment* get_(AssessmentId id) {
        return repo.findById(id);
    }

    CommandResult create(AssessmentDTO dto) {
        Assessment value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.assetId = dto.assetId;
        value.safeguardId = dto.safeguardId;
        value.status = dto.status.length ? dto.status : value.status;
        value.riskLevel = dto.riskLevel;
        value.justification = dto.justification;
        value.reviewer = dto.reviewer;
        value.createdBy = dto.createdBy;
        if (!VeriniceValidator.isValidAssessment(value)) {
            return CommandResult(false, "", "Invalid assessment data");
        }
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(AssessmentDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "Assessment not found");
        }
        if (dto.assetId.length) existing.assetId = dto.assetId;
        if (dto.safeguardId.length) existing.safeguardId = dto.safeguardId;
        if (dto.status.length) existing.status = dto.status;
        if (dto.riskLevel.length) existing.riskLevel = dto.riskLevel;
        if (dto.justification.length) existing.justification = dto.justification;
        if (dto.reviewer.length) existing.reviewer = dto.reviewer;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(AssessmentId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "Assessment not found");
        }
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
