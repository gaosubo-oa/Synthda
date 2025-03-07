package com.xoa.service.censor;

import com.xoa.model.censor.CensorModule;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

/**
 * 敏感词语过滤模块设置
 */
public interface CensorModuleService {

    ToJson<CensorModule> addCensorModule(HttpServletRequest request, CensorModule censorModule);
    ToJson<CensorModule> delCensorModule(HttpServletRequest request,Integer moduleId);
    ToJson<CensorModule> updateCensorModule(HttpServletRequest request,CensorModule censorModule);
    ToJson<CensorModule> getCensorModuleInforById(HttpServletRequest request,Integer moduleId);
    ToJson<CensorModule> getCensorModule(Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request, CensorModule censorModule);
}
