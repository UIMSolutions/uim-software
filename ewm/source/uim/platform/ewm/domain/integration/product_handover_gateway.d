module uim.platform.ewm.domain.integration.product_handover_gateway;

import uim.platform.ewm.domain.entities.product;
import uim.platform.ewm.domain.integration.types;

@safe:

interface ProductHandoverGateway {
    IntegrationResult handover(Product value);
}
