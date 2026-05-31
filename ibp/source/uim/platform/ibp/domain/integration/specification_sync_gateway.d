module uim.platform.ibp.domain.integration.specification_sync_gateway;

import uim.platform.ibp.domain.entities.specification;
import uim.platform.ibp.domain.integration.types;

@safe:

interface SpecificationSyncGateway {
    IntegrationResult sync(Specification value);
}
