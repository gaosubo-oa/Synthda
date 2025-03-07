package com.xoa.service.casConfig;

import com.xoa.model.casConfig.CasConfig;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

public interface CasConfigService {

    ToJson save(HttpServletRequest request, CasConfig casConfig);


    ToJson showCas(HttpServletRequest request);
}
