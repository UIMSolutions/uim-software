module uim.platform.ewm.domain.integration.specification_sync_gateway;

import uim.platform.ewm.domain.entities.specification;
import uim.platform.ewm.domain.integration.types;

@safe:

interface SpecificationSyncGateway {
    IntegrationResult sync(Specification value);
}
