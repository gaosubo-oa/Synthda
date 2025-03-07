package com.xoa.service.portalArticle;



import com.xoa.model.portalArticle.PortalArticleWithBLOBs;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;


public interface PortalArticleService {

    ToJson<PortalArticleWithBLOBs> selectPortalArticle(PortalArticleWithBLOBs portalArticleWithBLOBs);
    ToJson selectPortalArticleById(Integer articleId);
    ToJson<PortalArticleWithBLOBs> insertPortalArticle(PortalArticleWithBLOBs portalArticleWithBLOBs, HttpServletRequest httpServletRequest);
    ToJson<PortalArticleWithBLOBs> upPortalArticle(PortalArticleWithBLOBs portalArticleWithBLOBs);
    ToJson<PortalArticleWithBLOBs> delPortalArticle(Integer[] ids);
    ToJson articleTree(String id, Integer[] colIds);

}