package com.xoa.service.portalTemplate;


import com.xoa.model.portalTemplate.PortalTemplateWithBLOBs;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;


public interface PortalTemplateService {

    ToJson<PortalTemplateWithBLOBs> selectPortalTemplate(Integer portalId);
    ToJson<PortalTemplateWithBLOBs> selectPortalTemplateById(HttpServletRequest request,Integer templateId);
    ToJson<PortalTemplateWithBLOBs> insertPortalTemplate(HttpServletRequest request,PortalTemplateWithBLOBs portalTemplateWithBLOBs);
    ToJson<PortalTemplateWithBLOBs> upPortalTemplate(HttpServletRequest request,PortalTemplateWithBLOBs portalTemplateWithBLOBs);
    ToJson<PortalTemplateWithBLOBs> delPortalTemplate(HttpServletRequest request,PortalTemplateWithBLOBs portalTemplateWithBLOBs);
}