# Global Track and Trace Service (GTT)

A microservice implementing features similar to SAP Business Network Global Track and Trace (GTT) - a cloud-based solution for capturing, processing, and storing tracking information about business processes, providing real-time end-to-end visibility into shipment, delivery, and order fulfillment execution.

Built with D (dlang) and vibe.d using a combination of clean and hexagonal architecture patterns.

Based on the feature description from [SAP Business Network Global Track and Trace](https://help.sap.com/docs/business-network-global-track-and-trace?locale=en-US).

## Features

- **Shipment Tracking** - End-to-end shipment visibility for transportation planners; track freight orders, carrier assignments, departure/arrival events, estimated/actual times, transport mode (road, rail, ocean, air), and route waypoints
- **Delivery Monitoring** - Inbound ASN (Advanced Shipping Notice) monitoring for receiving specialists and outbound delivery tracking for shipping specialists; track delivery items, quantities, packaging, carrier references, and proof of delivery
- **Purchase Order Fulfillment** - PO fulfillment tracking for purchasers; monitor order confirmation, goods issue, in-transit status, goods receipt, and invoice verification across the procurement lifecycle
- **Sales Order Fulfillment** - SO fulfillment tracking for internal sales representatives; monitor order acceptance, picking, packing, shipment, delivery, and customer confirmation events
- **Tracking Events** - Capture and process real-time tracking events (location updates, status changes, milestone completions, exceptions, sensor readings) from carriers, logistics providers, and IoT devices via tracking APIs
- **Tracked Processes** - Define and monitor end-to-end tracked business processes spanning multiple documents and partners; correlate shipments, deliveries, and orders into unified process views with completion tracking
- **Location Management** - Manage locations (plants, warehouses, distribution centers, ports, terminals, customer sites) with geolocation, address, timezone, and location type; support location replication from source systems
- **Tracking Models** - Define GTT tracking models that specify tracked object types, expected event sequences, milestone definitions, and correlation rules; deploy models for process monitoring and exception detection

## Architecture

```
source/
  uim/platform/gtt/
    domain/           # Entities, repository interfaces, domain services
    application/      # DTOs, use cases
    infrastructure/   # Config, container (DI), in-memory persistence
    presentation/     # HTTP controllers, JSON serialization
```

### Layers

| Layer | Responsibility |
|-------|---------------|
| **Domain** | Shipment, Delivery, PurchaseOrder, SalesOrder, TrackingEvent, TrackedProcess, Location, TrackingModel entities; repository interfaces; TrackingValidator |
| **Application** | ShipmentDTO/DeliveryDTO/etc.; ManageShipments/ManageDeliveries/etc. use cases |
| **Infrastructure** | AppConfig (port 8115); Container (DI wiring); Memory repositories |
| **Presentation** | REST controllers; JSON serialization helpers |

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/gtt/shipments` | List shipments |
| POST | `/api/v1/gtt/shipments` | Create shipment |
| GET | `/api/v1/gtt/shipments/:id` | Get shipment by ID |
| PUT | `/api/v1/gtt/shipments/:id` | Update shipment |
| DELETE | `/api/v1/gtt/shipments/:id` | Delete shipment |
| GET | `/api/v1/gtt/deliveries` | List deliveries |
| POST | `/api/v1/gtt/deliveries` | Create delivery |
| GET | `/api/v1/gtt/deliveries/:id` | Get delivery by ID |
| PUT | `/api/v1/gtt/deliveries/:id` | Update delivery |
| DELETE | `/api/v1/gtt/deliveries/:id` | Delete delivery |
| GET | `/api/v1/gtt/purchase-orders` | List purchase orders |
| POST | `/api/v1/gtt/purchase-orders` | Create purchase order |
| GET | `/api/v1/gtt/purchase-orders/:id` | Get purchase order by ID |
| PUT | `/api/v1/gtt/purchase-orders/:id` | Update purchase order |
| DELETE | `/api/v1/gtt/purchase-orders/:id` | Delete purchase order |
| GET | `/api/v1/gtt/sales-orders` | List sales orders |
| POST | `/api/v1/gtt/sales-orders` | Create sales order |
| GET | `/api/v1/gtt/sales-orders/:id` | Get sales order by ID |
| PUT | `/api/v1/gtt/sales-orders/:id` | Update sales order |
| DELETE | `/api/v1/gtt/sales-orders/:id` | Delete sales order |
| GET | `/api/v1/gtt/tracking-events` | List tracking events |
| POST | `/api/v1/gtt/tracking-events` | Create tracking event |
| GET | `/api/v1/gtt/tracking-events/:id` | Get tracking event by ID |
| PUT | `/api/v1/gtt/tracking-events/:id` | Update tracking event |
| DELETE | `/api/v1/gtt/tracking-events/:id` | Delete tracking event |
| GET | `/api/v1/gtt/tracked-processes` | List tracked processes |
| POST | `/api/v1/gtt/tracked-processes` | Create tracked process |
| GET | `/api/v1/gtt/tracked-processes/:id` | Get tracked process by ID |
| PUT | `/api/v1/gtt/tracked-processes/:id` | Update tracked process |
| DELETE | `/api/v1/gtt/tracked-processes/:id` | Delete tracked process |
| GET | `/api/v1/gtt/locations` | List locations |
| POST | `/api/v1/gtt/locations` | Create location |
| GET | `/api/v1/gtt/locations/:id` | Get location by ID |
| PUT | `/api/v1/gtt/locations/:id` | Update location |
| DELETE | `/api/v1/gtt/locations/:id` | Delete location |
| GET | `/api/v1/gtt/tracking-models` | List tracking models |
| POST | `/api/v1/gtt/tracking-models` | Create tracking model |
| GET | `/api/v1/gtt/tracking-models/:id` | Get tracking model by ID |
| PUT | `/api/v1/gtt/tracking-models/:id` | Update tracking model |
| DELETE | `/api/v1/gtt/tracking-models/:id` | Delete tracking model |
| GET | `/health` | Health check |

All POST/PUT requests require `X-Tenant-Id` header for tenant isolation.

## Configuration

| Environment Variable | Default | Description |
|---------------------|---------|-------------|
| `GTT_HOST` | `0.0.0.0` | HTTP listen address |
| `GTT_PORT` | `8115` | HTTP listen port |

## Build and Run

```bash
# Build
dub build

# Run
dub run

# Test
dub test
```

## Docker

```bash
# Build image
docker build -t uim-platform/gtt:latest .

# Run container
docker run -p 8115:8115 uim-platform/gtt:latest
```

## Kubernetes

```bash
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

## Technology Foundation

Inspired by SAP Business Network Global Track and Trace which captures, processes, and stores tracking information about tracked business processes, enabling real-time transparency of execution from end to end. This implementation provides a self-contained track-and-trace management layer covering the core GTT service domains:

- **Shipment Tracking** - Carrier-level freight visibility with departure/arrival events
- **Delivery Monitoring** - Inbound ASN and outbound delivery lifecycle tracking
- **Order Fulfillment** - Purchase order and sales order end-to-end fulfillment tracking
- **Event Processing** - Real-time event capture from carriers, logistics providers, and IoT sources
- **Process Correlation** - Cross-document tracked process views with milestone monitoring
- **Location Network** - Plant, warehouse, port, and customer site management with geolocation
- **Model Administration** - Configurable tracking models with expected event sequences and exception rules

## License

Apache-2.0
