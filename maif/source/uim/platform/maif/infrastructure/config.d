module uim.platform.maif.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8176;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("MAIF_HOST", "0.0.0.0");
    config.port = environment.get("MAIF_PORT", "8176").to!ushort;
    return config;
}
