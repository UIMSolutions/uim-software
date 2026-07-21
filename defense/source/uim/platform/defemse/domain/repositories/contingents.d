module uim.platform.defense.domain.repositories.contingents;

import uim.platform.defense.domain.entities.contingent;
import uim.platform.defense.domain.types;

@safe:

interface ContingentRepository {
    Contingent[] findAll();
    Contingent* findById(ContingentId id);
    void save(Contingent contingent);
    void update(Contingent contingent);
    void remove(ContingentId id);
}