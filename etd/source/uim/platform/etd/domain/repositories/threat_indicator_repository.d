module uim.platform.etd.domain.repositories.threat_indicator_repository;

import uim.platform.etd.domain.entities.threat_indicator;

@safe:

interface ThreatIndicatorRepository {
    ThreatIndicator[] list();
    const(ThreatIndicator)* get_(string id);
    bool create(ThreatIndicator item);
    bool update(ThreatIndicator item);
    bool remove(string id);
}
