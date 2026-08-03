module uim.platform.bn_supply_chain.domain.entities.supply_chain_entities;

struct Partner {
    string id;
    string name;
    string role;
    string status;
}

struct PurchaseOrder {
    string id;
    string partnerId;
    string status;
    string[] lines;
}

struct Shipment {
    string id;
    string orderId;
    string carrier;
    string status;
}

struct ShipNotice {
    string id;
    string shipmentId;
    string status;
}

struct Invoice {
    string id;
    string orderId;
    string amount;
    string status;
}

struct Alert {
    string id;
    string severity;
    string message;
}
