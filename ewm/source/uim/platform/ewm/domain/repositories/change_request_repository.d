/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ewm.domain.repositories.change_requests;

import uim.platform.ewm.domain.entities.change_request;
import uim.platform.ewm.domain.types;

@safe:

interface ChangeRequestRepository {
    ChangeRequest[] findAll();
    ChangeRequest* findById(ChangeRequestId id);
    void save(ChangeRequest value);
    void update(ChangeRequest value);
    void remove(ChangeRequestId id);
}