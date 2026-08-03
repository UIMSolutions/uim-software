module uim.platform.npc.infrastructure.config;

import std.conv : to;
import std.process : environment;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8490;
    string webRoot = "web";
    string repositoryEngine = "memory";
    string postgresUrl = "postgresql://localhost:5432/npc";
    string mongoUrl = "mongodb://localhost:27017";
    string mongoDatabase = "npc";
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("NPC_HOST", "0.0.0.0");
    config.port = environment.get("NPC_PORT", "8490").to!ushort;
    config.webRoot = environment.get("NPC_WEB_ROOT", "web");
    config.repositoryEngine = environment.get("NPC_REPOSITORY", "memory");
    config.postgresUrl = environment.get("NPC_POSTGRES_URL", "postgresql://localhost:5432/npc");
    config.mongoUrl = environment.get("NPC_MONGO_URL", "mongodb://localhost:27017");
    config.mongoDatabase = environment.get("NPC_MONGO_DATABASE", "npc");
    return config;
}
