package com.xoa.controller.extfield;

import com.xoa.model.extfield.FieldData;
import com.xoa.service.extfield.FieldDataService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/fieldData")
public class FieldDataController {
    @Resource
    private FieldDataService fieldDataService;

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/2/25
     * 方法介绍:    存储自定义字段的值
     * 参数说明:    [tabName, identyId, strJson]
     * 返回值说明:   com.xoa.util.ToJson<com.xoa.model.extfield.FieldData>
     */
    @ResponseBody
    @RequestMapping("/updateFieldData")
    public ToJson<FieldData> updateFieldData(String tabName, String identyId, String strJson) {
        return fieldDataService.updateFieldData(tabName, identyId, strJson);
    }

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/2/25
     * 方法介绍:    存储自定义字段的值
     * 参数说明:    [tabName, identyId, strJson]
     * 返回值说明:   com.xoa.util.ToJson<com.xoa.model.extfield.FieldData>
     */
    @ResponseBody
    @RequestMapping("/selectFieldDataByidentyId")
    public ToJson<FieldData> selectFieldDataByidentyId(String identyId,String tabName) {
        return fieldDataService.selectFieldDataByidentyId(identyId,tabName);
    }

}
