module uim.platform.bn_supply_chain.application.usecases.supply_chain_service;

import uim.platform.bn_supply_chain.domain.entities.supply_chain_entities;
import uim.platform.bn_supply_chain.domain.repositories.supply_chain_repository;

class SupplyChainService {
    private SupplyChainRepository repository;

    this(SupplyChainRepository repository) {
        this.repository = repository;
    }

    Partner[] listPartners() {
        return repository.listPartners();
    }

    PurchaseOrder[] listOrders() {
        return repository.listOrders();
    }

    Shipment[] listShipments() {
        return repository.listShipments();
    }

    ShipNotice[] listShipNotices() {
        return repository.listShipNotices();
    }

    Invoice[] listInvoices() {
        return repository.listInvoices();
    }

    Alert[] listAlerts() {
        return repository.listAlerts();
    }
}
