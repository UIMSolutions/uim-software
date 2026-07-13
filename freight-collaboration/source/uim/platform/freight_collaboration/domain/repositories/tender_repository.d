module uim.platform.freight_collaboration.domain.repositories.tender_repository;

import uim.platform.freight_collaboration.domain.entities.tender;
import uim.platform.freight_collaboration.domain.types;

@safe:

interface TenderRepository {
    Tender[] findAll();
    Tender* findById(TenderId id);
    void save(Tender value);
    void update(Tender value);
    void remove(TenderId id);
}
