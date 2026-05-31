module uim.platform.ibp.domain.integration.types;

@safe:

struct IntegrationResult {
    bool success;
    string externalId;
    string message;
}
