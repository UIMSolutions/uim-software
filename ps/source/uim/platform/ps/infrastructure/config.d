module uim.platform.ps.infrastructure.config;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8121;
}

AppConfig loadConfig() {
    import std.process : environment;
    import std.conv : to;

    AppConfig config;
    config.host = environment.get("PS_HOST", "0.0.0.0");
    config.port = environment.get("PS_PORT", "8121").to!ushort;
    return config;
}
