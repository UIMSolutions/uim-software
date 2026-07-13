module uim.platform.maif.domain.repositories.mobile_app_repository;

import uim.platform.maif.domain.entities.mobile_app;

@safe:

interface MobileAppRepository {
    MobileApp[] list();
    const(MobileApp)* get_(string id);
    bool create(MobileApp value);
    bool update(MobileApp value);
    bool remove(string id);
}
