module uim.platform.workflow.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8148;
    string storage = "memory";
    string storagePath = ".data/workflow";
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("WORKFLOW_HOST", "0.0.0.0");
    config.port = environment.get("WORKFLOW_PORT", "8148").to!ushort;
    config.storage = environment.get("WORKFLOW_STORAGE", "memory");
    config.storagePath = environment.get("WORKFLOW_STORAGE_PATH", ".data/workflow");
    return config;
}
