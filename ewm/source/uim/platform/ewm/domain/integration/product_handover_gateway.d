/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ewm.domain.integration.product_handover_gateway;

import uim.platform.ewm.domain.entities.product;
import uim.platform.ewm.domain.integration.types;

@safe:

interface ProductHandoverGateway {
    IntegrationResult handover(Product value);
}
