module uim.platform.apm.domain.types;

@safe:

alias PortfolioItemId = string;
alias AssessmentId = string;
alias TenantId = string;

enum LifecyclePhase {
    invest,
    maintain,
    phaseOut,
    eliminate
}

enum BusinessCriticality {
    low,
    medium,
    high,
    missionCritical
}

enum FitBand {
    poor,
    moderate,
    good,
    excellent
}

enum Recommendation {
    invest,
    tolerate,
    migrate,
    eliminate
}
