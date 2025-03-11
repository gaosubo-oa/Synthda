package com.xoa.service.censor.impl;

import com.xoa.dao.censor.CensorDataMapper;
import com.xoa.model.censor.CensorData;
import com.xoa.service.censor.CensorDataService;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CensorDataServiceImpl implements CensorDataService {
    @Resource
    private CensorDataMapper censorDataMapper;
    @Override
    public ToJson<CensorData> addCensorData(HttpServletRequest request, CensorData censorData) {
        ToJson<CensorData> toJson = new ToJson<>(1,"err");
        try {
            int a = censorDataMapper.addCensorData(censorData);
            if (a>0){
                toJson.setMsg("ok");
                toJson.setFlag(0);
            }else {
                toJson.setMsg("false");
                toJson.setFlag(1);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<CensorData> delCensorData(HttpServletRequest request, Integer id) {
        ToJson<CensorData> toJson = new ToJson<>(1,"err");
        try {
            if (id!=0){
                censorDataMapper.delCensorData(id);
            }
            toJson.setMsg("删除成功");
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<CensorData> updateCensorData(HttpServletRequest request, CensorData censorData) {
        ToJson<CensorData> toJson = new ToJson<>(1,"err");
        try {
            int a = censorDataMapper.updateCensorData(censorData);
            if (a>0){
                toJson.setMsg("修改成功");
                toJson.setFlag(0);
            }else {
                toJson.setMsg("修改失败");
                toJson.setFlag(1);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<CensorData> getCensorDataInforById(HttpServletRequest request, Integer id) {
        ToJson<CensorData> toJson = new ToJson<>(1,"err");
        try {
            CensorData censorData = censorDataMapper.getCensorDataInforById(id);
            if (censorData != null){
                toJson.setObject(censorData);
                toJson.setMsg("ok");
            }else {
                toJson.setMsg("NULL");
            }
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<CensorData> getCensorData(Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request, CensorData censorData) {
        ToJson<CensorData> toJson = new ToJson<>(1,"err");
        try {
            Map<String,Object> map = new HashMap<>();
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            map.put("page",pageParams);
            map.put("censorData",censorData);
            List<CensorData> list = censorDataMapper.getCensorData(map);
            if (list!=null && list.size()>0){
                toJson.setObj(list);
                toJson.setTotleNum(censorDataMapper.countNum());
                toJson.setMsg("ok");
            }else {
                toJson.setMsg("空数据");
            }
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }
}
