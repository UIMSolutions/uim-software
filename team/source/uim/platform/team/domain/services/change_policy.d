module uim.platform.team.domain.services.change_policy;

import std.conv : to;
import std.string : toLower;
import uim.platform.team.domain;

@safe:

struct ChangePolicy {
    static PartLifecycleState parsePartLifecycleState(string value, PartLifecycleState fallback = PartLifecycleState.inWork) {
        switch (toLower(value)) {
            case "inwork":
            case "in_work":
            case "in-work":
                return PartLifecycleState.inWork;
            case "released":
                return PartLifecycleState.released;
            case "obsolete":
                return PartLifecycleState.obsolete;
            default:
                return fallback;
        }
    }

    static DocumentType parseDocumentType(string value, DocumentType fallback = DocumentType.specification) {
        switch (toLower(value)) {
            case "cad": return DocumentType.cad;
            case "specification": return DocumentType.specification;
            case "testreport":
            case "test_report":
            case "test-report":
                return DocumentType.testReport;
            case "qualityrecord":
            case "quality_record":
            case "quality-record":
                return DocumentType.qualityRecord;
            case "workinstruction":
            case "work_instruction":
            case "work-instruction":
                return DocumentType.workInstruction;
            default:
                return fallback;
        }
    }

    static ChangeState parseChangeState(string value, ChangeState fallback = ChangeState.draft) {
        switch (toLower(value)) {
            case "draft": return ChangeState.draft;
            case "submitted": return ChangeState.submitted;
            case "approved": return ChangeState.approved;
            case "implemented": return ChangeState.implemented;
            case "rejected": return ChangeState.rejected;
            default:
                return fallback;
        }
    }

    static Severity parseSeverity(string value, Severity fallback = Severity.medium) {
        switch (toLower(value)) {
            case "low": return Severity.low;
            case "medium": return Severity.medium;
            case "high": return Severity.high;
            case "critical": return Severity.critical;
            default:
                return fallback;
        }
    }

    static bool canTransition(ChangeState fromState, ChangeState toState) {
        if (fromState == toState) return true;

        final switch (fromState) {
            case ChangeState.draft:
                return toState == ChangeState.submitted || toState == ChangeState.rejected;
            case ChangeState.submitted:
                return toState == ChangeState.approved || toState == ChangeState.rejected;
            case ChangeState.approved:
                return toState == ChangeState.implemented || toState == ChangeState.rejected;
            case ChangeState.implemented:
                return false;
            case ChangeState.rejected:
                return false;
        }
    }

    static long computeImpactScore(Severity severity, size_t affectedParts, size_t affectedDocuments) {
        long severityWeight;
        final switch (severity) {
            case Severity.low: severityWeight = 10; break;
            case Severity.medium: severityWeight = 30; break;
            case Severity.high: severityWeight = 60; break;
            case Severity.critical: severityWeight = 90; break;
        }

        return severityWeight + cast(long)(affectedParts * 5) + cast(long)(affectedDocuments * 3);
    }

    static string enumToString(T)(T value) {
        return to!string(value);
    }
}
