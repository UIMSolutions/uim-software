module uim.platform.etd.infrastructure.integrations.sap_etd.threat_intel_stub;

import std.datetime : Clock;
import uim.platform.etd;

@safe:

class SapThreatIntelStubGateway : ThreatIntelGateway {
    override CommandResult syncIndicator(ThreatIndicator indicator) {
        if (!indicator.id.length) {
            return CommandResult(false, "", "Indicator id is required");
        }

        auto externalId = "SAP-ETD-IOC-" ~ Clock.currTime().toUnixTime().to!string;
        return CommandResult(true, externalId, "Threat intel sync completed");
    }
}
