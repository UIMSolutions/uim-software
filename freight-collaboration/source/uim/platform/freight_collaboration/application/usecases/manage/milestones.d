module uim.platform.freight_collaboration.application.usecases.manage.milestones;

import uim.platform.freight_collaboration;

@safe:

class ManageMilestonesUseCase : UIMUseCase {
    private MilestoneUpdateRepository repo;

    this(MilestoneUpdateRepository repo) {
        this.repo = repo;
    }

    MilestoneUpdate[] list() {
        return repo.findAll();
    }

    MilestoneUpdate* get_(MilestoneId id) {
        return repo.findById(id);
    }

    CommandResult create(MilestoneUpdateDTO dto) {
        MilestoneUpdate value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.freightOrderId = dto.freightOrderId;
        value.milestoneType = dto.milestoneType;
        value.eventTime = dto.eventTime;
        value.location = dto.location;
        value.statusComment = dto.statusComment;
        value.reportedBy = dto.reportedBy;
        value.createdBy = dto.createdBy;

        if (!FreightCollaborationValidator.isValidMilestone(value)) {
            return CommandResult(false, "", "Invalid milestone data");
        }

        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(MilestoneUpdateDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "Milestone not found");
        }

        if (dto.freightOrderId.length) existing.freightOrderId = dto.freightOrderId;
        if (dto.milestoneType.length) existing.milestoneType = dto.milestoneType;
        if (dto.eventTime.length) existing.eventTime = dto.eventTime;
        if (dto.location.length) existing.location = dto.location;
        if (dto.statusComment.length) existing.statusComment = dto.statusComment;
        if (dto.reportedBy.length) existing.reportedBy = dto.reportedBy;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MilestoneId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "Milestone not found");
        }

        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
