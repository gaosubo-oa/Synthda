package com.xoa.service.extfield.impl;

import com.xoa.dao.extfield.FieldDataMapper;
import com.xoa.dao.extfield.FieldSetMapper;
import com.xoa.model.extfield.FieldData;
import com.xoa.model.extfield.FieldSet;
import com.xoa.service.extfield.FieldSetService;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FieldSetServiceImpl implements FieldSetService {
    @Resource
    private FieldSetMapper fieldSetMapper;
    @Resource
    private FieldDataMapper fieldDataMapper;

    @Override
    public ToJson<FieldSet> addFieldSet(FieldSet fieldSet) {
        ToJson<FieldSet> json = new ToJson<>(1, "error");
        try {
            if (fieldSet != null) {
                Map<String, Object> map = new HashMap<>();
                map.put("tabName", fieldSet.getTabName());
                map.put("fieldName", fieldSet.getFieldName());
                //先判断字段名是否重复
                if (!StringUtils.isEmpty(fieldSet.getTabName()) && !StringUtils.isEmpty(fieldSet.getFieldName())){
                    int count = fieldSetMapper.selectIsRepeatFieldName(map);
                    if (count > 0){
                        json.setMsg("字段名称重复！");
                        return json;
                    }
                }

                //设置自定义字段
                map.put("fieldNo", "USERDEF");
                String fieldNo = "USERDEF";
                String fieldNoMax = fieldSetMapper.selectMaxFieldNo(map);
                if (!StringUtils.isEmpty(fieldNoMax)) {
                    Integer no = Integer.parseInt(fieldNoMax.substring(7)) + 1;
                    if (no < 10){
                        fieldNoMax = "0" + no;
                    }else {
                        fieldNoMax = no.toString();
                    }
                } else {
                    fieldNoMax = "01";
                }
                fieldNo += fieldNoMax;
                fieldSet.setFieldNo(fieldNo);
                int count = fieldSetMapper.addFieldSet(fieldSet);
                if (count > 0) {
                    json.setFlag(0);
                    json.setMsg("ok");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("添加失败:" + e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<FieldSet> deleteFieldSet(String tabName, String fieldNo) {
        ToJson<FieldSet> json = new ToJson<>(1, "error");
        try {
            if (!StringUtils.isEmpty(tabName) && !StringUtils.isEmpty(fieldNo)) {
                int count = fieldSetMapper.deleteFieldSet(tabName, fieldNo);
                if (count > 0) {
                    json.setFlag(0);
                    json.setMsg("ok");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("删除失败:" + e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<FieldSet> updateFieldSet(FieldSet fieldSet) {
        ToJson<FieldSet> json = new ToJson<>(1, "error");
        try {
            if (fieldSet != null) {
                Map<String, Object> map = new HashMap<>();
                map.put("tabName", fieldSet.getTabName());
                map.put("fieldName", fieldSet.getFieldName());
                map.put("fieldNo", fieldSet.getFieldNo());
                //先判断字段名是否重复
                if (!StringUtils.isEmpty(fieldSet.getTabName()) && !StringUtils.isEmpty(fieldSet.getFieldName())){
                    int count = fieldSetMapper.selectIsRepeatFieldName(map);
                    if (count > 0){
                        json.setMsg("字段名称重复！");
                        return json;
                    }
                }
                int count = fieldSetMapper.updateFieldSet(fieldSet);
                if (count > 0) {
                    json.setFlag(0);
                    json.setMsg("ok");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("修改失败:" + e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<FieldSet> selectFieldSet(HttpServletRequest request, Map<String, Object> map, Integer page, Integer limit, boolean useFlag, String fieldNo,String tabName) {
        ToJson<FieldSet> json = new ToJson<>(1, "error");
        //分页
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(limit);
        pageParams.setUseFlag(useFlag);
        map.put("page", pageParams);
        if (!StringUtils.isEmpty(fieldNo)){
            map.put("fieldNo", fieldNo);
        }
        if (!StringUtils.isEmpty(tabName)){
            map.put("tabName", tabName);
        }
        try {
            List<FieldSet> list = fieldSetMapper.selectFieldSet(map);
            if (!CollectionUtils.isEmpty(list)){
                for (FieldSet fieldSet : list){
                    if (!StringUtils.isEmpty(fieldSet.getStype())){
                        if (fieldSet.getStype().equals("T")){
                            fieldSet.setStypeName("单行文本框");
                            continue;
                        }
                        if (fieldSet.getStype().equals("MT")){
                            fieldSet.setStypeName("多行文本框");
                            continue;
                        }
                        if (fieldSet.getStype().equals("S")){
                            fieldSet.setStypeName("下拉菜单");
                            continue;
                        }
                        if (fieldSet.getStype().equals("R")){
                            fieldSet.setStypeName("单选框");
                            continue;
                        }
                        if (fieldSet.getStype().equals("C")){
                            fieldSet.setStypeName("复选框");
                            continue;
                        }
                    }
                }
                json.setFlag(0);
                json.setMsg("ok");
                json.setObj(list);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("查询失败:" + e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<FieldSet> selectFieldSetAndData(String tabName, String identyId) {
        ToJson<FieldSet> json = new ToJson<>(1, "error");
        try {
            if (!StringUtils.isEmpty(tabName)) {
                Map<String, Object> map = new HashMap<>();
                map.put("tabName", tabName);
                List<FieldSet> fieldSetList = fieldSetMapper.selectFieldSet(map);
                if (!CollectionUtils.isEmpty(fieldSetList)) {
                    for (FieldSet fieldSet : fieldSetList) {
                        if (!StringUtils.isEmpty(fieldSet.getTabName()) && !StringUtils.isEmpty(fieldSet.getFieldNo()) && !StringUtils.isEmpty(identyId)) {
                            Map<String, Object> fieldDataMap = new HashMap<>();
                            fieldDataMap.put("tabName", fieldSet.getTabName());
                            fieldDataMap.put("fieldNo", fieldSet.getFieldNo());
                            fieldDataMap.put("identyId", identyId);
                            FieldData fieldData = fieldDataMapper.selectFieldData(fieldDataMap);
                            if (fieldData != null){
                                //存字段数据
                                if (!StringUtils.isEmpty(fieldData.getItemData())){
                                    fieldSet.setItemData(fieldData.getItemData());
                                }else {
                                    fieldSet.setItemData("");
                                }
                            }else {
                                fieldSet.setItemData("");
                            }
                        }
                    }
                    json.setFlag(0);
                    json.setMsg("ok");
                    json.setObj(fieldSetList);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("查询失败:" + e.getMessage());
        }
        return json;
    }
}
