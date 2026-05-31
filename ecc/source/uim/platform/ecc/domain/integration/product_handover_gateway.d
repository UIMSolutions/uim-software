module uim.platform.ecc.domain.integration.product_handover_gateway;

import uim.platform.ecc.domain.entities.product;
import uim.platform.ecc.domain.integration.types;

@safe:

interface ProductHandoverGateway {
    IntegrationResult handover(Product value);
}
