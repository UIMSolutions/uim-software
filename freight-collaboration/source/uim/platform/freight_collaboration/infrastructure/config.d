module uim.platform.freight_collaboration.infrastructure.config;

import std.conv : to;
import std.process : environment;
import std.string : strip, toLower;

@safe:

struct AppConfig {
    string host = "0.0.0.0";
    ushort port = 8140;
    bool useStubIntegration = true;
    string sapBnBaseUrl;
    string sapBnTenderSyncPath = "/api/v1/freight-collaboration/tenders/sync";
    string sapBnApiToken;
}

AppConfig loadConfig() {
    AppConfig config;
    config.host = environment.get("FREIGHT_COLLAB_HOST", "0.0.0.0");
    config.port = environment.get("FREIGHT_COLLAB_PORT", "8140").to!ushort;
    config.useStubIntegration = parseBool(
        environment.get("FREIGHT_COLLAB_USE_STUB_INTEGRATION", "true"),
        true
    );
    config.sapBnBaseUrl = environment.get("FREIGHT_COLLAB_SAP_BN_BASE_URL", "");
    config.sapBnTenderSyncPath = environment.get(
        "FREIGHT_COLLAB_SAP_BN_TENDER_SYNC_PATH",
        "/api/v1/freight-collaboration/tenders/sync"
    );
    config.sapBnApiToken = environment.get("FREIGHT_COLLAB_SAP_BN_API_TOKEN", "");
    return config;
}

private bool parseBool(string raw, bool defaultValue) {
    auto value = toLower(strip(raw));
    if (value == "1" || value == "true" || value == "yes" || value == "on")
        return true;
    if (value == "0" || value == "false" || value == "no" || value == "off")
        return false;
    return defaultValue;
}
