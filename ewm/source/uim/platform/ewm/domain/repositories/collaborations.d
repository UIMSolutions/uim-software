/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ewm.domain.repositories.collaborations;

import uim.platform.ewm.domain.entities.collaboration;
import uim.platform.ewm.domain.types;

@safe:

interface CollaborationRepository {
    Collaboration[] findAll();
    Collaboration* findById(CollaborationId id);
    void save(Collaboration value);
    void update(Collaboration value);
    void remove(CollaborationId id);
}