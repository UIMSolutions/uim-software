module uim.platform.epd.domain.integration.product_handover_gateway;

import uim.platform.epd.domain.entities.product;
import uim.platform.epd.domain.integration.types;

@safe:

interface ProductHandoverGateway {
    IntegrationResult handover(Product value);
}
