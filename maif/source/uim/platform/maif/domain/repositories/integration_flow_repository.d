module uim.platform.maif.domain.repositories.integration_flow_repository;

import uim.platform.maif.domain.entities.integration_flow;

@safe:

interface IntegrationFlowRepository {
    IntegrationFlow[] list();
    const(IntegrationFlow)* get_(string id);
    bool create(IntegrationFlow value);
    bool update(IntegrationFlow value);
    bool remove(string id);
}
