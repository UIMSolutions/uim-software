/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ecc.domain.repositories.documents;

import uim.platform.ecc.domain.entities.document;
import uim.platform.ecc.domain.types;

@safe:

interface DocumentRepository {
    Document[] findAll();
    Document* findById(DocumentId id);
    void save(Document value);
    void update(Document value);
    void remove(DocumentId id);
}