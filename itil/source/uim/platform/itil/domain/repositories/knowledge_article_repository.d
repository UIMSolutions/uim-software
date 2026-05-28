/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.repositories.knowledge_article_repository;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

interface KnowledgeArticleRepository {
    KnowledgeArticle[] findAll();
    KnowledgeArticle* findById(KnowledgeArticleId id);
    KnowledgeArticle[] findByTenant(TenantId tenantId);
    KnowledgeArticle[] findByStatus(KnowledgeStatus knowledgeStatus);
    KnowledgeArticle[] findByService(ITServiceId serviceId);
    KnowledgeArticle[] findByAuthor(string author);
    void save(KnowledgeArticle article);
    void update(KnowledgeArticle article);
    void remove(KnowledgeArticleId id);
}
