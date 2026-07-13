module uim.platform.freight_collaboration.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8140;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("FREIGHT_COLLAB_HOST", "0.0.0.0");
    config.port = environment.get("FREIGHT_COLLAB_PORT", "8140").to!ushort;
    return config;
}
