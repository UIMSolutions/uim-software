module uim.platform.bn_supply_chain;

public import uim.platform.bn_supply_chain.domain;
public import uim.platform.bn_supply_chain.application;
public import uim.platform.bn_supply_chain.infrastructure;
public import uim.platform.bn_supply_chain.presentation;

struct SupplyChainConfig {
    string host = "0.0.0.0";
    ushort port = 8081;
}

SupplyChainConfig loadConfig() {
    return SupplyChainConfig();
}

struct SupplyChainContainer {
    HealthController healthController;
    SupplyChainApiController apiController;
}

SupplyChainContainer buildContainer(SupplyChainConfig config) {
    auto repo = new MemorySupplyChainRepository();
    auto service = new SupplyChainService(repo);
    auto healthController = new HealthController();
    auto apiController = new SupplyChainApiController(service);
    return SupplyChainContainer(healthController, apiController);
}
