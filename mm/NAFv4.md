# NAFv4 Mapping

## Business Architecture

- Capability: material master governance
- Capability: purchasing operations
- Capability: inventory and goods movement control
- Capability: supplier coordination

## Application Architecture

- Service style: modular monolith microservice
- Interface style: REST over HTTP with JSON payloads
- Client: embedded browser client for demo and testing

## Data Architecture

- Canonical business objects are kept inside the domain layer.
- Repository interfaces define persistence ports.
- Current adapters are in-memory and replaceable.

## Technology Architecture

- Language: D
- Framework: vibe.d
- Architectural style: Clean plus Hexagonal
- Test strategy: unit tests at application orchestration level