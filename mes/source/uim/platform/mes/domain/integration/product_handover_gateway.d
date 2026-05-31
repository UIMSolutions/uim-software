module uim.platform.mes.domain.integration.product_handover_gateway;

import uim.platform.mes.domain.entities.product;
import uim.platform.mes.domain.integration.types;

@safe:

interface ProductHandoverGateway {
    IntegrationResult handover(Product value);
}
