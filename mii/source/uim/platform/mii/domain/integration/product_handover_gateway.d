module uim.platform.mii.domain.integration.product_handover_gateway;

import uim.platform.mii.domain.entities.product;
import uim.platform.mii.domain.integration.types;

@safe:

interface ProductHandoverGateway {
    IntegrationResult handover(Product value);
}
