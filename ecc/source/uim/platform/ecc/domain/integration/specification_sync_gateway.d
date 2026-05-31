module uim.platform.ecc.domain.integration.specification_sync_gateway;

import uim.platform.ecc.domain.entities.specification;
import uim.platform.ecc.domain.integration.types;

@safe:

interface SpecificationSyncGateway {
    IntegrationResult sync(Specification value);
}
