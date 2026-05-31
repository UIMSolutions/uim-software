module uim.platform.ibp.domain.integration.product_handover_gateway;

import uim.platform.ibp.domain.entities.product;
import uim.platform.ibp.domain.integration.types;

@safe:

interface ProductHandoverGateway {
    IntegrationResult handover(Product value);
}
