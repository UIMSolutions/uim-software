module uim.platform.ecm.application.usecases.query.query_documents;

import std.string : indexOf, toLower;
import uim.platform.ecm.domain.entities.ecm_object : EcmObject, BusinessObjectType;
import uim.platform.ecm.domain.repositories.ecm_repository : EcmRepository;

@safe:

class QueryDocumentsUseCase {
    private EcmRepository repository;

    this(EcmRepository repository) {
        this.repository = repository;
    }

    EcmObject[] search(string query) {
        auto candidates = repository.listByType(BusinessObjectType.document);
        auto q = query.toLower();

        EcmObject[] result;
        foreach (item; candidates) {
            if (item.name.toLower().indexOf(q) >= 0 ||
                item.title.toLower().indexOf(q) >= 0 ||
                item.description.toLower().indexOf(q) >= 0) {
                result ~= item;
            }
        }
        return result;
    }
}
