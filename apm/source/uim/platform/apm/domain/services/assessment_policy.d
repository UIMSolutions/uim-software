module uim.platform.apm.domain.services.assessment_policy;

import std.string : toLower;
import uim.platform.apm.domain;

@safe:

struct AssessmentPolicy {
    static FitBand parseFitBand(string value, FitBand fallback = FitBand.moderate) {
        switch (toLower(value)) {
            case "poor": return FitBand.poor;
            case "moderate": return FitBand.moderate;
            case "good": return FitBand.good;
            case "excellent": return FitBand.excellent;
            default: return fallback;
        }
    }

    static BusinessCriticality parseBusinessCriticality(string value, BusinessCriticality fallback = BusinessCriticality.medium) {
        switch (toLower(value)) {
            case "low": return BusinessCriticality.low;
            case "medium": return BusinessCriticality.medium;
            case "high": return BusinessCriticality.high;
            case "missioncritical":
            case "mission_critical":
            case "mission-critical":
                return BusinessCriticality.missionCritical;
            default:
                return fallback;
        }
    }

    static long score(FitBand fit) {
        final switch (fit) {
            case FitBand.poor: return 25;
            case FitBand.moderate: return 50;
            case FitBand.good: return 75;
            case FitBand.excellent: return 100;
        }
    }

    static Recommendation recommend(FitBand functionalFit, FitBand technicalFit, BusinessCriticality criticality) {
        if (functionalFit == FitBand.poor && technicalFit == FitBand.poor)
            return Recommendation.eliminate;

        if (technicalFit == FitBand.poor && criticality >= BusinessCriticality.high)
            return Recommendation.migrate;

        if (technicalFit >= FitBand.good && functionalFit >= FitBand.good)
            return Recommendation.invest;

        if (functionalFit == FitBand.poor)
            return Recommendation.migrate;

        return Recommendation.tolerate;
    }

    static long computeOverallScore(FitBand functionalFit, FitBand technicalFit, FitBand businessValue, FitBand dataQuality) {
        auto weighted =
            score(functionalFit) * 35 +
            score(technicalFit) * 35 +
            score(businessValue) * 20 +
            score(dataQuality) * 10;
        return weighted / 100;
    }
}
