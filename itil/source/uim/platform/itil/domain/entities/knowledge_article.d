/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.entities.knowledge_article;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct KnowledgeArticle {
    KnowledgeArticleId id;
    TenantId tenantId;
    string title;
    string body_;
    KnowledgeStatus knowledgeStatus = KnowledgeStatus.draft;
    string category;
    ITServiceId serviceId;
    string author;
    string reviewer;
    string publishedDate;
    string reviewDate;
    long viewCount = 0;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
