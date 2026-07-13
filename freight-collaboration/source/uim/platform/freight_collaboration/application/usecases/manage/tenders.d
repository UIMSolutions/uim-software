module uim.platform.freight_collaboration.application.usecases.manage.tenders;

import uim.platform.freight_collaboration;

@safe:

class ManageTendersUseCase : UIMUseCase {
    private TenderRepository repo;

    this(TenderRepository repo) {
        this.repo = repo;
    }

    Tender[] list() {
        return repo.findAll();
    }

    Tender* get_(TenderId id) {
        return repo.findById(id);
    }

    CommandResult create(TenderDTO dto) {
        Tender value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.freightOrderId = dto.freightOrderId;
        value.tenderNumber = dto.tenderNumber;
        value.status = dto.status.length ? dto.status : value.status;
        value.offeredRate = dto.offeredRate;
        value.currency = dto.currency;
        value.responseBy = dto.responseBy;
        value.awardedCarrierId = dto.awardedCarrierId;
        value.createdBy = dto.createdBy;

        if (!FreightCollaborationValidator.isValidTender(value)) {
            return CommandResult(false, "", "Invalid tender data");
        }

        repo.save(value);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(TenderDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "Tender not found");
        }

        if (dto.freightOrderId.length) existing.freightOrderId = dto.freightOrderId;
        if (dto.tenderNumber.length) existing.tenderNumber = dto.tenderNumber;
        if (dto.status.length) existing.status = dto.status;
        if (dto.offeredRate.length) existing.offeredRate = dto.offeredRate;
        if (dto.currency.length) existing.currency = dto.currency;
        if (dto.responseBy.length) existing.responseBy = dto.responseBy;
        if (dto.awardedCarrierId.length) existing.awardedCarrierId = dto.awardedCarrierId;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        if (dto.modifiedAt.length) existing.modifiedAt = dto.modifiedAt;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(TenderId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "Tender not found");
        }

        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
