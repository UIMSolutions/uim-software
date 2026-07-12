module uim.platform.etd.domain.repositories.incident_repository;

import uim.platform.etd.domain.entities.incident;

@safe:

interface IncidentRepository {
    Incident[] list();
    const(Incident)* get_(string id);
    bool create(Incident item);
    bool update(Incident item);
    bool remove(string id);
}
