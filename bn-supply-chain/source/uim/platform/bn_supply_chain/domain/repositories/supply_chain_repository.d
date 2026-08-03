module uim.platform.bn_supply_chain.domain.repositories.supply_chain_repository;

import uim.platform.bn_supply_chain.domain.entities.supply_chain_entities;

interface SupplyChainRepository {
    Partner[] listPartners();
    PurchaseOrder[] listOrders();
    Shipment[] listShipments();
    ShipNotice[] listShipNotices();
    Invoice[] listInvoices();
    Alert[] listAlerts();
}
