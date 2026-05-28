/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.persistence.memory.memory_knowledge_article_repository;

import uim.platform.itil;
import std.algorithm : filter;
import std.array : array;

mixin(ShowModule!());

@safe:

class MemoryKnowledgeArticleRepository : KnowledgeArticleRepository {
    private KnowledgeArticle[] store;

    KnowledgeArticle[] findAll() { return store.dup; }

    KnowledgeArticle* findById(KnowledgeArticleId id) {
        foreach (ref s; store) if (s.id == id) return &s;
        return null;
    }

    KnowledgeArticle[] findByTenant(TenantId tenantId) {
        return store.filter!(s => s.tenantId == tenantId).array;
    }

    KnowledgeArticle[] findByStatus(KnowledgeStatus knowledgeStatus) {
        return store.filter!(s => s.knowledgeStatus == knowledgeStatus).array;
    }

    KnowledgeArticle[] findByService(ITServiceId serviceId) {
        return store.filter!(s => s.serviceId == serviceId).array;
    }

    KnowledgeArticle[] findByAuthor(string author) {
        return store.filter!(s => s.author == author).array;
    }

    void save(KnowledgeArticle s) { store ~= s; }

    void update(KnowledgeArticle s) {
        foreach (ref item; store) {
            if (item.id == s.id) { item = s; return; }
        }
    }

    void remove(KnowledgeArticleId id) {
        store = store.filter!(s => s.id != id).array;
    }
}
