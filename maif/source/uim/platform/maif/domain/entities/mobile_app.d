module uim.platform.maif.domain.entities.mobile_app;

@safe:

struct MobileApp {
    string id;
    string tenantId;
    string name;
    string description;
    string platform;
    string versionTag;
    string status;
    string owner;
    string backendSystem;
    string authProfile;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
