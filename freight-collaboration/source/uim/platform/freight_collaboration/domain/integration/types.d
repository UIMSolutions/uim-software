module uim.platform.freight_collaboration.domain.integration.types;

@safe:

struct IntegrationResult {
    bool success;
    string externalId;
    string message;
}
