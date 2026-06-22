module uim.platform.mii.domain.integration.specification_sync_gateway;

import uim.platform.mii.domain.entities.specification;
import uim.platform.mii.domain.integration.types;

@safe:

interface SpecificationSyncGateway {
    IntegrationResult sync(Specification value);
}
