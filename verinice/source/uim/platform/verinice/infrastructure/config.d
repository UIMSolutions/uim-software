module uim.platform.verinice.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8139;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("VERINICE_HOST", "0.0.0.0");
    config.port = environment.get("VERINICE_PORT", "8139").to!ushort;
    return config;
}
