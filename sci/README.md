# SAP Cloud Infrastructure Service (SCI)

A microservice implementing features similar to SAP Cloud Infrastructure (SCI) - an infrastructure-as-a-service (IaaS) offering providing virtual compute, storage, networking, identity, key management, and operational services. SCI follows a self-service model managed via APIs and a web-based user interface.

Built with D (dlang) and vibe.d using a combination of clean and hexagonal architecture patterns.

Based on the feature description from [SAP Cloud Infrastructure - Wikipedia](https://en.wikipedia.org/wiki/SAP_Cloud_Infrastructure).

## Features

- **Compute (Instances)** - Virtual machine instances provisioned from OS images in predefined flavors (general, compute, memory, storage, GPU, high-performance); lifecycle operations (create/modify/resize/delete), power control, snapshots, and server group placement policies
- **Block Storage (Volumes)** - Persistent virtual volumes with attach/detach to instances, online expansion, cloning, snapshots, and provisioning from images or snapshots; supports standard, SSD, high-IOPS, and archive volume types
- **Networking (Networks)** - Software-defined networking (SDN) for tenant networks, subnets, and routers; supports tenant, provider, and external network types with CIDR, gateway, and DNS nameserver configuration
- **Security Groups** - Network security controls with ingress/egress rules, protocol filtering (TCP/UDP/ICMP), port ranges, remote IP prefix matching, and ether type configuration
- **Floating IPs** - Public IP address management for instance reachability; associate/disassociate floating IPs with instances and routers
- **Load Balancing** - Managed load balancers for distributing traffic across backend instances; supports round-robin, least-connections, and source-IP algorithms with health monitoring
- **DNS (DNS Zones)** - Authoritative DNS service (DNSaaS) with API-based management of DNS zones and records; supports A, AAAA, CNAME, MX, TXT, NS, SRV, PTR record types with zone sharing/transfer across projects
- **Key Pairs** - SSH and X.509 key pair management for secure instance access; supports key generation, import, and credential lifecycle management

## Architecture

```
source/
  uim/platform/sci/
    domain/           # Entities, repository interfaces, domain services
    application/      # DTOs, use cases
    infrastructure/   # Config, container (DI), in-memory persistence
    presentation/     # HTTP controllers, JSON serialization
```

### Layers

| Layer | Responsibility |
|-------|---------------|
| **Domain** | Instance, Volume, Network, SecurityGroup, FloatingIp, LoadBalancer, DnsZone, KeyPair entities; repository interfaces; ResourceValidator |
| **Application** | InstanceDTO/VolumeDTO/etc.; ManageInstances/ManageVolumes/etc. use cases |
| **Infrastructure** | AppConfig (port 8110); Container (DI wiring); Memory repositories |
| **Presentation** | REST controllers; JSON serialization helpers |

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/v1/sci/instances` | List compute instances |
| POST | `/api/v1/sci/instances` | Create instance |
| GET | `/api/v1/sci/instances/:id` | Get instance by ID |
| PUT | `/api/v1/sci/instances/:id` | Update instance |
| DELETE | `/api/v1/sci/instances/:id` | Delete instance |
| GET | `/api/v1/sci/volumes` | List block storage volumes |
| POST | `/api/v1/sci/volumes` | Create volume |
| GET | `/api/v1/sci/volumes/:id` | Get volume by ID |
| PUT | `/api/v1/sci/volumes/:id` | Update volume |
| DELETE | `/api/v1/sci/volumes/:id` | Delete volume |
| GET | `/api/v1/sci/networks` | List networks |
| POST | `/api/v1/sci/networks` | Create network |
| GET | `/api/v1/sci/networks/:id` | Get network by ID |
| PUT | `/api/v1/sci/networks/:id` | Update network |
| DELETE | `/api/v1/sci/networks/:id` | Delete network |
| GET | `/api/v1/sci/security-groups` | List security groups |
| POST | `/api/v1/sci/security-groups` | Create security group |
| GET | `/api/v1/sci/security-groups/:id` | Get security group by ID |
| PUT | `/api/v1/sci/security-groups/:id` | Update security group |
| DELETE | `/api/v1/sci/security-groups/:id` | Delete security group |
| GET | `/api/v1/sci/floating-ips` | List floating IPs |
| POST | `/api/v1/sci/floating-ips` | Create floating IP |
| GET | `/api/v1/sci/floating-ips/:id` | Get floating IP by ID |
| PUT | `/api/v1/sci/floating-ips/:id` | Update floating IP |
| DELETE | `/api/v1/sci/floating-ips/:id` | Delete floating IP |
| GET | `/api/v1/sci/load-balancers` | List load balancers |
| POST | `/api/v1/sci/load-balancers` | Create load balancer |
| GET | `/api/v1/sci/load-balancers/:id` | Get load balancer by ID |
| PUT | `/api/v1/sci/load-balancers/:id` | Update load balancer |
| DELETE | `/api/v1/sci/load-balancers/:id` | Delete load balancer |
| GET | `/api/v1/sci/dns-zones` | List DNS zones |
| POST | `/api/v1/sci/dns-zones` | Create DNS zone |
| GET | `/api/v1/sci/dns-zones/:id` | Get DNS zone by ID |
| PUT | `/api/v1/sci/dns-zones/:id` | Update DNS zone |
| DELETE | `/api/v1/sci/dns-zones/:id` | Delete DNS zone |
| GET | `/api/v1/sci/key-pairs` | List key pairs |
| POST | `/api/v1/sci/key-pairs` | Create key pair |
| GET | `/api/v1/sci/key-pairs/:id` | Get key pair by ID |
| PUT | `/api/v1/sci/key-pairs/:id` | Update key pair |
| DELETE | `/api/v1/sci/key-pairs/:id` | Delete key pair |
| GET | `/health` | Health check |

All POST/PUT requests require `X-Tenant-Id` header for tenant isolation.

## Configuration

| Environment Variable | Default | Description |
|---------------------|---------|-------------|
| `SCI_HOST` | `0.0.0.0` | HTTP listen address |
| `SCI_PORT` | `8110` | HTTP listen port |

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
docker build -t uim-platform/sci:latest .

# Run container
docker run -p 8110:8110 uim-platform/sci:latest
```

## Kubernetes

```bash
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

## Technology Foundation

Inspired by SAP Cloud Infrastructure which is based on open-source cloud infrastructure frameworks (OpenStack, Kubernetes) without dependencies on hyperscaler technologies. This implementation provides a self-contained IaaS management layer covering the core SCI service domains:

- **Compute** - VM lifecycle management with flavor-based sizing
- **Storage** - Block storage with encryption and snapshot support
- **Networking** - SDN with tenant isolation, security groups, and floating IPs
- **Load Balancing and DNS** - Traffic distribution and authoritative DNS management
- **Identity and Key Management** - Key pair management for secure access

## License

Apache-2.0
