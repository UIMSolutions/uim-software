module uim.platform.bn_supply_chain.tests.supply_chain_service_tests;

import uim.platform.bn_supply_chain.application.usecases.supply_chain_service;
import uim.platform.bn_supply_chain.infrastructure.persistence.memory.memory_supply_chain_repository;

unittest {
    auto repo = new MemorySupplyChainRepository();
    auto service = new SupplyChainService(repo);

    assert(service.listPartners().length == 1);
    assert(service.listOrders().length == 1);
    assert(service.listShipments().length == 1);
    assert(service.listShipNotices().length == 1);
    assert(service.listInvoices().length == 1);
    assert(service.listAlerts().length == 1);
}
