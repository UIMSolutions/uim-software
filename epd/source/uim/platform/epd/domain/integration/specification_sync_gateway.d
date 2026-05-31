module uim.platform.epd.domain.integration.specification_sync_gateway;

import uim.platform.epd.domain.entities.specification;
import uim.platform.epd.domain.integration.types;

@safe:

interface SpecificationSyncGateway {
    IntegrationResult sync(Specification value);
}
