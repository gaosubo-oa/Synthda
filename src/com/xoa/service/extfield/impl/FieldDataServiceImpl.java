package com.xoa.service.extfield.impl;

import com.alibaba.fastjson.JSONArray;
import com.xoa.dao.extfield.FieldDataMapper;
import com.xoa.model.extfield.FieldData;
import com.xoa.service.extfield.FieldDataService;
import com.xoa.util.ToJson;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FieldDataServiceImpl implements FieldDataService {
    @Resource
    private FieldDataMapper fieldDataMapper;

    @Override
    public ToJson<FieldData> updateFieldData(String tabName, String identyId, String strJson) {
        ToJson<FieldData> json = new ToJson<>(1, "error");
        try {
            if (!StringUtils.isEmpty(tabName) && !StringUtils.isEmpty(identyId) && !StringUtils.isEmpty(strJson)){
                List<FieldData> list = JSONArray.parseArray(strJson, FieldData.class);
                if (!CollectionUtils.isEmpty(list)){
                    //自定义字段如果启用 count为0
                    int count = 1;
                    for (FieldData fieldData : list){
                        if (fieldData != null && !StringUtils.isEmpty(fieldData.getFieldNo()) && !StringUtils.isEmpty(fieldData.getItemData())) {
                            //根据表名、字段编号、关联唯一ID，查询数据，如果没有则新加一条数据
                            Map<String, Object> map = new HashMap<>();
                            map.put("tabName", tabName);
                            map.put("fieldNo", fieldData.getFieldNo());
                            map.put("identyId", identyId);
                            FieldData fData = fieldDataMapper.selectFieldData(map);
                            fieldData.setTabName(tabName);
                            fieldData.setIdentyId(identyId);
                            if (fData != null){
                                count += fieldDataMapper.updateFieldData(fieldData);
                            }else {
                                count += fieldDataMapper.addFieldData(fieldData);
                            }
                        }
                    }
                    if (count > 0){
                        json.setFlag(0);
                        json.setMsg("ok");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("修改失败:" + e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<FieldData> selectFieldDataByidentyId(String identyId,String tabName) {
        ToJson<FieldData> json = new ToJson<>(1, "error");
        try{
            List<FieldData> fieldData = fieldDataMapper.selectFieldDataByidentyId(identyId,tabName);
            json.setObject(fieldData);
            json.setFlag(0);
            json.setMsg("OK");
        }catch (Exception e){
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }
}
