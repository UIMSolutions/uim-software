module uim.platform.defemse.domain.repositories.contingent_repository;

import uim.platform.defemse.domain.entities.contingent;
import uim.platform.defemse.domain.types;

@safe:

interface ContingentRepository {
    Contingent[] findAll();
    Contingent* findById(ContingentId id);
    void save(Contingent contingent);
    void update(Contingent contingent);
    void remove(ContingentId id);
}