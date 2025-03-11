package com.xoa.service.censor;

import com.xoa.model.censor.CensorData;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

/**
 * 敏感词语待审核
 */
public interface CensorDataService {

    ToJson<CensorData> addCensorData(HttpServletRequest request, CensorData censorData);
    ToJson<CensorData> delCensorData(HttpServletRequest request,Integer id);
    ToJson<CensorData> updateCensorData(HttpServletRequest request,CensorData censorData);
    ToJson<CensorData> getCensorDataInforById(HttpServletRequest request,Integer id);
    ToJson<CensorData> getCensorData(Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request, CensorData censorData);
}
