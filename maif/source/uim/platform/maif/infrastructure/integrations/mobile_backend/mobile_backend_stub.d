module uim.platform.maif.infrastructure.integrations.mobile_backend.mobile_backend_stub;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.maif;

@safe:

class MobileBackendStubGateway : MobileBackendGateway {
    override CommandResult publishMobileApp(MobileApp app) {
        if (!app.id.length) {
            return CommandResult(false, "", "Mobile app id is required");
        }

        auto publishTicket = "MBP-" ~ to!string(Clock.currTime().toUnixTime());
        return CommandResult(true, publishTicket, "Mobile app publish accepted");
    }
}
