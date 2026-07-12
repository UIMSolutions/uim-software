module uim.platform.etd.domain.integration.threat_intel_gateway;

import uim.platform.etd.application.dto : CommandResult;
import uim.platform.etd.domain.entities.threat_indicator : ThreatIndicator;

@safe:

interface ThreatIntelGateway {
    CommandResult syncIndicator(ThreatIndicator indicator);
}
