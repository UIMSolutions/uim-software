module uim.platform.ibp.application.usecases.integration.ibp_integrations;

import uim.platform.ibp;

@safe:

class RunIbpIntegrationsUseCase : UIMUseCase {
    private ProductRepository productRepo;
    private SpecificationRepository specificationRepo;
    private ProductHandoverGateway productHandoverGateway;
    private SpecificationSyncGateway specificationSyncGateway;

    this(
        ProductRepository productRepo,
        SpecificationRepository specificationRepo,
        ProductHandoverGateway productHandoverGateway,
        SpecificationSyncGateway specificationSyncGateway
    ) {
        this.productRepo = productRepo;
        this.specificationRepo = specificationRepo;
        this.productHandoverGateway = productHandoverGateway;
        this.specificationSyncGateway = specificationSyncGateway;
    }

    CommandResult handoverProduct(ProductId id) {
        auto product = productRepo.findById(id);
        if (product is null) return CommandResult(false, "", "Demand plan not found");

        auto result = productHandoverGateway.handover(*product);
        if (!result.success) return CommandResult(false, "", result.message);
        return CommandResult(true, result.externalId, result.message);
    }

    CommandResult syncSpecification(SpecificationId id) {
        auto specification = specificationRepo.findById(id);
        if (specification is null) return CommandResult(false, "", "Scenario simulation not found");

        auto result = specificationSyncGateway.sync(*specification);
        if (!result.success) return CommandResult(false, "", result.message);
        return CommandResult(true, result.externalId, result.message);
    }
}
