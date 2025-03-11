package com.xoa.controller.extfield;

import com.xoa.model.extfield.FieldSet;
import com.xoa.service.extfield.FieldSetService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@RequestMapping("/fieldSet")
public class FieldSetController {
    @Resource
    private FieldSetService fieldSetService;

    @RequestMapping("/customField")
    public String customField(HttpServletRequest request) {
        return "app/sys/customField";
    }

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/2/24
     * 方法介绍:    新建自定义字段
     * 参数说明:    [fieldSet]
     * 返回值说明:   com.xoa.util.ToJson<com.xoa.model.extfield.FieldSet>
     */
    @ResponseBody
    @RequestMapping("/addFieldSet")
    public ToJson<FieldSet> addFieldSet(FieldSet fieldSet) {
        return fieldSetService.addFieldSet(fieldSet);
    }

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/2/24
     * 方法介绍:    删除自定义字段
     * 参数说明:    [fieldNo]
     * 返回值说明:   com.xoa.util.ToJson<com.xoa.model.extfield.FieldSet>
     */
    @ResponseBody
    @RequestMapping("/deleteFieldSet")
    public ToJson<FieldSet> deleteFieldSet(String tabName, String fieldNo) {
        return fieldSetService.deleteFieldSet(tabName, fieldNo);
    }

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/2/24
     * 方法介绍:    修改自定义字段
     * 参数说明:    [fieldSet]
     * 返回值说明:   com.xoa.util.ToJson<com.xoa.model.extfield.FieldSet>
     */
    @ResponseBody
    @RequestMapping("/updateFieldSet")
    public ToJson<FieldSet> updateFieldSet(FieldSet fieldSet) {
        return fieldSetService.updateFieldSet(fieldSet);
    }

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/2/24
     * 方法介绍:    查询子级自定义字段
     * 参数说明:    [request, map, page, limit, useFlag, fieldSet]
     * 返回值说明:   com.xoa.util.ToJson<com.xoa.model.extfield.FieldSet>
     */
    @ResponseBody
    @RequestMapping("/selectFieldSet")
    public ToJson<FieldSet> selectFieldSet(HttpServletRequest request, Map<String, Object> map, Integer page, Integer limit, boolean useFlag, String fieldNo,String tabName) {
        return fieldSetService.selectFieldSet(request, map, page, limit, useFlag, fieldNo,tabName);
    }

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/2/25
     * 方法介绍:    查询自定义字段及字段数据
     * 参数说明:    [tabName]
     * 返回值说明:   com.xoa.util.ToJson<com.xoa.model.extfield.FieldSet>
     */
    @ResponseBody
    @RequestMapping("/selectFieldSetAndData")
    public ToJson<FieldSet> selectFieldSetAndData(String tabName, String identyId) {
        return fieldSetService.selectFieldSetAndData(tabName, identyId);
    }

}
