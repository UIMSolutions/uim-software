module uim.platform.maif.domain.services.maif_validator;

import uim.platform.maif.domain.entities.mobile_app : MobileApp;
import uim.platform.maif.domain.entities.integration_flow : IntegrationFlow;
import uim.platform.maif.domain.entities.sync_job : SyncJob;

@safe:

struct MaifValidator {
    static bool isValidMobileApp(MobileApp value) {
        return value.name.length > 0 && value.platform.length > 0;
    }

    static bool isValidIntegrationFlow(IntegrationFlow value) {
        return value.appId.length > 0 && value.name.length > 0;
    }

    static bool isValidSyncJob(SyncJob value) {
        return value.flowId.length > 0 && value.triggerType.length > 0;
    }
}
