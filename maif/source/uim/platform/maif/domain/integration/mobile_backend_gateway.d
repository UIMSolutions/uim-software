module uim.platform.maif.domain.integration.mobile_backend_gateway;

import uim.platform.maif.application.dto : CommandResult;
import uim.platform.maif.domain.entities.mobile_app : MobileApp;

@safe:

interface MobileBackendGateway {
    CommandResult publishMobileApp(MobileApp app);
}
