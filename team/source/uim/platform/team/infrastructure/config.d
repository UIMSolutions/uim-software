module uim.platform.team.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8150;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("TEAM_HOST", "0.0.0.0");
    config.port = environment.get("TEAM_PORT", "8150").to!ushort;
    return config;
}
