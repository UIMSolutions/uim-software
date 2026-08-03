module uim.platform.bn_supply_chain.infrastructure.persistence.memory.memory_supply_chain_repository;

import uim.platform.bn_supply_chain.domain.entities.supply_chain_entities;
import uim.platform.bn_supply_chain.domain.repositories.supply_chain_repository;

class MemorySupplyChainRepository : SupplyChainRepository {
    private Partner[] partners;
    private PurchaseOrder[] orders;
    private Shipment[] shipments;
    private ShipNotice[] shipNotices;
    private Invoice[] invoices;
    private Alert[] alerts;

    this() {
        partners = [Partner("P-100", "Contoso", "Supplier", "Active")];
        orders = [PurchaseOrder("O-100", "P-100", "Confirmed", ["Widget A", "Widget B"] )];
        shipments = [Shipment("S-100", "O-100", "DHL", "In Transit")];
        shipNotices = [ShipNotice("SN-100", "S-100", "Sent")];
        invoices = [Invoice("I-100", "O-100", "1250.00", "Open")];
        alerts = [Alert("A-100", "High", "Delivery delay detected")];
    }

    override Partner[] listPartners() { return partners; }
    override PurchaseOrder[] listOrders() { return orders; }
    override Shipment[] listShipments() { return shipments; }
    override ShipNotice[] listShipNotices() { return shipNotices; }
    override Invoice[] listInvoices() { return invoices; }
    override Alert[] listAlerts() { return alerts; }
}
