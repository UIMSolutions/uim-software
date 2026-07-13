module uim.platform.content.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8188;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("CONTENT_HOST", "0.0.0.0");
    config.port = environment.get("CONTENT_PORT", "8188").to!ushort;
    return config;
}
