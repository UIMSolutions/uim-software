module uim.platform.verinice.domain.repositories.safeguard_repository;

import uim.platform.verinice.domain.entities.safeguard;
import uim.platform.verinice.domain.types;

@safe:

interface SafeguardRepository {
    Safeguard[] findAll();
    Safeguard* findById(SafeguardId id);
    void save(Safeguard value);
    void update(Safeguard value);
    void remove(SafeguardId id);
}
