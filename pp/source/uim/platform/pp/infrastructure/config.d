module uim.platform.pp.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8191;
    string webRoot = "web";
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("PP_HOST", "0.0.0.0");
    config.port = environment.get("PP_PORT", "8191").to!ushort;
    config.webRoot = environment.get("PP_WEB_ROOT", "web");
    return config;
}
