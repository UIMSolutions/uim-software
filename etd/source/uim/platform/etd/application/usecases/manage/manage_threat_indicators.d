module uim.platform.etd.application.usecases.manage.manage_threat_indicators;

import std.datetime : Clock;
import std.conv : to;
import uim.platform.etd;

@safe:

class ManageThreatIndicatorsUseCase {
    private ThreatIndicatorRepository repo;

    this(ThreatIndicatorRepository repo) {
        this.repo = repo;
    }

    ThreatIndicator[] list() {
        return repo.list();
    }

    const(ThreatIndicator)* get_(string id) {
        return repo.get_(id);
    }

    CommandResult create(ThreatIndicatorDTO dto) {
        ThreatIndicator value;
        value.id = dto.id.length ? dto.id : createCode("IOC");
        value.tenantId = dto.tenantId;
        value.indicatorType = dto.indicatorType;
        value.indicatorValue = dto.indicatorValue;
        value.confidence = dto.confidence;
        value.severity = dto.severity;
        value.firstSeenAt = dto.firstSeenAt;
        value.lastSeenAt = dto.lastSeenAt;
        value.source = dto.source;
        value.status = dto.status.length ? dto.status : "active";
        value.enrichment = dto.enrichment;
        value.createdBy = dto.createdBy;
        value.createdAt = Clock.currTime().toISOExtString();

        if (!EtdValidator.isValidThreatIndicator(value)) {
            return CommandResult(false, "", "Indicator type and value are required");
        }

        if (!repo.create(value)) {
            return CommandResult(false, "", "Threat indicator already exists");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(ThreatIndicatorDTO dto) {
        auto current = repo.get_(dto.id);
        if (current is null) {
            return CommandResult(false, "", "Threat indicator not found");
        }

        ThreatIndicator value = *current;
        if (dto.indicatorType.length) value.indicatorType = dto.indicatorType;
        if (dto.indicatorValue.length) value.indicatorValue = dto.indicatorValue;
        if (dto.confidence.length) value.confidence = dto.confidence;
        if (dto.severity.length) value.severity = dto.severity;
        if (dto.firstSeenAt.length) value.firstSeenAt = dto.firstSeenAt;
        if (dto.lastSeenAt.length) value.lastSeenAt = dto.lastSeenAt;
        if (dto.source.length) value.source = dto.source;
        if (dto.status.length) value.status = dto.status;
        if (dto.enrichment.length) value.enrichment = dto.enrichment;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!repo.update(value)) {
            return CommandResult(false, "", "Threat indicator not found");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult remove(string id) {
        if (!repo.remove(id)) {
            return CommandResult(false, "", "Threat indicator not found");
        }
        return CommandResult(true, id, "");
    }

    private static string createCode(string prefix) {
        auto ts = Clock.currTime().toUnixTime();
        return prefix ~ "-" ~ to!string(ts);
    }
}
