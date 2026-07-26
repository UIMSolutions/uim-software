module uim.platform.workflow.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8148;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("WORKFLOW_HOST", "0.0.0.0");
    config.port = environment.get("WORKFLOW_PORT", "8148").to!ushort;
    return config;
}
